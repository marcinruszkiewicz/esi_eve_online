defmodule Esi.ClientTest do
  use ExUnit.Case, async: false

  import Mock

  alias Esi.Client
  alias Esi.Error

  @user_agent Application.compile_env(:esi_eve_online, :user_agent, "EsiEveOnline-Test-Suite/1.0")

  describe "request/2" do
    test "successful GET request" do
      request_spec = %{
        url: "/alliances/1234",
        method: :get,
        args: [],
        response: [{200, :ok}],
        call: {Esi.Api.Alliance, :alliance}
      }

      mock_response = %Req.Response{
        status: 200,
        body: %{"name" => "Test Alliance"},
        headers: [{"content-type", "application/json"}]
      }

      with_mock Req, request: fn _opts -> {:ok, mock_response} end do
        assert {:ok, %{"name" => "Test Alliance"}} = Client.request(request_spec)

        assert_called(
          Req.request(
            method: :get,
            url: "https://esi.evetech.net/latest/alliances/1234",
            headers: [
              {"accept", "application/json"},
              {"content-type", "application/json"},
              {"user-agent", @user_agent}
            ],
            params: %{},
            receive_timeout: 30_000,
            retry: :transient,
            max_retries: 3
          )
        )
      end
    end

    test "successful POST request with body" do
      request_spec = %{
        url: "/universe/names",
        method: :post,
        args: [body: [1234, 5678]],
        response: [{200, :ok}],
        call: {Esi.Api.Universe, :names}
      }

      mock_response = %Req.Response{
        status: 200,
        body: [%{"id" => 1234, "name" => "Test"}],
        headers: []
      }

      with_mock Req, request: fn _opts -> {:ok, mock_response} end do
        assert {:ok, [%{"id" => 1234, "name" => "Test"}]} = Client.request(request_spec)

        assert_called(
          Req.request(
            method: :post,
            url: "https://esi.evetech.net/latest/universe/names",
            json: [1234, 5678],
            headers: [
              {"accept", "application/json"},
              {"content-type", "application/json"},
              {"user-agent", @user_agent}
            ],
            params: %{},
            receive_timeout: 30_000,
            retry: :transient,
            max_retries: 3
          )
        )
      end
    end

    test "request with authentication token" do
      request_spec = %{
        url: "/characters/1234/assets",
        method: :get,
        args: [character_id: 1234],
        response: [{200, :ok}],
        call: {Esi.Api.Character, :assets}
      }

      opts = [token: "test-token"]

      mock_response = %Req.Response{
        status: 200,
        body: [],
        headers: []
      }

      with_mock Req, request: fn _opts -> {:ok, mock_response} end do
        assert {:ok, []} = Client.request(request_spec, opts)

        assert_called(
          Req.request(
            method: :get,
            url: "https://esi.evetech.net/latest/characters/1234/assets",
            headers: [
              {"authorization", "Bearer test-token"},
              {"accept", "application/json"},
              {"content-type", "application/json"},
              {"user-agent", @user_agent}
            ],
            params: %{},
            receive_timeout: 30_000,
            retry: :transient,
            max_retries: 3
          )
        )
      end
    end

    test "request with custom options" do
      request_spec = %{
        url: "/status",
        method: :get,
        args: [],
        response: [{200, :ok}],
        call: {Esi.Api.Status, :status}
      }

      opts = [
        timeout: 60_000,
        retries: 5,
        user_agent: "CustomApp/1.0",
        base_url: "https://custom.api.com"
      ]

      mock_response = %Req.Response{status: 200, body: %{}, headers: []}

      with_mock Req, request: fn _opts -> {:ok, mock_response} end do
        Client.request(request_spec, opts)

        assert_called(
          Req.request(
            method: :get,
            url: "https://custom.api.com/status",
            headers: [
              {"accept", "application/json"},
              {"content-type", "application/json"},
              {"user-agent", "CustomApp/1.0"}
            ],
            params: %{},
            receive_timeout: 60_000,
            retry: :transient,
            max_retries: 5
          )
        )
      end
    end
  end

  describe "error handling" do
    test "handles 404 not found" do
      request_spec = %{
        url: "/characters/invalid",
        method: :get,
        args: [],
        response: [{200, :ok}],
        call: {Esi.Api.Character, :character}
      }

      mock_response = %Req.Response{
        status: 404,
        body: %{"error" => "Character not found"},
        headers: [{"x-esi-request-id", "req-123"}]
      }

      with_mock Req, request: fn _opts -> {:ok, mock_response} end do
        assert {:error, error} = Client.request(request_spec, [])

        assert %Error{
                 type: :api_error,
                 status: 404,
                 message: "Not found",
                 request_id: "req-123"
               } = error
      end
    end

    test "handles 401 unauthorized" do
      request_spec = %{
        url: "/characters/1234/mail",
        method: :get,
        args: [],
        response: [{200, :ok}],
        call: {Esi.Api.Character, :mail}
      }

      mock_response = %Req.Response{
        status: 401,
        body: %{"error" => "Invalid token"},
        headers: []
      }

      with_mock Req, request: fn _opts -> {:ok, mock_response} end do
        assert {:error, error} = Client.request(request_spec, [])

        assert %Error{
                 type: :api_error,
                 status: 401,
                 message: "Unauthorized - invalid or expired token"
               } = error
      end
    end

    test "handles 420 error limited with retry-after" do
      request_spec = %{
        url: "/alliances",
        method: :get,
        args: [],
        response: [{200, :ok}],
        call: {Esi.Api.Alliance, :alliances}
      }

      mock_response = %Req.Response{
        status: 420,
        body: %{"error" => "Error limited"},
        headers: [
          {"retry-after", "60"},
          {"x-esi-request-id", "req-456"}
        ]
      }

      with_mock Req, request: fn _opts -> {:ok, mock_response} end do
        assert {:error, error} = Client.request(request_spec, [])

        assert %Error{
                 type: :api_error,
                 status: 420,
                 message: "Error limited - too many requests",
                 retry_after: 60,
                 request_id: "req-456"
               } = error
      end
    end

    test "handles network timeout" do
      request_spec = %{
        url: "/status",
        method: :get,
        args: [],
        response: [{200, :ok}],
        call: {Esi.Api.Status, :status}
      }

      with_mock Req, request: fn _opts -> {:error, %Req.TransportError{reason: :timeout}} end do
        assert {:error, error} = Client.request(request_spec, [])

        assert %Error{
                 type: :timeout_error,
                 message: "Request timed out"
               } = error
      end
    end

    test "handles network connection error" do
      request_spec = %{
        url: "/status",
        method: :get,
        args: [],
        response: [{200, :ok}],
        call: {Esi.Api.Status, :status}
      }

      with_mock Req, request: fn _opts -> {:error, %Req.TransportError{reason: :econnrefused}} end do
        assert {:error, error} = Client.request(request_spec, [])

        assert %Error{
                 type: :network_error,
                 message: "Network error: :econnrefused"
               } = error
      end
    end

    test "handles unexpected errors" do
      request_spec = %{
        url: "/status",
        method: :get,
        args: [],
        response: [{200, :ok}],
        call: {Esi.Api.Status, :status}
      }

      with_mock Req, request: fn _opts -> raise "Something went wrong" end do
        assert {:error, error} = Client.request(request_spec, [])

        assert %Error{
                 type: :network_error,
                 message: "Unexpected error: %RuntimeError{message: \"Something went wrong\"}"
               } = error
      end
    end

    test "handles unexpected non-transport errors" do
      request_spec = %{
        url: "/status",
        method: :get,
        args: [],
        response: [{200, :ok}],
        call: {Esi.Api.Status, :status}
      }

      with_mock Req, request: fn _opts -> {:error, "some other error"} end do
        assert {:error, error} = Client.request(request_spec, [])

        assert %Error{
                 type: :network_error,
                 message: "Request failed: \"some other error\""
               } = error
      end
    end

    defp make_request_spec(response_spec) do
      %{
        url: "/test",
        method: :get,
        args: [],
        response: response_spec,
        call: {Esi.ClientTest, :test}
      }
    end

    test "handles integer list response" do
      request_spec = make_request_spec([{200, [:integer]}])
      mock_response = %Req.Response{status: 200, body: [1, 2, 3], headers: []}

      with_mock Req, request: fn _ -> {:ok, mock_response} end do
        assert {:ok, [1, 2, 3]} = Client.request(request_spec)
      end
    end

    test "handles other response types" do
      request_spec = make_request_spec([{200, :string}])
      mock_response = %Req.Response{status: 200, body: "a string", headers: []}

      with_mock Req, request: fn _ -> {:ok, mock_response} end do
        assert {:ok, "a string"} = Client.request(request_spec)
      end
    end

    test "handles default response spec" do
      request_spec = make_request_spec([{:default, :ok}])
      mock_response = %Req.Response{status: 200, body: "default", headers: []}

      with_mock Req, request: fn _ -> {:ok, mock_response} end do
        assert {:ok, "default"} = Client.request(request_spec)
      end
    end

    test "handles simple default response spec" do
      request_spec = make_request_spec([:default])
      mock_response = %Req.Response{status: 200, body: "simple default", headers: []}

      with_mock Req, request: fn _ -> {:ok, mock_response} end do
        assert {:ok, "simple default"} = Client.request(request_spec)
      end
    end

    test "handles no matching response spec" do
      request_spec = make_request_spec([])
      mock_response = %Req.Response{status: 200, body: "no spec", headers: []}

      with_mock Req, request: fn _ -> {:ok, mock_response} end do
        assert {:ok, "no spec"} = Client.request(request_spec)
      end
    end

    test "handles response with a struct" do
      request_spec = make_request_spec([{200, {Esi.Error, :t}}])
      mock_response = %Req.Response{status: 200, body: %{"error" => "test"}, headers: []}

      with_mock Req, request: fn _ -> {:ok, mock_response} end do
        assert {:ok, %{"error" => "test"}} = Client.request(request_spec)
      end
    end

    test "handles 400 bad request" do
      request_spec = make_request_spec([])
      mock_response = %Req.Response{status: 400, body: %{"error" => "bad request"}, headers: []}

      with_mock Req, request: fn _ -> {:ok, mock_response} end do
        assert {:error, %Error{type: :validation_error, message: "bad request"}} =
                 Client.request(request_spec)
      end
    end

    test "handles 403 forbidden" do
      request_spec = make_request_spec([])
      mock_response = %Req.Response{status: 403, body: %{}, headers: []}

      with_mock Req, request: fn _ -> {:ok, mock_response} end do
        assert {:error, %Error{type: :api_error, status: 403}} = Client.request(request_spec)
      end
    end

    test "handles 500 internal server error" do
      request_spec = make_request_spec([])
      mock_response = %Req.Response{status: 500, body: %{}, headers: []}

      with_mock Req, request: fn _ -> {:ok, mock_response} end do
        assert {:error, %Error{type: :api_error, status: 500}} = Client.request(request_spec)
      end
    end

    test "handles 502 bad gateway" do
      request_spec = make_request_spec([])
      mock_response = %Req.Response{status: 502, body: %{}, headers: []}

      with_mock Req, request: fn _ -> {:ok, mock_response} end do
        assert {:error, %Error{type: :api_error, status: 502}} = Client.request(request_spec)
      end
    end

    test "handles 503 service unavailable" do
      request_spec = make_request_spec([])
      mock_response = %Req.Response{status: 503, body: %{}, headers: []}

      with_mock Req, request: fn _ -> {:ok, mock_response} end do
        assert {:error, %Error{type: :api_error, status: 503}} = Client.request(request_spec)
      end
    end

    test "handles other error with message" do
      request_spec = make_request_spec([])

      mock_response = %Req.Response{status: 418, body: %{"error" => "I'm a teapot"}, headers: []}

      with_mock Req, request: fn _ -> {:ok, mock_response} end do
        assert {:error, %Error{type: :api_error, status: 418, message: "I'm a teapot"}} =
                 Client.request(request_spec)
      end
    end

    test "handles other error without message" do
      request_spec = make_request_spec([])
      mock_response = %Req.Response{status: 418, body: %{}, headers: []}

      with_mock Req, request: fn _ -> {:ok, mock_response} end do
        assert {:error, %Error{type: :http_error, status: 418}} = Client.request(request_spec)
      end
    end

    test "handles missing retry-after header" do
      request_spec = make_request_spec([])
      mock_response = %Req.Response{status: 420, body: %{}, headers: []}

      with_mock Req, request: fn _ -> {:ok, mock_response} end do
        assert {:error, %Error{retry_after: nil}} = Client.request(request_spec)
      end
    end

    test "handles invalid retry-after header" do
      request_spec = make_request_spec([])

      mock_response = %Req.Response{status: 420, body: %{}, headers: [{"retry-after", "invalid"}]}

      with_mock Req, request: fn _ -> {:ok, mock_response} end do
        assert {:error, %Error{retry_after: nil}} = Client.request(request_spec)
      end
    end
  end

  describe "path parameter substitution" do
    test "substitutes single path parameter" do
      request_spec = %{
        url: "/characters/{character_id}",
        method: :get,
        args: [character_id: 1234],
        response: [{200, :ok}],
        call: {Esi.Api.Character, :character}
      }

      mock_response = %Req.Response{status: 200, body: %{}, headers: []}

      with_mock Req,
        request: fn opts ->
          assert opts[:url] == "https://esi.evetech.net/latest/characters/1234"
          {:ok, mock_response}
        end do
        Client.request(request_spec)
      end
    end

    test "substitutes multiple path parameters" do
      request_spec = %{
        url: "/characters/{character_id}/mail/{mail_id}",
        method: :get,
        args: [character_id: 1234, mail_id: 5678],
        response: [{200, :ok}],
        call: {Esi.Api.Character, :mail_item}
      }

      mock_response = %Req.Response{status: 200, body: %{}, headers: []}

      with_mock Req,
        request: fn opts ->
          assert opts[:url] == "https://esi.evetech.net/latest/characters/1234/mail/5678"
          {:ok, mock_response}
        end do
        Client.request(request_spec)
      end
    end
  end

  describe "user agent handling" do
    test "returns error when user agent is not provided" do
      # Unload the application environment variable
      Application.put_env(:esi_eve_online, :user_agent, nil)

      request_spec = %{
        url: "/status",
        method: :get,
        args: [],
        response: [{200, :ok}],
        call: {Esi.Api.Status, :status}
      }

      assert {:error, error} = Client.request(request_spec, [])

      assert %Error{
               type: :validation_error,
               message: "A custom user agent is required. Please provide one in the request options or in your application config."
             } = error

      # Restore the application environment variable
      Application.put_env(:esi_eve_online, :user_agent, @user_agent)
    end
  end
end
