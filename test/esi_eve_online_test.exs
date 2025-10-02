defmodule EsiEveOnlineTest do
  use ExUnit.Case, async: false

  import Mock

  alias Esi.Client
  alias Esi.Error

  describe "unified HTTP interface" do
    test "get/2 makes GET request" do
      mock_response = {:ok, %{"name" => "Test Alliance"}}

      with_mock Client, request: fn _spec, _opts -> mock_response end do
        assert {:ok, %{"name" => "Test Alliance"}} = EsiEveOnline.get("/alliances/1234")

        assert_called(
          Client.request(
            %{
              args: [],
              call: {EsiEveOnline, :get},
              method: :get,
              response: [{200, :ok}, {:default, {Esi.Error, :t}}],
              url: "/alliances/1234"
            },
            []
          )
        )
      end
    end

    test "get/2 with options" do
      mock_response = {:ok, []}

      with_mock Client,
        request: fn _spec, opts ->
          assert opts == [token: "test-token", timeout: 60_000]
          mock_response
        end do
        opts = [token: "test-token", timeout: 60_000]
        EsiEveOnline.get("/characters/1234/assets", opts)
      end
    end

    test "post/3 makes POST request with body" do
      mock_response = {:ok, [%{"id" => 1234, "name" => "Test"}]}

      with_mock Client,
        request: fn spec, _opts ->
          assert spec.method == :post
          assert spec.args == [body: [1234, 5678]]
          mock_response
        end do
        assert {:ok, [%{"id" => 1234, "name" => "Test"}]} =
                 EsiEveOnline.post("/universe/names", [1234, 5678])
      end
    end

    test "put/3 makes PUT request" do
      mock_response = {:ok, :ok}

      with_mock Client,
        request: fn spec, _opts ->
          assert spec.method == :put
          assert spec.args == [body: %{"setting" => "value"}]
          mock_response
        end do
        EsiEveOnline.put("/characters/1234/settings", %{"setting" => "value"})
      end
    end

    test "delete/2 makes DELETE request" do
      mock_response = {:ok, :ok}

      with_mock Client,
        request: fn spec, _opts ->
          assert spec.method == :delete
          assert spec.args == []
          mock_response
        end do
        EsiEveOnline.delete("/characters/1234/contacts/5678")
      end
    end

    test "patch/3 makes PATCH request" do
      mock_response = {:ok, :ok}

      with_mock Client,
        request: fn spec, _opts ->
          assert spec.method == :patch
          assert spec.args == [body: %{"update" => "data"}]
          mock_response
        end do
        EsiEveOnline.patch("/characters/1234/profile", %{"update" => "data"})
      end
    end
  end

  describe "bang functions" do
    test "get!/2 returns result on success" do
      with_mock Client, request: fn _spec, _opts -> {:ok, %{"result" => "data"}} end do
        assert %{"result" => "data"} = EsiEveOnline.get!("/test")
      end
    end

    test "get!/2 raises on error" do
      error = %Error{message: "Not found", status: 404, type: :api_error}

      with_mock Client, request: fn _spec, _opts -> {:error, error} end do
        assert_raise RuntimeError, "API request failed: Not found", fn ->
          EsiEveOnline.get!("/invalid")
        end
      end
    end

    test "post!/3 returns result on success" do
      with_mock Client, request: fn _spec, _opts -> {:ok, []} end do
        assert [] = EsiEveOnline.post!("/universe/names", [1234])
      end
    end

    test "post!/3 raises on error" do
      error = %Error{message: "Invalid input", type: :validation_error}

      with_mock Client, request: fn _spec, _opts -> {:error, error} end do
        assert_raise RuntimeError, "API request failed: Invalid input", fn ->
          EsiEveOnline.post!("/universe/names", "invalid")
        end
      end
    end

    test "put!/3 raises on error" do
      error = %Error{message: "Forbidden", status: 403, type: :api_error}

      with_mock Client, request: fn _spec, _opts -> {:error, error} end do
        assert_raise RuntimeError, "API request failed: Forbidden", fn ->
          EsiEveOnline.put!("/characters/1234/settings", %{})
        end
      end
    end

    test "delete!/2 raises on error" do
      error = %Error{message: "Connection failed", type: :network_error}

      with_mock Client, request: fn _spec, _opts -> {:error, error} end do
        assert_raise RuntimeError, "API request failed: Connection failed", fn ->
          EsiEveOnline.delete!("/characters/1234/contacts/5678")
        end
      end
    end

    test "patch!/3 raises on error" do
      error = %Error{message: "Request timed out", type: :timeout_error}

      with_mock Client, request: fn _spec, _opts -> {:error, error} end do
        assert_raise RuntimeError, "API request failed: Request timed out", fn ->
          EsiEveOnline.patch!("/characters/1234/profile", %{})
        end
      end
    end
  end

  describe "request delegation" do
    test "delegates request/2 to Client" do
      request_spec = %{
        args: [],
        call: {TestModule, :test},
        method: :get,
        response: [{200, :ok}],
        url: "/test"
      }

      opts = [token: "test"]
      mock_response = {:ok, "result"}

      with_mock Client,
        request: fn spec, options ->
          assert spec == request_spec
          assert options == opts
          mock_response
        end do
        assert {:ok, "result"} = EsiEveOnline.request(request_spec, opts)
      end
    end

    test "delegates request/1 to Client with empty opts" do
      request_spec = %{
        args: [],
        call: {TestModule, :test},
        method: :get,
        response: [],
        url: "/test"
      }

      mock_response = {:ok, "result"}

      with_mock Client,
        request: fn spec, options ->
          assert spec == request_spec
          assert options == []
          mock_response
        end do
        assert {:ok, "result"} = EsiEveOnline.request(request_spec)
      end
    end
  end
end
