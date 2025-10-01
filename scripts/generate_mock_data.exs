#!/usr/bin/env elixir

# Script to generate mock ESI API responses for testing
# Run with: mix run scripts/generate_mock_data.exs

defmodule MockDataGenerator do
  def generate_all do
    IO.puts("🎭 Generating mock ESI API responses...")
    
    # Create fixtures directory
    File.mkdir_p!("test/fixtures")
    
    # Generate paginated character assets (3 pages: 999 + 999 + 102 = 2100 items)
    generate_character_assets()
    
    # Generate other mock responses
    generate_universe_groups()
    generate_universe_bloodlines()
    generate_character_info()
    
    IO.puts("✅ All mock responses generated successfully!")
  end
  
  defp generate_character_assets do
    IO.puts("📦 Generating character assets (3 pages)...")
    
    # Page 1: 999 items
    page1_data = generate_asset_items(1, 999)
    save_response("character_assets_page1.json", "/characters/123456789/assets/", 1, page1_data, 3)
    
    # Page 2: 999 items  
    page2_data = generate_asset_items(1000, 1998)
    save_response("character_assets_page2.json", "/characters/123456789/assets/", 2, page2_data, 3)
    
    # Page 3: 102 items
    page3_data = generate_asset_items(1999, 2100)
    save_response("character_assets_page3.json", "/characters/123456789/assets/", 3, page3_data, 3)
    
    IO.puts("  ✅ Generated 3 pages with 2100 total items")
  end
  
  defp generate_asset_items(start_id, end_id) do
    Enum.map(start_id..end_id, fn i ->
      %{
        "item_id" => 1000000000000 + i,
        "location_flag" => if(rem(i, 3) == 0, do: "Cargo", else: "Hangar"),
        "location_id" => 60003760 + rem(i, 10),
        "location_type" => if(rem(i, 5) == 0, do: "structure", else: "station"),
        "quantity" => rem(i, 100) + 1,
        "type_id" => 10000 + rem(i, 1000)
      }
    end)
  end
  
  defp generate_universe_groups do
    IO.puts("🌌 Generating universe groups (2 pages)...")
    
    # Page 1: 1000 groups
    page1_data = generate_groups(1, 1000)
    save_response("universe_groups_page1.json", "/universe/groups/", 1, page1_data, 2)
    
    # Page 2: 403 groups
    page2_data = generate_groups(1001, 1403)
    save_response("universe_groups_page2.json", "/universe/groups/", 2, page2_data, 2)
    
    IO.puts("  ✅ Generated 2 pages with 1403 total groups")
  end
  
  defp generate_groups(start_id, end_id) do
    Enum.map(start_id..end_id, fn i ->
      %{
        "group_id" => i,
        "name" => "Test Group #{i}",
        "category_id" => rem(i, 10) + 1,
        "published" => true
      }
    end)
  end
  
  defp generate_universe_bloodlines do
    IO.puts("🧬 Generating universe bloodlines (non-paginated)...")
    
    bloodlines = [
      %{"bloodline_id" => 1, "name" => "Deteis", "race_id" => 1, "description" => "A bloodline of the Caldari"},
      %{"bloodline_id" => 2, "name" => "Civire", "race_id" => 1, "description" => "A bloodline of the Caldari"},
      %{"bloodline_id" => 3, "name" => "Achura", "race_id" => 1, "description" => "A bloodline of the Caldari"},
      %{"bloodline_id" => 4, "name" => "Gallente", "race_id" => 2, "description" => "A bloodline of the Gallente"},
      %{"bloodline_id" => 5, "name" => "Intaki", "race_id" => 2, "description" => "A bloodline of the Gallente"},
      %{"bloodline_id" => 6, "name" => "Jin-Mei", "race_id" => 2, "description" => "A bloodline of the Gallente"},
      %{"bloodline_id" => 7, "name" => "Amarr", "race_id" => 4, "description" => "A bloodline of the Amarr"},
      %{"bloodline_id" => 8, "name" => "Khanid", "race_id" => 4, "description" => "A bloodline of the Amarr"},
      %{"bloodline_id" => 9, "name" => "Ni-Kunni", "race_id" => 4, "description" => "A bloodline of the Amarr"},
      %{"bloodline_id" => 10, "name" => "Minmatar", "race_id" => 8, "description" => "A bloodline of the Minmatar"},
      %{"bloodline_id" => 11, "name" => "Brutor", "race_id" => 8, "description" => "A bloodline of the Minmatar"},
      %{"bloodline_id" => 12, "name" => "Sebiestor", "race_id" => 8, "description" => "A bloodline of the Minmatar"},
      %{"bloodline_id" => 13, "name" => "Vherokior", "race_id" => 8, "description" => "A bloodline of the Minmatar"},
      %{"bloodline_id" => 14, "name" => "Sani Sabik", "race_id" => 4, "description" => "A bloodline of the Amarr"},
      %{"bloodline_id" => 15, "name" => "Drifter", "race_id" => 8, "description" => "A bloodline of the Minmatar"},
      %{"bloodline_id" => 16, "name" => "EoM", "race_id" => 4, "description" => "A bloodline of the Amarr"},
      %{"bloodline_id" => 17, "name" => "Sansha", "race_id" => 8, "description" => "A bloodline of the Minmatar"},
      %{"bloodline_id" => 18, "name" => "Rogue Drone", "race_id" => 8, "description" => "A bloodline of the Minmatar"}
    ]
    
    save_response("universe_bloodlines.json", "/universe/bloodlines/", nil, bloodlines, 1)
    IO.puts("  ✅ Generated 18 bloodlines")
  end
  
  defp generate_character_info do
    IO.puts("👤 Generating character info...")
    
    character = %{
      "character_id" => 123456789,
      "name" => "Test Character",
      "description" => "A test character for API testing",
      "corporation_id" => 987654321,
      "alliance_id" => 111222333,
      "birthday" => "2015-05-25T00:00:00Z",
      "gender" => "male",
      "race_id" => 1,
      "bloodline_id" => 1,
      "ancestry_id" => 1,
      "security_status" => 0.5,
      "faction_id" => nil,
      "title" => "Test Pilot"
    }
    
    save_response("character_info.json", "/characters/123456789/", nil, character, 1)
    IO.puts("  ✅ Generated character info")
  end
  
  defp save_response(filename, endpoint, page, data, max_pages) do
    response = %{
      "endpoint" => endpoint,
      "page" => page,
      "data" => data,
      "headers" => %{
        "x-pages" => to_string(max_pages),
        "x-esi-request-id" => "mock-request-#{System.unique_integer([:positive])}",
        "x-esi-error-limit-remain" => "100",
        "x-esi-error-limit-reset" => "1640995200"
      },
      "captured_at" => DateTime.utc_now() |> DateTime.to_iso8601(),
      "note" => "This is mock data for testing"
    }
    
    file_path = "test/fixtures/#{filename}"
    File.write!(file_path, Jason.encode!(response, pretty: true))
    IO.puts("  📄 Saved #{filename}")
  end
end

MockDataGenerator.generate_all()
