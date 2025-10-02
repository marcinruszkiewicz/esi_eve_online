defmodule ESI.APITest do
  use ExUnit.Case, async: true

  doctest ESI.API

  describe "version/0" do
    test "returns a version string" do
      version = ESI.API.version()
      assert is_binary(version)
      assert version =~ ~r/\d+\.\d+/
    end
  end

  describe "API module structure" do
    test "ESI.API.Alliance module exists and has expected functions" do
      # Test that the Alliance module is defined
      assert Code.ensure_loaded?(ESI.API.Alliance)

      # Test that key functions exist
      assert function_exported?(ESI.API.Alliance, :alliances, 0)
      assert function_exported?(ESI.API.Alliance, :alliance, 1)
      assert function_exported?(ESI.API.Alliance, :corporations, 1)
      assert function_exported?(ESI.API.Alliance, :contacts, 2)
      assert function_exported?(ESI.API.Alliance, :contact_labels, 2)
      assert function_exported?(ESI.API.Alliance, :icons, 1)
    end

    test "ESI.API.Character module exists and has expected functions" do
      assert Code.ensure_loaded?(ESI.API.Character)

      # Test that key functions exist
      assert function_exported?(ESI.API.Character, :character, 1)
      assert function_exported?(ESI.API.Character, :assets, 2)
      assert function_exported?(ESI.API.Character, :mail, 2)
      assert function_exported?(ESI.API.Character, :portrait, 1)
    end

    test "ESI.API.Universe module exists and has expected functions" do
      assert Code.ensure_loaded?(ESI.API.Universe)

      # Test that key functions exist
      assert function_exported?(ESI.API.Universe, :groups, 1)
      assert function_exported?(ESI.API.Universe, :group, 1)
      assert function_exported?(ESI.API.Universe, :bloodlines, 0)
      assert function_exported?(ESI.API.Universe, :create_names, 1)
      assert function_exported?(ESI.API.Universe, :create_ids, 1)
      assert function_exported?(ESI.API.Universe, :systems, 0)
      assert function_exported?(ESI.API.Universe, :system, 1)
    end
  end

  describe "Alliance API functions return proper ESI.Request structs" do
    test "alliances/0 returns valid ESI.Request" do
      request = ESI.API.Alliance.alliances()

      assert %ESI.Request{} = request
      assert request.verb == :get
      assert request.path == "/alliances/"
      assert Map.has_key?(request.opts_schema, :datasource)
    end

    test "alliance/1 returns valid ESI.Request" do
      request = ESI.API.Alliance.alliance(99_005_443)

      assert %ESI.Request{} = request
      assert request.verb == :get
      assert request.path == "/alliances/99005443/"
      assert Map.has_key?(request.opts_schema, :datasource)
    end

    test "corporations/1 returns valid ESI.Request" do
      request = ESI.API.Alliance.corporations(99_005_443)

      assert %ESI.Request{} = request
      assert request.verb == :get
      assert request.path == "/alliances/99005443/corporations/"
      assert Map.has_key?(request.opts_schema, :datasource)
    end

    test "contacts/2 returns valid ESI.Request with options" do
      request = ESI.API.Alliance.contacts(99_005_443, token: "test_token", page: 1)

      assert %ESI.Request{} = request
      assert request.verb == :get
      assert request.path == "/alliances/99005443/contacts/"
      assert Map.has_key?(request.opts_schema, :token)
      assert Map.has_key?(request.opts_schema, :page)
      assert request.opts == %{page: 1, token: "test_token"}
    end
  end

  describe "Character API functions return proper ESI.Request structs" do
    test "character/1 returns valid ESI.Request" do
      request = ESI.API.Character.character(12345)

      assert %ESI.Request{} = request
      assert request.verb == :get
      assert request.path == "/characters/12345/"
      assert Map.has_key?(request.opts_schema, :datasource)
    end

    test "assets/2 returns valid ESI.Request with options" do
      request = ESI.API.Character.assets(12345, token: "test_token", page: 2)

      assert %ESI.Request{} = request
      assert request.verb == :get
      assert request.path == "/characters/12345/assets/"
      assert Map.has_key?(request.opts_schema, :token)
      assert Map.has_key?(request.opts_schema, :page)
      assert request.opts == %{page: 2, token: "test_token"}
    end

    test "mail/2 returns valid ESI.Request with complex options" do
      request =
        ESI.API.Character.mail(12345, token: "test_token", labels: [1, 2], last_mail_id: 100)

      assert %ESI.Request{} = request
      assert request.verb == :get
      assert request.path == "/characters/12345/mail/"
      assert Map.has_key?(request.opts_schema, :token)
      assert Map.has_key?(request.opts_schema, :labels)
      assert Map.has_key?(request.opts_schema, :last_mail_id)
      assert request.opts == %{labels: [1, 2], last_mail_id: 100, token: "test_token"}
    end
  end

  describe "Universe API functions return proper ESI.Request structs" do
    test "groups/1 returns paginated ESI.Request" do
      request = ESI.API.Universe.groups(page: 2)

      assert %ESI.Request{} = request
      assert request.verb == :get
      assert request.path == "/universe/groups/"
      assert Map.has_key?(request.opts_schema, :page)
      assert request.opts == %{page: 2}
    end

    test "bloodlines/0 returns non-paginated ESI.Request" do
      request = ESI.API.Universe.bloodlines()

      assert %ESI.Request{} = request
      assert request.verb == :get
      assert request.path == "/universe/bloodlines/"
      # Should not have page in schema since bloodlines doesn't paginate
      refute Map.has_key?(request.opts_schema, :page)
    end

    test "create_names/1 returns POST ESI.Request with body" do
      ids = [12345, 67890, 99_005_443]
      request = ESI.API.Universe.create_names(ids: ids)

      assert %ESI.Request{} = request
      assert request.verb == :post
      assert request.path == "/universe/names/"
      assert Map.has_key?(request.opts_schema, :ids)
      assert {:body, :required} = request.opts_schema[:ids]
      assert request.opts == %{ids: ids}
    end

    test "create_ids/1 returns POST ESI.Request with body" do
      names = ["Jita", "CCP Bartender"]
      request = ESI.API.Universe.create_ids(names: names)

      assert %ESI.Request{} = request
      assert request.verb == :post
      assert request.path == "/universe/ids/"
      assert Map.has_key?(request.opts_schema, :names)
      assert {:body, :required} = request.opts_schema[:names]
      assert request.opts == %{names: names}
    end

    test "systems/0 returns non-paginated ESI.Request" do
      request = ESI.API.Universe.systems()

      assert %ESI.Request{} = request
      assert request.verb == :get
      assert request.path == "/universe/systems/"
      refute Map.has_key?(request.opts_schema, :page)
      assert request.opts == %{}
    end

    test "system/1 returns valid ESI.Request" do
      request = ESI.API.Universe.system(30_000_142)

      assert %ESI.Request{} = request
      assert request.verb == :get
      assert request.path == "/universe/systems/30000142/"
      assert Map.has_key?(request.opts_schema, :language)
      assert Map.has_key?(request.opts_schema, :datasource)
    end
  end

  describe "option types and schemas" do
    test "Alliance.contacts/2 has correct option types" do
      # Test the actual typespec behavior by calling with known options
      request = ESI.API.Alliance.contacts(99_005_443, page: 1, token: "test")

      assert request.opts_schema[:page] == {:query, :optional}
      assert request.opts_schema[:token] == {:query, :optional}
      assert request.opts_schema[:datasource] == {:query, :optional}
    end

    test "Character.mail/2 has correct option types" do
      request = ESI.API.Character.mail(12345, labels: [1, 2], last_mail_id: 100, token: "test")

      assert request.opts_schema[:labels] == {:query, :optional}
      assert request.opts_schema[:last_mail_id] == {:query, :optional}
      assert request.opts_schema[:token] == {:query, :optional}
      assert request.opts_schema[:datasource] == {:query, :optional}
    end

    test "Universe.create_names/1 has correct body option type" do
      request = ESI.API.Universe.create_names(ids: [12345])

      assert request.opts_schema[:ids] == {:body, :required}
      assert request.opts_schema[:datasource] == {:query, :optional}
    end
  end
end
