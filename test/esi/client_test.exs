defmodule Esi.ClientTest do
  use ExUnit.Case, async: false
  import Mock

  alias Esi.Client
  alias Esi.Error

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
end
