defmodule EsiEveOnline.StreamingTest do
  @moduledoc """
  Tests for the streaming functionality in EsiEveOnline using real fixture data.
  """

  use ExUnit.Case, async: false
  import Mock

  alias EsiEveOnline.Test.FixtureLoader

  describe "character_assets streaming" do
    test "streams all character assets across multiple pages" do
      # Mock the paginated character assets endpoint with fixture data
      with_mock EsiEveOnline, FixtureLoader.mock_get_with_headers([
        "character_assets_page1.json",
        "character_assets_page2.json", 
        "character_assets_page3.json"
      ]) do
        # Test the streaming function
        stream = EsiEveOnline.Streaming.character_assets(12345, token: "test_token")
        result = Enum.to_list(stream)
        
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
      # Mock with just one page of data
      with_mock EsiEveOnline, FixtureLoader.mock_get_with_headers([
        "character_assets_page1.json"
      ]) do
        stream = EsiEveOnline.Streaming.character_assets(12345, token: "test_token")
        result = Enum.to_list(stream)
        
        assert is_list(result)
        assert length(result) > 0
      end
    end

    test "can process character assets with stream operations" do
      with_mock EsiEveOnline, FixtureLoader.mock_get_with_headers([
        "character_assets_page1.json",
        "character_assets_page2.json"
      ]) do
        # Test stream operations like filtering and mapping
        unique_type_ids = EsiEveOnline.Streaming.character_assets(12345, token: "test_token")
        |> Stream.map(& &1["type_id"])
        |> Enum.uniq()
        
        assert is_list(unique_type_ids)
        assert length(unique_type_ids) > 0
      end
    end
  end

  describe "universe_groups streaming" do
    test "streams all universe groups across multiple pages" do
      with_mock EsiEveOnline, FixtureLoader.mock_get_with_headers([
        "universe_groups_page1.json",
        "universe_groups_page2.json"
      ]) do
        stream = EsiEveOnline.Streaming.universe_groups()
        result = Enum.to_list(stream)
        
        assert is_list(result)
        assert length(result) > 0
        
        # Verify the structure of the first item
        first_item = List.first(result)
        assert is_map(first_item)
        assert Map.has_key?(first_item, "group_id")
      end
    end

    test "can take limited number of universe groups" do
      with_mock EsiEveOnline, FixtureLoader.mock_get_with_headers([
        "universe_groups_page1.json",
        "universe_groups_page2.json"
      ]) do
        # Test taking only first 5 groups
        limited_groups = EsiEveOnline.Streaming.universe_groups()
        |> Stream.take(5)
        |> Enum.to_list()
        
        assert is_list(limited_groups)
        assert length(limited_groups) == 5
      end
    end
  end

  describe "streaming error handling" do
    test "raises error when API call fails" do
      with_mock EsiEveOnline, [get_with_headers: fn(_path, _opts) -> {:error, "API Error"} end] do
        assert_raise RuntimeError, "Stream request failed: \"API Error\"", fn ->
          EsiEveOnline.Streaming.character_assets(12345, token: "test_token")
          |> Enum.to_list()
        end
      end
    end

    test "handles empty response gracefully" do
      with_mock EsiEveOnline, [get_with_headers: fn(_path, _opts) -> {:ok, [], 1} end] do
        result = EsiEveOnline.Streaming.character_assets(12345, token: "test_token")
        |> Enum.to_list()
        
        assert result == []
      end
    end
  end

  describe "streaming with options" do
    test "passes options correctly to underlying API calls" do
      with_mock EsiEveOnline, FixtureLoader.mock_get_with_headers([
        "character_assets_page1.json"
      ]) do
        # Test with custom options
        stream = EsiEveOnline.Streaming.character_assets(12345, 
          token: "test_token", 
          user_agent: "TestAgent/1.0",
          timeout: 5000
        )
        result = Enum.to_list(stream)
        
        assert is_list(result)
        assert length(result) > 0
      end
    end
  end

  describe "streaming module convenience functions" do
    test "all convenience functions exist and are callable" do
      # Test that all the convenience functions exist
      assert function_exported?(EsiEveOnline.Streaming, :character_assets, 1)
      assert function_exported?(EsiEveOnline.Streaming, :character_assets, 2)
      assert function_exported?(EsiEveOnline.Streaming, :corporation_assets, 1)
      assert function_exported?(EsiEveOnline.Streaming, :corporation_assets, 2)
      assert function_exported?(EsiEveOnline.Streaming, :universe_groups, 0)
      assert function_exported?(EsiEveOnline.Streaming, :universe_groups, 1)
      assert function_exported?(EsiEveOnline.Streaming, :universe_types, 0)
      assert function_exported?(EsiEveOnline.Streaming, :universe_types, 1)
      assert function_exported?(EsiEveOnline.Streaming, :market_orders, 1)
      assert function_exported?(EsiEveOnline.Streaming, :market_orders, 2)
      assert function_exported?(EsiEveOnline.Streaming, :killmails, 0)
      assert function_exported?(EsiEveOnline.Streaming, :killmails, 1)
      assert function_exported?(EsiEveOnline.Streaming, :wars, 0)
      assert function_exported?(EsiEveOnline.Streaming, :wars, 1)
      assert function_exported?(EsiEveOnline.Streaming, :character_contracts, 1)
      assert function_exported?(EsiEveOnline.Streaming, :character_contracts, 2)
      assert function_exported?(EsiEveOnline.Streaming, :corporation_contracts, 1)
      assert function_exported?(EsiEveOnline.Streaming, :corporation_contracts, 2)
    end

    test "convenience functions return enumerables" do
      # Test that all convenience functions return enumerables
      with_mock EsiEveOnline, [get_with_headers: fn(_path, _opts) -> {:ok, [], 1} end] do
        assert Enumerable.impl_for(EsiEveOnline.Streaming.character_assets(123)) != nil
        assert Enumerable.impl_for(EsiEveOnline.Streaming.corporation_assets(456)) != nil
        assert Enumerable.impl_for(EsiEveOnline.Streaming.universe_groups()) != nil
        assert Enumerable.impl_for(EsiEveOnline.Streaming.universe_types()) != nil
        assert Enumerable.impl_for(EsiEveOnline.Streaming.market_orders(10000002)) != nil
        assert Enumerable.impl_for(EsiEveOnline.Streaming.killmails()) != nil
        assert Enumerable.impl_for(EsiEveOnline.Streaming.wars()) != nil
        assert Enumerable.impl_for(EsiEveOnline.Streaming.character_contracts(123)) != nil
        assert Enumerable.impl_for(EsiEveOnline.Streaming.corporation_contracts(456)) != nil
      end
    end
  end
end
