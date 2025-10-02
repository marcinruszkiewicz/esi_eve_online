defmodule Integration.ApiIntegrationTest do
  use ExUnit.Case, async: false
  import Mock

  alias Esi.Error

  @moduletag :integration

  describe "generated API modules integration" do
    test "Alliance API works with client" do
      # Mock a successful response
      mock_response = %Req.Response{
        status: 200,
        body: %{
          "creator_corporation_id" => 98_356_193,
          "creator_id" => 1_234_567_890,
          "date_founded" => "2016-06-26T21:00:00Z",
          "executor_corporation_id" => 98_356_193,
          "faction_id" => 500_001,
          "name" => "Test Alliance",
          "ticker" => "TEST"
        },
        headers: [{"content-type", "application/json"}]
      }

      with_mock Req, request: fn _opts -> {:ok, mock_response} end do
        # Test the generated alliance function
        assert {:ok, alliance_data} = Esi.Api.Alliances.alliance(99_005_443)

        assert alliance_data["name"] == "Test Alliance"
        assert alliance_data["ticker"] == "TEST"

        # Verify the correct URL was called
        assert_called(
          Req.request(
            method: :get,
            url: "https://esi.evetech.net/latest/alliances/99005443",
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

    test "Character API with authentication" do
      mock_response = %Req.Response{
        status: 200,
        body: [
          %{
            "item_id" => 1_000_000_016_835,
            "location_flag" => "Hangar",
            "location_id" => 60_002_959,
            "location_type" => "station",
            "quantity" => 1,
            "type_id" => 3516
          }
        ],
        headers: [{"x-pages", "1"}]
      }

      with_mock Req, request: fn _opts -> {:ok, mock_response} end do
        # Test authenticated endpoint (assets is now a paginated stream)
        opts = [token: "test-access-token"]
        assets_stream = Esi.Api.Characters.assets(1_234_567_890, opts)

        # Consume the stream to get the actual assets
        assets = assets_stream |> Enum.to_list() |> List.flatten()

        assert is_list(assets)
        assert length(assets) == 1

        # Verify authentication header was included
        assert_called(
          Req.request(
            method: :get,
            url: "https://esi.evetech.net/latest/characters/1234567890/assets",
            headers: [
              {"authorization", "Bearer test-access-token"},
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

    test "POST request with body (Universe names)" do
      mock_response = %Req.Response{
        status: 200,
        body: [
          %{
            "category" => "character",
            "id" => 1_234_567_890,
            "name" => "Test Character"
          },
          %{
            "category" => "alliance",
            "id" => 99_005_443,
            "name" => "Test Alliance"
          }
        ],
        headers: []
      }

      with_mock Req, request: fn _opts -> {:ok, mock_response} end do
        # Test POST request with body
        ids = [1_234_567_890, 99_005_443]
        assert {:ok, names} = Esi.Api.Universe.names(ids)

        assert length(names) == 2
        assert Enum.any?(names, &(&1["name"] == "Test Character"))
        assert Enum.any?(names, &(&1["name"] == "Test Alliance"))

        # Verify POST with JSON body
        assert_called(
          Req.request(
            method: :post,
            url: "https://esi.evetech.net/latest/universe/names",
            json: [1_234_567_890, 99_005_443],
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

    test "Fleet invite special case" do
      mock_response = %Req.Response{
        status: 204,
        body: "",
        headers: []
      }

      with_mock Req, request: fn _opts -> {:ok, mock_response} end do
        # Test the special fleet invite function
        invitation_data = %{
          "character_id" => 1_234_567_890,
          "role" => "squad_member"
        }

        opts = [token: "fleet-commander-token"]
        assert {:ok, ""} = Esi.Api.Fleets.invite(12345, invitation_data, opts)

        # Verify correct endpoint and method
        assert_called(
          Req.request(
            method: :post,
            url: "https://esi.evetech.net/latest/fleets/12345/members",
            json: %{"character_id" => 1_234_567_890, "role" => "squad_member"},
            headers: [
              {"authorization", "Bearer fleet-commander-token"},
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

    test "Error handling in generated modules" do
      mock_response = %Req.Response{
        status: 404,
        body: %{"error" => "Alliance not found"},
        headers: [{"x-esi-request-id", "req-test-123"}]
      }

      with_mock Req, request: fn _opts -> {:ok, mock_response} end do
        # Test error response
        assert {:error, error} = Esi.Api.Alliances.alliance(99_999_999)

        assert %Error{
                 type: :api_error,
                 status: 404,
                 message: "Not found",
                 request_id: "req-test-123"
               } = error
      end
    end

    test "Singular/plural naming works correctly" do
      # Test categories (plural)
      mock_response = %Req.Response{
        status: 200,
        body: [
          6,
          7,
          8,
          9,
          10,
          11,
          16,
          17,
          18,
          20,
          22,
          23,
          25,
          29,
          32,
          34,
          35,
          39,
          40,
          41,
          42,
          43,
          46,
          63,
          65,
          66,
          87,
          91
        ],
        headers: []
      }

      with_mock Req,
        request: fn opts ->
          assert opts[:url] == "https://esi.evetech.net/latest/universe/categories"
          {:ok, mock_response}
        end do
        assert {:ok, category_ids} = Esi.Api.Universe.categories()
        assert is_list(category_ids)
      end

      # Test category (singular)  
      mock_response = %Req.Response{
        status: 200,
        body: %{
          "category_id" => 6,
          "name" => "Ship",
          "published" => true,
          "groups" => [25, 26, 27, 28, 29, 30, 31]
        },
        headers: []
      }

      with_mock Req,
        request: fn opts ->
          assert opts[:url] == "https://esi.evetech.net/latest/universe/categories/6"
          {:ok, mock_response}
        end do
        assert {:ok, category_data} = Esi.Api.Universe.category(6)
        assert category_data["name"] == "Ship"
      end
    end
  end

  describe "unified interface integration" do
    test "EsiEveOnline.get/2 works end-to-end" do
      mock_response = %Req.Response{
        status: 200,
        body: %{
          "players" => 25000,
          "server_version" => "1234567",
          "start_time" => "2023-01-01T12:00:00Z"
        },
        headers: []
      }

      with_mock Req, request: fn _opts -> {:ok, mock_response} end do
        assert {:ok, status} = EsiEveOnline.get("/status")

        assert status["players"] == 25000
        assert status["server_version"] == "1234567"
      end
    end

    test "EsiEveOnline.post/3 works end-to-end" do
      mock_response = %Req.Response{
        status: 200,
        body: [%{"id" => 1234, "name" => "Test", "category" => "character"}],
        headers: []
      }

      with_mock Req, request: fn _opts -> {:ok, mock_response} end do
        assert {:ok, results} = EsiEveOnline.post("/universe/names", [1234])

        assert length(results) == 1
        assert hd(results)["name"] == "Test"
      end
    end
  end
end
