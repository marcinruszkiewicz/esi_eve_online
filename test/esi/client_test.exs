defmodule Esi.ClientTest do
  use ExUnit.Case, async: false

  import Mock

  alias Esi.Client
  alias Esi.Error

  describe "request/2" do
    test "successful GET request" do
      request_spec = %{
        args: [],
        call: {Esi.Api.Alliance, :alliance},
        method: :get,
        response: [{200, :ok}],
        url: "/alliances/1234"
      }

      mock_response = %Req.Response{
        body: %{"name" => "Test Alliance"},
        headers: [{"content-type", "application/json"}],
        status: 200
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
              {"user-agent",
               "EsiEveOnline/1.0 (+https://github.com/marcinruszkiewicz/esi_eve_online discord:saithir)"}
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
        args: [body: [1234, 5678]],
        call: {Esi.Api.Universe, :names},
        method: :post,
        response: [{200, :ok}],
        url: "/universe/names"
      }

      mock_response = %Req.Response{
        body: [%{"id" => 1234, "name" => "Test"}],
        headers: [],
        status: 200
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
              {"user-agent",
               "EsiEveOnline/1.0 (+https://github.com/marcinruszkiewicz/esi_eve_online discord:saithir)"}
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
        args: [character_id: 1234],
        call: {Esi.Api.Character, :assets},
        method: :get,
        response: [{200, :ok}],
        url: "/characters/1234/assets"
      }

      opts = [token: "test-token"]

      mock_response = %Req.Response{
        body: [],
        headers: [],
        status: 200
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
              {"user-agent",
               "EsiEveOnline/1.0 (+https://github.com/marcinruszkiewicz/esi_eve_online discord:saithir)"}
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
        args: [],
        call: {Esi.Api.Status, :status},
        method: :get,
        response: [{200, :ok}],
        url: "/status"
      }

      opts = [
        timeout: 60_000,
        retries: 5,
        user_agent: "CustomApp/1.0",
        base_url: "https://custom.api.com"
      ]

      mock_response = %Req.Response{body: %{}, headers: [], status: 200}

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
        args: [],
        call: {Esi.Api.Character, :character},
        method: :get,
        response: [{200, :ok}],
        url: "/characters/invalid"
      }

      mock_response = %Req.Response{
        body: %{"error" => "Character not found"},
        headers: [{"x-esi-request-id", "req-123"}],
        status: 404
      }

      with_mock Req, request: fn _opts -> {:ok, mock_response} end do
        assert {:error, error} = Client.request(request_spec, [])

        assert %Error{
                 message: "Character not found",
                 request_id: "req-123",
                 status: 404,
                 type: :api_error
               } = error
      end
    end

    test "handles 401 unauthorized" do
      request_spec = %{
        args: [],
        call: {Esi.Api.Character, :mail},
        method: :get,
        response: [{200, :ok}],
        url: "/characters/1234/mail"
      }

      mock_response = %Req.Response{
        body: %{"error" => "Invalid token"},
        headers: [],
        status: 401
      }

      with_mock Req, request: fn _opts -> {:ok, mock_response} end do
        assert {:error, error} = Client.request(request_spec, [])

        assert %Error{
                 message: "Invalid token",
                 status: 401,
                 type: :api_error
               } = error
      end
    end

    test "handles 420 error limited with retry-after" do
      request_spec = %{
        args: [],
        call: {Esi.Api.Alliance, :alliances},
        method: :get,
        response: [{200, :ok}],
        url: "/alliances"
      }

      mock_response = %Req.Response{
        body: %{"error" => "Error limited"},
        headers: [
          {"retry-after", "60"},
          {"x-esi-request-id", "req-456"}
        ],
        status: 420
      }

      with_mock Req, request: fn _opts -> {:ok, mock_response} end do
        assert {:error, error} = Client.request(request_spec, [])

        assert %Error{
                 message: "Error limited",
                 request_id: "req-456",
                 retry_after: 60,
                 status: 420,
                 type: :api_error
               } = error
      end
    end

    test "handles 503 maintenance with API error message" do
      request_spec = %{
        args: [],
        call: {Esi.Api.Status, :status},
        method: :get,
        response: [{200, :ok}],
        url: "/status"
      }

      mock_response = %Req.Response{
        body: %{"error" => "ESI is currently in maintenance mode. Please try again later."},
        headers: [],
        status: 503
      }

      with_mock Req, request: fn _opts -> {:ok, mock_response} end do
        assert {:error, error} = Client.request(request_spec, [])

        assert %Error{
                 message: "ESI is currently in maintenance mode. Please try again later.",
                 status: 503,
                 type: :api_error
               } = error
      end
    end

    test "handles network timeout" do
      request_spec = %{
        args: [],
        call: {Esi.Api.Status, :status},
        method: :get,
        response: [{200, :ok}],
        url: "/status"
      }

      with_mock Req, request: fn _opts -> {:error, %Req.TransportError{reason: :timeout}} end do
        assert {:error, error} = Client.request(request_spec, [])

        assert %Error{
                 message: "Request timed out",
                 type: :timeout_error
               } = error
      end
    end

    test "handles network connection error" do
      request_spec = %{
        args: [],
        call: {Esi.Api.Status, :status},
        method: :get,
        response: [{200, :ok}],
        url: "/status"
      }

      with_mock Req, request: fn _opts -> {:error, %Req.TransportError{reason: :econnrefused}} end do
        assert {:error, error} = Client.request(request_spec, [])

        assert %Error{
                 message: "Network error: :econnrefused",
                 type: :network_error
               } = error
      end
    end

    test "handles unexpected errors" do
      request_spec = %{
        args: [],
        call: {Esi.Api.Status, :status},
        method: :get,
        response: [{200, :ok}],
        url: "/status"
      }

      with_mock Req, request: fn _opts -> raise "Something went wrong" end do
        assert {:error, error} = Client.request(request_spec, [])

        assert %Error{
                 message: "Unexpected error: %RuntimeError{message: \"Something went wrong\"}",
                 type: :network_error
               } = error
      end
    end
  end

  describe "path parameter substitution" do
    test "substitutes single path parameter" do
      request_spec = %{
        args: [character_id: 1234],
        call: {Esi.Api.Character, :character},
        method: :get,
        response: [{200, :ok}],
        url: "/characters/{character_id}"
      }

      mock_response = %Req.Response{body: %{}, headers: [], status: 200}

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
        args: [character_id: 1234, mail_id: 5678],
        call: {Esi.Api.Character, :mail_item},
        method: :get,
        response: [{200, :ok}],
        url: "/characters/{character_id}/mail/{mail_id}"
      }

      mock_response = %Req.Response{body: %{}, headers: [], status: 200}

      with_mock Req,
        request: fn opts ->
          assert opts[:url] == "https://esi.evetech.net/latest/characters/1234/mail/5678"
          {:ok, mock_response}
        end do
        Client.request(request_spec)
      end
    end
  end
end
