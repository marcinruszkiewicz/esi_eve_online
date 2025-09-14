defmodule Esi.Api.Dogma do
  @moduledoc """
  Provides API endpoints related to dogma
  """

  @default_client Esi.Client

  @doc """
  Get attribute information

  Get information on a dogma attribute

  This route expires daily at 11:05
  """
  @spec attribute(integer, keyword) ::
          {:ok, Esi.Api.DogmaAttributesAttributeIdGet.t()} | {:error, Esi.Api.Error.t()}
  def attribute(attribute_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [attribute_id: attribute_id],
      call: {Esi.Api.Dogma, :attribute},
      url: "/dogma/attributes/#{attribute_id}",
      method: :get,
      response: [{200, {Esi.Api.DogmaAttributesAttributeIdGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get attributes

  Get a list of dogma attribute ids

  This route expires daily at 11:05
  """
  @spec attributes(keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def attributes(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Dogma, :attributes},
      url: "/dogma/attributes",
      method: :get,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get dynamic item information

  Returns info about a dynamic item resulting from mutation with a mutaplasmid.

  This route expires daily at 11:05
  """
  @spec dynamic_item(integer, integer, keyword) ::
          {:ok, Esi.Api.DogmaDynamicItemsTypeIdItemIdGet.t()} | {:error, Esi.Api.Error.t()}
  def dynamic_item(item_id, type_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [item_id: item_id, type_id: type_id],
      call: {Esi.Api.Dogma, :dynamic_item},
      url: "/dogma/dynamic/items/#{type_id}/#{item_id}",
      method: :get,
      response: [
        {200, {Esi.Api.DogmaDynamicItemsTypeIdItemIdGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get effect information

  Get information on a dogma effect

  This route expires daily at 11:05
  """
  @spec effect(integer, keyword) ::
          {:ok, Esi.Api.DogmaEffectsEffectIdGet.t()} | {:error, Esi.Api.Error.t()}
  def effect(effect_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [effect_id: effect_id],
      call: {Esi.Api.Dogma, :effect},
      url: "/dogma/effects/#{effect_id}",
      method: :get,
      response: [{200, {Esi.Api.DogmaEffectsEffectIdGet, :t}}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Get effects

  Get a list of dogma effect ids

  This route expires daily at 11:05
  """
  @spec effects(keyword) :: {:ok, [integer]} | {:error, Esi.Api.Error.t()}
  def effects(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Esi.Api.Dogma, :effects},
      url: "/dogma/effects",
      method: :get,
      response: [{200, [:integer]}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
