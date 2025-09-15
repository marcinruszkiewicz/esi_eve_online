defmodule ESI.Test do
  use ExUnit.Case, async: true
  import Mock

  # Note: Doctests disabled since they require full API setup
  # doctest ESI

  describe "request/2" do
    test "executes a basic request successfully" do
      request = %ESI.Request{
        verb: :get,
        path: "/alliances/",
        opts_schema: %{datasource: {:query, :optional}}
      }

      with_mock EsiEveOnline, [get: fn(_path, _opts) -> {:ok, [99005443, 99005784]} end] do
        assert {:ok, [99005443, 99005784]} = ESI.request(request)
        assert called(EsiEveOnline.get("/alliances/", []))
      end
    end

    test "passes through options correctly" do
      request = %ESI.Request{
        verb: :get,
        path: "/characters/12345/",
        opts_schema: %{token: {:query, :optional}}
      }

      with_mock EsiEveOnline, [get: fn(_path, _opts) -> {:ok, %{"name" => "Test Character"}} end] do
        assert {:ok, _result} = ESI.request(request, token: "test_token")
        assert called(EsiEveOnline.get("/characters/12345/", [token: "test_token"]))
      end
    end

    test "handles POST requests with body" do
      request = %ESI.Request{
        verb: :post,
        path: "/universe/names/",
        opts_schema: %{ids: {:body, :required}},
        opts: %{ids: [12345, 67890]}
      }

      with_mock EsiEveOnline, [post: fn(_path, _body, _opts) -> {:ok, [%{"id" => 12345, "name" => "Test"}]} end] do
        assert {:ok, _result} = ESI.request(request)
        assert called(EsiEveOnline.post("/universe/names/", [12345, 67890], []))
      end
    end

    test "returns error when request fails" do
      request = %ESI.Request{
        verb: :get,
        path: "/invalid/",
        opts_schema: %{}
      }

      error = %Esi.Error{type: :api_error, status: 404, message: "Not found"}
      with_mock EsiEveOnline, [get: fn(_path, _opts) -> {:error, error} end] do
        assert {:error, ^error} = ESI.request(request)
      end
    end

    test "validates required options" do
      request = %ESI.Request{
        verb: :get,
        path: "/test/",
        opts_schema: %{required_param: {:query, :required}}
      }

      assert {:error, "missing option `:required_param`"} = ESI.request(request)
    end
  end

  describe "request!/2" do
    test "returns result directly on success" do
      request = %ESI.Request{
        verb: :get,
        path: "/alliances/",
        opts_schema: %{}
      }

      with_mock EsiEveOnline, [get: fn(_path, _opts) -> {:ok, [99005443]} end] do
        assert [99005443] = ESI.request!(request)
      end
    end

    test "raises error on failure" do
      request = %ESI.Request{
        verb: :get,
        path: "/invalid/",
        opts_schema: %{}
      }

      error = %Esi.Error{type: :api_error, status: 404, message: "Not found"}
      with_mock EsiEveOnline, [get: fn(_path, _opts) -> {:error, error} end] do
        assert_raise RuntimeError, "Request failed: Not found", fn ->
          ESI.request!(request)
        end
      end
    end
  end

  describe "request_with_headers/2" do
    test "returns data with max pages for paginated requests" do
      request = %ESI.Request{
        verb: :get,
        path: "/universe/groups/",
        opts_schema: %{page: {:query, :optional}}
      }

      with_mock EsiEveOnline, [get: fn(_path, _opts) -> {:ok, [1, 2, 3]} end] do
        assert {:ok, [1, 2, 3], 1} = ESI.request_with_headers(request)
      end
    end
  end

  describe "request_with_headers!/2" do
    test "returns tuple with data and max pages" do
      request = %ESI.Request{
        verb: :get,
        path: "/universe/groups/",
        opts_schema: %{}
      }

      with_mock EsiEveOnline, [get: fn(_path, _opts) -> {:ok, [1, 2, 3]} end] do
        assert {[1, 2, 3], 1} = ESI.request_with_headers!(request)
      end
    end

    test "raises error on failure" do
      request = %ESI.Request{
        verb: :get,
        path: "/invalid/",
        opts_schema: %{}
      }

      error = %Esi.Error{type: :api_error, status: 404, message: "Not found"}
      with_mock EsiEveOnline, [get: fn(_path, _opts) -> {:error, error} end] do
        assert_raise RuntimeError, "Request failed: Not found", fn ->
          ESI.request_with_headers!(request)
        end
      end
    end
  end

  describe "stream!/2" do
    test "creates stream for paginated endpoints" do
      request = %ESI.Request{
        verb: :get,
        path: "/universe/groups/",
        opts_schema: %{page: {:query, :optional}}
      }

      # Mock the paginated responses
      with_mock ESI.Request, [
        options: fn(req, opts) -> %{req | opts: Map.merge(req.opts, Map.new(opts))} end,
        run_with_headers: fn
          %{opts: %{page: 1}} -> {:ok, [1, 2, 3], 2}
          %{opts: %{page: 2}} -> {:ok, [4, 5, 6], 2}
        end,
        stream!: fn(_req) -> Stream.concat([[1, 2, 3], [4, 5, 6]]) end
      ] do
        stream = ESI.stream!(request)
        result = Enum.to_list(stream)
        assert result == [1, 2, 3, 4, 5, 6]
      end
    end

    test "creates stream for non-paginated endpoints" do
      request = %ESI.Request{
        verb: :get,
        path: "/universe/bloodlines/",
        opts_schema: %{}
      }

      with_mock ESI.Request, [
        options: fn(req, _opts) -> req end,
        run: fn(_req) -> {:ok, [:bloodline1, :bloodline2]} end,
        stream!: fn(_req) -> Stream.cycle([:bloodline1, :bloodline2]) |> Stream.take(2) end
      ] do
        stream = ESI.stream!(request)
        result = Enum.to_list(stream)
        assert result == [:bloodline1, :bloodline2]
      end
    end

    test "raises error when stream encounters failure" do
      request = %ESI.Request{
        verb: :get,
        path: "/invalid/",
        opts_schema: %{}
      }

      with_mock ESI.Request, [
        options: fn(req, _opts) -> req end,
        run: fn(_req) -> {:error, "API error"} end,
        stream!: fn(_req) -> 
          Stream.resource(
            fn -> :start end,
            fn :start -> raise RuntimeError, "Request failed: \"API error\"" end,
            fn _ -> :ok end
          )
        end
      ] do
        stream = ESI.stream!(request)
        assert_raise RuntimeError, "Request failed: \"API error\"", fn ->
          Enum.to_list(stream)
        end
      end
    end
  end

  describe "legacy API pattern compatibility" do
    test "supports the full legacy pattern ESI.API.Module.function() |> ESI.request()" do
      # Test the complete legacy pattern
      with_mock EsiEveOnline, [get: fn(_path, _opts) -> {:ok, [99005443]} end] do
        result = ESI.API.Alliance.alliances() |> ESI.request()
        assert {:ok, [99005443]} = result
      end
    end

    test "supports the legacy pattern with options" do
      with_mock EsiEveOnline, [get: fn(_path, _opts) -> {:ok, %{"name" => "Test Character"}} end] do
        result = ESI.API.Character.character(12345) |> ESI.request(token: "test_token")
        assert {:ok, %{"name" => "Test Character"}} = result
      end
    end

    test "supports the legacy stream pattern" do
      request = %ESI.Request{
        verb: :get,
        path: "/universe/groups/",
        opts_schema: %{page: {:query, :optional}}
      }

      with_mock ESI.Request, [
        options: fn(req, _opts) -> req end,
        stream!: fn(_req) -> [1, 2, 3, 4, 5] end
      ] do
        # Simulate: ESI.API.Universe.groups() |> ESI.stream!() |> Enum.take(3)
        result = request |> ESI.stream!() |> Enum.take(3)
        assert result == [1, 2, 3]
      end
    end
  end
end
