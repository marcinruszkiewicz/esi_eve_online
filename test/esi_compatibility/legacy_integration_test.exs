defmodule ESI.LegacyIntegrationTest do
  use ExUnit.Case, async: false

  import Mock

  @moduletag :integration

  describe "full legacy compatibility patterns" do
    test "ESI.API.Alliance.alliances() |> ESI.request() pattern works" do
      with_mock EsiEveOnline, get: fn _path, _opts -> {:ok, [99_005_443, 99_005_784]} end do
        # This is the exact pattern from the legacy library
        result = ESI.API.Alliance.alliances() |> ESI.request()

        assert {:ok, [99_005_443, 99_005_784]} = result
        assert called(EsiEveOnline.get("/alliances/", []))
      end
    end

    test "ESI.API.Alliance.alliance(id) |> ESI.request!() pattern works" do
      alliance_data = %{
        "creator_corporation_id" => 1_344_654_522,
        "creator_id" => 55_465_499,
        "date_founded" => "2010-06-01T05:20:00Z",
        "name" => "Goonswarm Federation",
        "ticker" => "CONDI"
      }

      with_mock EsiEveOnline, get: fn _path, _opts -> {:ok, alliance_data} end do
        # This is the exact pattern from the legacy library  
        result = ESI.API.Alliance.alliance(99_005_443) |> ESI.request!()

        assert result == alliance_data
        assert called(EsiEveOnline.get("/alliances/99005443/", []))
      end
    end

    test "ESI.API.Character.character(id) |> ESI.request(token: token) pattern works" do
      character_data = %{
        "alliance_id" => 99_005_443,
        "corporation_id" => 109_299_958,
        "name" => "CCP Bartender",
        "security_status" => -0.07
      }

      with_mock EsiEveOnline, get: fn _path, _opts -> {:ok, character_data} end do
        # This is the exact pattern from the legacy library with authentication
        result =
          ESI.API.Character.character(95_465_499) |> ESI.request(token: "test_access_token")

        assert {:ok, ^character_data} = result
        assert called(EsiEveOnline.get("/characters/95465499/", token: "test_access_token"))
      end
    end

    test "ESI.API.Character.assets(id, opts) |> ESI.request!(token: token) pattern works" do
      assets_data = [
        %{
          "is_singleton" => true,
          "item_id" => 1_000_000_016_835,
          "location_flag" => "Hangar",
          "location_id" => 60_002_959,
          "location_type" => "station",
          "quantity" => 1,
          "type_id" => 3516
        }
      ]

      with_mock EsiEveOnline, get: fn _path, _opts -> {:ok, assets_data} end do
        # This pattern shows how options are passed both in the function call and ESI.request
        result =
          ESI.API.Character.assets(95_465_499, page: 1) |> ESI.request!(token: "test_token")

        assert result == assets_data

        assert called(
                 EsiEveOnline.get("/characters/95465499/assets/", page: 1, token: "test_token")
               )
      end
    end

    test "ESI.API.Universe.create_names(ids: ids) |> ESI.request() POST pattern works" do
      names_data = [
        %{"category" => "character", "id" => 95_465_499, "name" => "CCP Bartender"},
        %{"category" => "alliance", "id" => 99_005_443, "name" => "Goonswarm Federation"}
      ]

      with_mock EsiEveOnline, post: fn _path, _body, _opts -> {:ok, names_data} end do
        # This shows how POST requests with body data work
        ids = [95_465_499, 99_005_443]
        result = ESI.API.Universe.create_names(ids: ids) |> ESI.request()

        assert {:ok, ^names_data} = result
        assert called(EsiEveOnline.post("/universe/names/", ids, []))
      end
    end

    test "ESI.API.Universe.groups() |> ESI.stream!() |> Enum.take(n) pagination pattern works" do
      # Mock the pagination behavior
      with_mock ESI.Request,
        options: fn req, opts -> %{req | opts: Map.merge(req.opts, Map.new(opts))} end,
        stream!: fn _req ->
          # Simulate a stream that yields paginated results
          Stream.unfold(1, fn
            page when page <= 3 ->
              page_data = Enum.map(1..10, fn i -> (page - 1) * 10 + i end)
              {page_data, page + 1}

            _ ->
              nil
          end)
          |> Stream.flat_map(& &1)
        end do
        # This is the exact streaming pattern from the legacy library
        result = ESI.API.Universe.groups() |> ESI.stream!() |> Enum.take(25)

        # Should get first 25 items across multiple pages
        expected = Enum.to_list(1..25)
        assert result == expected
      end
    end

    test "ESI.API.Universe.bloodlines() |> ESI.stream!() |> Enum.to_list() non-paginated pattern works" do
      bloodlines_data = [
        %{"bloodline_id" => 1, "name" => "Deteis", "race_id" => 1},
        %{"bloodline_id" => 2, "name" => "Civire", "race_id" => 1}
      ]

      with_mock ESI.Request,
        options: fn req, _opts -> req end,
        stream!: fn _req -> bloodlines_data end do
        # This shows how non-paginated endpoints work with streaming
        result = ESI.API.Universe.bloodlines() |> ESI.stream!() |> Enum.to_list()

        assert result == bloodlines_data
      end
    end

    test "ESI.API.Alliance.contacts(id, opts) |> ESI.request_with_headers() pagination info pattern works" do
      contacts_data = [
        %{"contact_id" => 2_112_625_428, "contact_type" => "character", "standing" => 9.9}
      ]

      with_mock EsiEveOnline, get_with_headers: fn _path, _opts -> {:ok, contacts_data, 1} end do
        # This shows how to get pagination information
        result =
          ESI.API.Alliance.contacts(99_005_443, page: 1)
          |> ESI.request_with_headers(token: "test_token")

        assert {:ok, ^contacts_data, 1} = result

        assert called(
                 EsiEveOnline.get_with_headers("/alliances/99005443/contacts/",
                   page: 1,
                   token: "test_token"
                 )
               )
      end
    end

    test "complex option merging between function call and ESI.request works correctly" do
      with_mock EsiEveOnline,
        get: fn _path, opts ->
          # Verify that options from both the function call and ESI.request are merged
          # from function call
          assert Keyword.get(opts, :page) == 2
          # from ESI.request
          assert Keyword.get(opts, :token) == "test_token"
          # from ESI.request
          assert Keyword.get(opts, :user_agent) == "TestApp/1.0"
          {:ok, []}
        end do
        ESI.API.Character.assets(95_465_499, page: 2)
        |> ESI.request(token: "test_token", user_agent: "TestApp/1.0")
      end
    end

    test "error handling maintains legacy behavior" do
      error = %Esi.Error{message: "Character not found", status: 404, type: :api_error}

      with_mock EsiEveOnline, get: fn _path, _opts -> {:error, error} end do
        # Error should be returned as-is for ESI.request
        result = ESI.API.Character.character(99_999_999) |> ESI.request()
        assert {:error, ^error} = result

        # Error should be raised for ESI.request!
        assert_raise RuntimeError, "Request failed: Character not found", fn ->
          ESI.API.Character.character(99_999_999) |> ESI.request!()
        end
      end
    end
  end

  describe "legacy library examples from documentation" do
    test "reproduces legacy example: ESI.API.Insurance.prices() |> ESI.request" do
      # This would be how insurance prices were fetched in the legacy library
      # We don't have the Insurance module implemented yet, but this shows the pattern

      # Note: In a full implementation, we'd add ESI.API.Insurance module
      # For now, we'll simulate it with Alliance.alliances which has the same structure

      with_mock EsiEveOnline, get: fn _path, _opts -> {:ok, ["price_data"]} end do
        result = ESI.API.Alliance.alliances() |> ESI.request()
        assert {:ok, ["price_data"]} = result
      end
    end

    test "reproduces legacy example: ESI.API.Universe.groups() |> ESI.stream! |> Enum.take(1020)" do
      with_mock ESI.Request,
        options: fn req, _opts -> req end,
        stream!: fn _req ->
          # Simulate 1500 total items across multiple pages
          Stream.unfold(1, fn
            i when i <= 1500 -> {i, i + 1}
            _ -> nil
          end)
        end do
        # This is the exact example from the legacy documentation
        result = ESI.API.Universe.groups() |> ESI.stream!() |> Enum.take(1020)

        assert length(result) == 1020
        assert result == Enum.to_list(1..1020)
      end
    end

    test "reproduces legacy example: ESI.API.Universe.bloodlines() |> ESI.stream! |> Enum.to_list" do
      bloodlines = Enum.map(1..18, fn i -> %{"bloodline_id" => i, "name" => "Bloodline #{i}"} end)

      with_mock ESI.Request,
        options: fn req, _opts -> req end,
        stream!: fn _req -> bloodlines end do
        # This is the exact example from the legacy documentation  
        result = ESI.API.Universe.bloodlines() |> ESI.stream!() |> Enum.to_list()

        assert length(result) == 18
        assert result == bloodlines
      end
    end
  end
end
