defmodule ESI.RequestTest do
  use ExUnit.Case, async: false
  import Mock

  doctest ESI.Request

  describe "struct creation" do
    test "creates a basic request struct" do
      request = %ESI.Request{
        verb: :get,
        path: "/test/",
        opts_schema: %{},
        opts: %{}
      }

      assert request.verb == :get
      assert request.path == "/test/"
      assert request.opts_schema == %{}
      assert request.opts == %{}
    end

    test "enforces required keys" do
      assert_raise ArgumentError, fn ->
        struct!(ESI.Request, %{})
      end
    end
  end

  describe "options/2" do
    test "adds options to request" do
      request = %ESI.Request{
        verb: :get,
        path: "/test/",
        opts_schema: %{},
        opts: %{}
      }

      updated = ESI.Request.options(request, token: "test_token", page: 1)
      assert updated.opts == %{token: "test_token", page: 1}
    end

    test "merges with existing options" do
      request = %ESI.Request{
        verb: :get,
        path: "/test/",
        opts_schema: %{},
        opts: %{existing: "value"}
      }

      updated = ESI.Request.options(request, token: "test_token")
      assert updated.opts == %{existing: "value", token: "test_token"}
    end

    test "handles empty options list" do
      request = %ESI.Request{
        verb: :get,
        path: "/test/",
        opts_schema: %{},
        opts: %{existing: "value"}
      }

      updated = ESI.Request.options(request, [])
      assert updated.opts == %{existing: "value"}
    end
  end

  describe "validate/1" do
    test "returns :ok when all required options are present" do
      request = %ESI.Request{
        verb: :get,
        path: "/test/",
        opts_schema: %{required_param: {:query, :required}},
        opts: %{required_param: "value"}
      }

      assert ESI.Request.validate(request) == :ok
    end

    test "returns error for single missing required option" do
      request = %ESI.Request{
        verb: :get,
        path: "/test/",
        opts_schema: %{required_param: {:query, :required}},
        opts: %{}
      }

      assert ESI.Request.validate(request) == {:error, "missing option `:required_param`"}
    end

    test "returns error for multiple missing required options" do
      request = %ESI.Request{
        verb: :get,
        path: "/test/",
        opts_schema: %{
          param1: {:query, :required},
          param2: {:body, :required}
        },
        opts: %{}
      }

      assert {:error, error_msg} = ESI.Request.validate(request)
      assert error_msg =~ "missing options"
      assert error_msg =~ ":param1"
      assert error_msg =~ ":param2"
    end

    test "ignores optional parameters" do
      request = %ESI.Request{
        verb: :get,
        path: "/test/",
        opts_schema: %{
          required_param: {:query, :required},
          optional_param: {:query, :optional}
        },
        opts: %{required_param: "value"}
      }

      assert ESI.Request.validate(request) == :ok
    end
  end

  describe "run/1" do
    test "calls EsiEveOnline.get for GET requests" do
      request = %ESI.Request{
        verb: :get,
        path: "/test/",
        opts_schema: %{},
        opts: %{token: "test_token"}
      }

      with_mock EsiEveOnline, [get: fn(_path, _opts) -> {:ok, "success"} end] do
        assert {:ok, "success"} = ESI.Request.run(request)
        assert called(EsiEveOnline.get("/test/", [token: "test_token"]))
      end
    end

    test "calls EsiEveOnline.post for POST requests" do
      request = %ESI.Request{
        verb: :post,
        path: "/test/",
        opts_schema: %{data: {:body, :required}},
        opts: %{data: %{"test" => "value"}}
      }

      with_mock EsiEveOnline, [post: fn(_path, _body, _opts) -> {:ok, "success"} end] do
        assert {:ok, "success"} = ESI.Request.run(request)
        assert called(EsiEveOnline.post("/test/", %{"test" => "value"}, []))
      end
    end

    test "calls EsiEveOnline.put for PUT requests" do
      request = %ESI.Request{
        verb: :put,
        path: "/test/",
        opts_schema: %{data: {:body, :required}},
        opts: %{data: %{"test" => "value"}}
      }

      with_mock EsiEveOnline, [put: fn(_path, _body, _opts) -> {:ok, "success"} end] do
        assert {:ok, "success"} = ESI.Request.run(request)
        assert called(EsiEveOnline.put("/test/", %{"test" => "value"}, []))
      end
    end

    test "calls EsiEveOnline.delete for DELETE requests" do
      request = %ESI.Request{
        verb: :delete,
        path: "/test/",
        opts_schema: %{},
        opts: %{token: "test_token"}
      }

      with_mock EsiEveOnline, [delete: fn(_path, _opts) -> {:ok, "success"} end] do
        assert {:ok, "success"} = ESI.Request.run(request)
        assert called(EsiEveOnline.delete("/test/", [token: "test_token"]))
      end
    end

    test "returns validation error for invalid request" do
      request = %ESI.Request{
        verb: :get,
        path: "/test/",
        opts_schema: %{required_param: {:query, :required}},
        opts: %{}
      }

      assert {:error, "missing option `:required_param`"} = ESI.Request.run(request)
    end
  end

  describe "option mapping" do
    test "maps legacy token option to client option" do
      request = %ESI.Request{
        verb: :get,
        path: "/test/",
        opts_schema: %{},
        opts: %{token: "test_token", user_agent: "TestAgent/1.0"}
      }

      with_mock EsiEveOnline, [get: fn(_path, opts) -> 
        assert Keyword.get(opts, :token) == "test_token"
        assert Keyword.get(opts, :user_agent) == "TestAgent/1.0"
        {:ok, "success"}
      end] do
        ESI.Request.run(request)
      end
    end

    test "filters out datasource option" do
      request = %ESI.Request{
        verb: :get,
        path: "/test/",
        opts_schema: %{},
        opts: %{datasource: :tranquility, token: "test_token"}
      }

      with_mock EsiEveOnline, [get: fn(_path, opts) -> 
        assert Keyword.get(opts, :token) == "test_token"
        assert Keyword.get(opts, :datasource) == nil
        {:ok, "success"}
      end] do
        ESI.Request.run(request)
      end
    end

    test "extracts body from body-type options" do
      request = %ESI.Request{
        verb: :post,
        path: "/test/",
        opts_schema: %{
          data: {:body, :required},
          token: {:query, :optional}
        },
        opts: %{data: [1, 2, 3], token: "test_token"}
      }

      with_mock EsiEveOnline, [post: fn(_path, body, opts) -> 
        assert body == [1, 2, 3]
        assert Keyword.get(opts, :token) == "test_token"
        {:ok, "success"}
      end] do
        ESI.Request.run(request)
      end
    end
  end

  describe "stream!/1" do
    test "creates paginated stream for requests with page option" do
      request = %ESI.Request{
        verb: :get,
        path: "/test/",
        opts_schema: %{page: {:query, :optional}},
        opts: %{}
      }

      # Mock run_with_headers to simulate pagination
      with_mock ESI.Request, [
        run_with_headers: fn
          %{opts: %{page: 1}} -> {:ok, [1, 2, 3], 2}
          %{opts: %{page: 2}} -> {:ok, [4, 5, 6], 2}
        end,
        stream!: fn(_req) -> Stream.concat([[1, 2, 3], [4, 5, 6]]) end,
        options: fn(req, opts) -> %{req | opts: Map.merge(req.opts, Map.new(opts))} end
      ] do
        stream = ESI.Request.stream!(request)
        result = Enum.to_list(stream)
        assert result == [1, 2, 3, 4, 5, 6]
      end
    end

    test "creates single-result stream for non-paginated requests" do
      request = %ESI.Request{
        verb: :get,
        path: "/test/",
        opts_schema: %{},
        opts: %{}
      }

      with_mock ESI.Request, [
        run: fn(_req) -> {:ok, [:result1, :result2]} end,
        stream!: fn(_req) -> Stream.cycle([:result1, :result2]) |> Stream.take(2) end
      ] do
        stream = ESI.Request.stream!(request)
        result = Enum.to_list(stream)
        assert result == [:result1, :result2]
      end
    end

    test "stops pagination when empty page is returned" do
      request = %ESI.Request{
        verb: :get,
        path: "/test/",
        opts_schema: %{page: {:query, :optional}},
        opts: %{}
      }

      with_mock ESI.Request, [
        run_with_headers: fn
          %{opts: %{page: 1}} -> {:ok, [1, 2, 3], 2}
          %{opts: %{page: 2}} -> {:ok, [], 2}
        end,
        stream!: fn(_req) -> Stream.take([1, 2, 3], 3) end,
        options: fn(req, opts) -> %{req | opts: Map.merge(req.opts, Map.new(opts))} end
      ] do
        stream = ESI.Request.stream!(request)
        result = Enum.to_list(stream)
        assert result == [1, 2, 3]
      end
    end

    test "raises error when pagination fails" do
      request = %ESI.Request{
        verb: :get,
        path: "/test/",
        opts_schema: %{page: {:query, :optional}},
        opts: %{}
      }

      with_mock ESI.Request, [
        run_with_headers: fn(_req) -> {:error, "API error"} end,
        stream!: fn(_req) -> 
          Stream.resource(
            fn -> :start end,
            fn :start -> raise RuntimeError, "Request failed: API error" end,
            fn _ -> :ok end
          )
        end,
        options: fn(req, opts) -> %{req | opts: Map.merge(req.opts, Map.new(opts))} end
      ] do
        stream = ESI.Request.stream!(request)
        assert_raise RuntimeError, ~r/Request failed/, fn ->
          Enum.to_list(stream)
        end
      end
    end
  end
end
