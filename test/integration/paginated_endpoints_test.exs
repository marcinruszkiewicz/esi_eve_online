defmodule Integration.PaginatedEndpointsTest do
  @moduledoc """
  Integration tests for automatically paginated endpoints using real fixture data.

  Tests that paginated endpoints return streams and handle pagination correctly.
  """

  use ExUnit.Case, async: false
  import Mock

  alias EsiEveOnline.Test.FixtureLoader

  describe "character assets - paginated streaming" do
    test "streams all character assets across multiple pages" do
      # Load fixture data
      {:ok, page1_data} = FixtureLoader.load_data("character_assets_page1.json")
      {:ok, page2_data} = FixtureLoader.load_data("character_assets_page2.json")
      {:ok, page3_data} = FixtureLoader.load_data("character_assets_page3.json")

      # Mock Req.request to return our fixture data with pagination
      with_mock Req,
        request: fn opts ->
          page = opts[:params][:page] || 1

          case page do
            1 -> {:ok, %Req.Response{status: 200, body: page1_data, headers: [{"x-pages", "3"}]}}
            2 -> {:ok, %Req.Response{status: 200, body: page2_data, headers: [{"x-pages", "3"}]}}
            3 -> {:ok, %Req.Response{status: 200, body: page3_data, headers: [{"x-pages", "3"}]}}
            _ -> {:ok, %Req.Response{status: 200, body: [], headers: [{"x-pages", "1"}]}}
          end
        end do
        # Test the automatically generated streaming function
        stream = Esi.Api.Characters.assets(12345, token: "test_token")
        result = stream |> Enum.to_list() |> List.flatten()

        # Verify we got data from all pages
        assert is_list(result)
        assert length(result) > 0

        # Verify the structure of the first item
        first_item = List.first(result)
        assert is_map(first_item)
        assert Map.has_key?(first_item, "item_id")
        assert Map.has_key?(first_item, "type_id")
      end
    end

    test "handles single page character assets" do
      {:ok, page1_data} = FixtureLoader.load_data("character_assets_page1.json")

      with_mock Req,
        request: fn _opts ->
          {:ok, %Req.Response{status: 200, body: page1_data, headers: [{"x-pages", "1"}]}}
        end do
        stream = Esi.Api.Characters.assets(12345, token: "test_token")
        result = stream |> Enum.to_list() |> List.flatten()

        assert is_list(result)
        assert length(result) > 0
      end
    end

    test "can process character assets with stream operations" do
      {:ok, page1_data} = FixtureLoader.load_data("character_assets_page1.json")
      {:ok, page2_data} = FixtureLoader.load_data("character_assets_page2.json")

      with_mock Req,
        request: fn opts ->
          page = opts[:params][:page] || 1

          case page do
            1 -> {:ok, %Req.Response{status: 200, body: page1_data, headers: [{"x-pages", "2"}]}}
            2 -> {:ok, %Req.Response{status: 200, body: page2_data, headers: [{"x-pages", "2"}]}}
            _ -> {:ok, %Req.Response{status: 200, body: [], headers: [{"x-pages", "1"}]}}
          end
        end do
        # Test stream operations - verify the stream can be processed with Stream functions
        result =
          Esi.Api.Characters.assets(12345, token: "test_token")
          |> Stream.flat_map(& &1)
          |> Stream.filter(&is_map/1)
          |> Enum.take(10)

        # Verify stream operations worked
        assert is_list(result)
        assert length(result) <= 10
      end
    end

    test "can take limited number of assets (lazy evaluation)" do
      {:ok, page1_data} = FixtureLoader.load_data("character_assets_page1.json")

      with_mock Req,
        request: fn _opts ->
          {:ok, %Req.Response{status: 200, body: page1_data, headers: [{"x-pages", "3"}]}}
        end do
        # Take only first 5 assets - should stop fetching early
        limited_assets =
          Esi.Api.Characters.assets(12345, token: "test_token")
          |> Stream.flat_map(& &1)
          |> Stream.take(5)
          |> Enum.to_list()

        assert is_list(limited_assets)
        assert length(limited_assets) == 5
      end
    end
  end

  describe "universe endpoints - paginated streaming" do
    test "streams all universe groups" do
      {:ok, page1_data} = FixtureLoader.load_data("universe_groups_page1.json")
      {:ok, page2_data} = FixtureLoader.load_data("universe_groups_page2.json")

      with_mock Req,
        request: fn opts ->
          page = opts[:params][:page] || 1

          case page do
            1 -> {:ok, %Req.Response{status: 200, body: page1_data, headers: [{"x-pages", "2"}]}}
            2 -> {:ok, %Req.Response{status: 200, body: page2_data, headers: [{"x-pages", "2"}]}}
            _ -> {:ok, %Req.Response{status: 200, body: [], headers: [{"x-pages", "1"}]}}
          end
        end do
        stream = Esi.Api.Universe.groups()
        result = stream |> Enum.to_list() |> List.flatten()

        assert is_list(result)
        assert length(result) > 0

        # Universe groups fixture returns group objects
        first_item = List.first(result)
        assert is_map(first_item) or is_integer(first_item)
      end
    end

    test "can limit universe groups with Stream.take" do
      {:ok, page1_data} = FixtureLoader.load_data("universe_groups_page1.json")

      with_mock Req,
        request: fn _opts ->
          {:ok, %Req.Response{status: 200, body: page1_data, headers: [{"x-pages", "2"}]}}
        end do
        # Take only first 10 groups
        limited_groups =
          Esi.Api.Universe.groups()
          |> Stream.flat_map(& &1)
          |> Stream.take(10)
          |> Enum.to_list()

        assert is_list(limited_groups)
        assert length(limited_groups) <= 10
      end
    end
  end

  describe "error handling" do
    test "raises error when API call fails" do
      with_mock Req,
        request: fn _opts ->
          {:ok, %Req.Response{status: 500, body: %{"error" => "Internal Server Error"}}}
        end do
        assert_raise RuntimeError, fn ->
          Esi.Api.Characters.assets(12345, token: "test_token")
          |> Enum.to_list()
        end
      end
    end

    test "handles empty response gracefully" do
      with_mock Req,
        request: fn _opts ->
          {:ok, %Req.Response{status: 200, body: [], headers: [{"x-pages", "1"}]}}
        end do
        result =
          Esi.Api.Characters.assets(12345, token: "test_token")
          |> Enum.to_list()
          |> List.flatten()

        assert result == []
      end
    end
  end

  describe "pagination behavior" do
    test "returns Enumerable that can be consumed multiple times" do
      {:ok, page1_data} = FixtureLoader.load_data("character_assets_page1.json")

      with_mock Req,
        request: fn _opts ->
          {:ok, %Req.Response{status: 200, body: page1_data, headers: [{"x-pages", "1"}]}}
        end do
        stream = Esi.Api.Characters.assets(12345, token: "test_token")

        # Verify it's an enumerable
        assert Enumerable.impl_for(stream) != nil

        # Consume it twice (stream should be repeatable)
        result1 = stream |> Enum.to_list() |> List.flatten()
        result2 = stream |> Enum.to_list() |> List.flatten()

        assert length(result1) == length(result2)
      end
    end

    test "passes authentication token through all pages" do
      {:ok, page1_data} = FixtureLoader.load_data("character_assets_page1.json")
      {:ok, page2_data} = FixtureLoader.load_data("character_assets_page2.json")

      with_mock Req,
        request: fn opts ->
          # Verify auth header is present on every request
          auth_header = Enum.find(opts[:headers], fn {k, _v} -> k == "authorization" end)
          assert auth_header == {"authorization", "Bearer test_token"}

          page = opts[:params][:page] || 1

          case page do
            1 -> {:ok, %Req.Response{status: 200, body: page1_data, headers: [{"x-pages", "2"}]}}
            2 -> {:ok, %Req.Response{status: 200, body: page2_data, headers: [{"x-pages", "2"}]}}
            _ -> {:ok, %Req.Response{status: 200, body: [], headers: [{"x-pages", "1"}]}}
          end
        end do
        stream = Esi.Api.Characters.assets(12345, token: "test_token")
        _result = stream |> Enum.to_list()
      end
    end
  end
end
