defmodule Esi.CustomProcessorTest do
  use ExUnit.Case, async: true

  alias Esi.CustomProcessor

  # Helper to create operation struct
  defp make_operation(path, method) do
    %OpenAPI.Spec.Path.Operation{
      :"$oag_path" => path,
      :"$oag_path_method" => method
    }
  end

  describe "operation_function_name/2" do
    test "GET requests with singular/plural logic" do
      # GET /alliances -> alliances (plural)
      operation = make_operation("/alliances", "get")
      assert CustomProcessor.operation_function_name(nil, operation) == :alliances

      # GET /alliances/{alliance_id} -> alliance (singular)
      operation = make_operation("/alliances/{alliance_id}", "get")
      assert CustomProcessor.operation_function_name(nil, operation) == :alliance

      # GET /universe/categories -> categories (plural)
      operation = make_operation("/universe/categories", "get")
      assert CustomProcessor.operation_function_name(nil, operation) == :categories

      # GET /universe/categories/{category_id} -> category (proper singular)
      operation = make_operation("/universe/categories/{category_id}", "get")
      assert CustomProcessor.operation_function_name(nil, operation) == :category
    end

    test "GET requests with subresource conflict resolution" do
      # GET /characters/{character_id}/calendar -> calendar
      operation = make_operation("/characters/{character_id}/calendar", "get")
      assert CustomProcessor.operation_function_name(nil, operation) == :calendar

      # GET /characters/{character_id}/calendar/{event_id} -> calendar_item
      operation = make_operation("/characters/{character_id}/calendar/{event_id}", "get")
      assert CustomProcessor.operation_function_name(nil, operation) == :calendar_item

      # GET /corporation/{corporation_id}/mining/observers -> mining_observers
      operation = make_operation("/corporation/{corporation_id}/mining/observers", "get")
      assert CustomProcessor.operation_function_name(nil, operation) == :mining_observers

      # GET /corporation/{corporation_id}/mining/observers/{observer_id} -> mining_observer
      operation = make_operation("/corporation/{corporation_id}/mining/observers/{observer_id}", "get")
      assert CustomProcessor.operation_function_name(nil, operation) == :mining_observer
    end

    test "GET requests with special contract cases" do
      # GET /contracts/public/{region_id} -> public
      operation = make_operation("/contracts/public/{region_id}", "get")
      assert CustomProcessor.operation_function_name(nil, operation) == :public

      # GET /contracts/public/items/{contract_id} -> public_item
      operation = make_operation("/contracts/public/items/{contract_id}", "get")
      assert CustomProcessor.operation_function_name(nil, operation) == :public_item
    end

    test "POST requests with fleet exception" do
      # POST /fleets/{fleet_id}/members -> invite (special case)
      operation = make_operation("/fleets/{fleet_id}/members", "post")
      assert CustomProcessor.operation_function_name(nil, operation) == :invite
    end

    test "POST requests with creation operations" do
      # POST /characters/{character_id}/contacts -> create_contacts
      operation = make_operation("/characters/{character_id}/contacts", "post")
      assert CustomProcessor.operation_function_name(nil, operation) == :create_contacts

      # POST /characters/{character_id}/fittings -> create_fittings
      operation = make_operation("/characters/{character_id}/fittings", "post")
      assert CustomProcessor.operation_function_name(nil, operation) == :create_fittings

      # POST /characters/{character_id}/mail -> create_mail
      operation = make_operation("/characters/{character_id}/mail", "post")
      assert CustomProcessor.operation_function_name(nil, operation) == :create_mail

      # POST /fleets/{fleet_id}/wings -> create_wings
      operation = make_operation("/fleets/{fleet_id}/wings", "post")
      assert CustomProcessor.operation_function_name(nil, operation) == :create_wings
    end

    test "POST requests with non-creation operations" do
      # POST /universe/names -> names (not create_names)
      operation = make_operation("/universe/names", "post")
      assert CustomProcessor.operation_function_name(nil, operation) == :names

      # POST /universe/ids -> ids (not create_ids)
      operation = make_operation("/universe/ids", "post")
      assert CustomProcessor.operation_function_name(nil, operation) == :ids

      # POST /characters/{character_id}/assets/locations -> assets_locations
      operation = make_operation("/characters/{character_id}/assets/locations", "post")
      assert CustomProcessor.operation_function_name(nil, operation) == :assets_locations

      # POST /characters/{character_id}/cspa -> cspa
      operation = make_operation("/characters/{character_id}/cspa", "post")
      assert CustomProcessor.operation_function_name(nil, operation) == :cspa
    end

    test "POST requests with openwindow special handling" do
      # POST /ui/openwindow/contract -> open_contract_window
      operation = make_operation("/ui/openwindow/contract", "post")
      assert CustomProcessor.operation_function_name(nil, operation) == :open_contract_window

      # POST /ui/openwindow/information -> open_information_window
      operation = make_operation("/ui/openwindow/information", "post")
      assert CustomProcessor.operation_function_name(nil, operation) == :open_information_window
    end

    test "PUT requests" do
      # PUT /alliances/{alliance_id} -> update
      operation = make_operation("/alliances/{alliance_id}", "put")
      assert CustomProcessor.operation_function_name(nil, operation) == :update

      # PUT /characters/{character_id}/calendar/{event_id} -> update_calendar
      operation = make_operation("/characters/{character_id}/calendar/{event_id}", "put")
      assert CustomProcessor.operation_function_name(nil, operation) == :update_calendar
    end

    test "DELETE requests" do
      # DELETE /alliances/{alliance_id} -> delete
      operation = make_operation("/alliances/{alliance_id}", "delete")
      assert CustomProcessor.operation_function_name(nil, operation) == :delete

      # DELETE /characters/{character_id}/contacts -> delete_contacts
      operation = make_operation("/characters/{character_id}/contacts", "delete")
      assert CustomProcessor.operation_function_name(nil, operation) == :delete_contacts
    end

    test "hyphen replacement in function names" do
      # GET /meta/compatibility-dates -> compatibility_dates
      operation = make_operation("/meta/compatibility-dates", "get")
      assert CustomProcessor.operation_function_name(nil, operation) == :compatibility_dates
    end

    test "singularization rules" do
      # Test categories -> category
      operation = make_operation("/universe/categories/{category_id}", "get")
      assert CustomProcessor.operation_function_name(nil, operation) == :category

      # Test companies -> company (if such endpoint existed)
      operation = make_operation("/universe/companies/{company_id}", "get")
      assert CustomProcessor.operation_function_name(nil, operation) == :company

      # Test addresses -> address (if such endpoint existed)
      operation = make_operation("/universe/addresses/{address_id}", "get")
      assert CustomProcessor.operation_function_name(nil, operation) == :address

      # Test items -> item (regular s removal)
      operation = make_operation("/universe/items/{item_id}", "get")
      assert CustomProcessor.operation_function_name(nil, operation) == :item
    end
  end

  describe "operation_module_names/2" do
    test "generates correct module names from paths" do
      # Test basic module name generation
      operation = make_operation("/alliances", "get")
      result = CustomProcessor.operation_module_names(nil, operation)
      assert result == [Alliance]

      # Test nested path module names
      operation = make_operation("/characters/{character_id}/assets", "get")
      result = CustomProcessor.operation_module_names(nil, operation)
      assert result == [Character]

      # Test complex nested paths
      operation = make_operation("/universe/categories/{category_id}", "get")
      result = CustomProcessor.operation_module_names(nil, operation)
      assert result == [Universe]
    end
  end
end
