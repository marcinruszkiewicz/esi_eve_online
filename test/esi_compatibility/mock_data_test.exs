defmodule EsiEveOnline.Test.MockDataTest do
  @moduledoc """
  Tests using mock API responses.

  These tests demonstrate how to use the FixtureLoader to test with
  mock API response data, including proper pagination handling.
  """

  use ExUnit.Case, async: false

  import Mock

  alias EsiEveOnline.Test.FixtureLoader

  describe "pagination with mock data" do
    test "stream! handles multiple pages using mock character assets data" do
      # This test uses mock responses to verify pagination works correctly
      request = %ESI.Request{
        opts: %{},
        opts_schema: %{page: {:query, :optional}},
        path: "/characters/123/assets/",
        verb: :get
      }

      # Mock using mock responses (3 pages: 999 + 999 + 102 = 2100 items)
      with_mock EsiEveOnline,
                FixtureLoader.mock_get_with_headers([
                  "character_assets_page1.json",
                  "character_assets_page2.json",
                  "character_assets_page3.json"
                ]) do
        stream = ESI.stream!(request)
        result = Enum.to_list(stream)

        # Verify we got data from multiple pages
        # Total items across all pages
        assert length(result) == 2100
        assert is_list(result)
        refute Enum.empty?(result)
      end
    end

    test "request_with_headers returns correct pagination info from mock data" do
      request = %ESI.Request{
        opts: %{},
        opts_schema: %{page: {:query, :optional}},
        path: "/characters/123/assets/",
        verb: :get
      }

      # Extract the mock pagination info
      {:ok, data, max_pages} = FixtureLoader.mock_response_tuple("character_assets_page1.json")

      with_mock EsiEveOnline, get_with_headers: fn _path, _opts -> {:ok, data, max_pages} end do
        result = ESI.request_with_headers(request)
        assert {:ok, ^data, ^max_pages} = result
        # Should have 3 pages
        assert max_pages == 3
      end
    end
  end

  describe "non-paginated endpoints with mock data" do
    test "universe bloodlines with mock data" do
      request = %ESI.Request{
        opts: %{},
        opts_schema: %{},
        path: "/universe/bloodlines/",
        verb: :get
      }

      {:ok, data} = FixtureLoader.load_data("universe_bloodlines.json")

      with_mock EsiEveOnline, get: fn _path, _opts -> {:ok, data} end do
        result = ESI.request(request)
        assert {:ok, ^data} = result
        # Should have 18 bloodlines
        assert length(data) == 18
      end
    end
  end

  describe "fixture loader utilities" do
    test "loads fixture data correctly" do
      # Test the fixture loader itself
      fixtures = FixtureLoader.list_fixtures()
      assert not Enum.empty?(fixtures), "Should have mock fixtures available"

      # Test loading the first available fixture
      [first_fixture | _] = fixtures

      case FixtureLoader.load_response(first_fixture) do
        {:ok, response} ->
          # Handle both new format (with metadata) and old format (raw data)
          if is_map(response) and Map.has_key?(response, "endpoint") do
            # New format with metadata
            assert Map.has_key?(response, "endpoint")
            assert Map.has_key?(response, "data")
            assert Map.has_key?(response, "headers")
            assert Map.has_key?(response, "captured_at")
          else
            # Old format - just raw data
            assert is_list(response) or is_map(response)
            IO.puts("  ℹ️  Found legacy format fixture: #{first_fixture}")
          end

        {:error, reason} ->
          flunk("Failed to load fixture #{first_fixture}: #{reason}")
      end
    end

    test "extracts pagination info correctly" do
      case FixtureLoader.load_response("character_assets_page1.json") do
        {:ok, _response} ->
          case FixtureLoader.load_pagination_info("character_assets_page1.json") do
            {:ok, pagination} ->
              # Verify pagination info structure
              assert Map.has_key?(pagination, :x_pages)
              assert Map.has_key?(pagination, :x_esi_request_id)
              # Should have 3 pages
              assert pagination.x_pages == "3"

            {:error, reason} ->
              flunk("Failed to extract pagination info: #{reason}")
          end

        {:error, :not_found} ->
          flunk("Mock fixture character_assets_page1.json should exist")
      end
    end
  end
end
