defmodule Esi.Api.Calendar do
  @moduledoc """
  Provides API endpoints related to calendar
  """

  @default_client Esi.Api.Client

  @doc """
  Get attendees

  Get all invited attendees for a given event
  """
  @spec attendees(integer, integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdCalendarEventIdAttendeesGet.t()]}
          | {:error, Esi.Api.Error.t()}
  def attendees(character_id, event_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, event_id: event_id],
      call: {Esi.Api.Calendar, :attendees},
      url: "/characters/#{character_id}/calendar/#{event_id}/attendees",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdCalendarEventIdAttendeesGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Get an event

  Get all the information for a specific event
  """
  @spec calendar(integer, integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdCalendarEventIdGet.t()} | {:error, Esi.Api.Error.t()}
  def calendar(character_id, event_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, event_id: event_id],
      call: {Esi.Api.Calendar, :calendar},
      url: "/characters/#{character_id}/calendar/#{event_id}",
      method: :get,
      response: [
        {200, {Esi.Api.CharactersCharacterIdCalendarEventIdGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Respond to an event

  Set your response status to an event
  """
  @spec calendar(integer, integer, map, keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def calendar(character_id, event_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, event_id: event_id, body: body],
      call: {Esi.Api.Calendar, :calendar},
      url: "/characters/#{character_id}/calendar/#{event_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  List calendar event summaries

  Get 50 event summaries from the calendar. If no from_event ID is given, the resource will return the next 50 chronological event summaries from now. If a from_event ID is specified, it will return the next 50 chronological event summaries from after that event

  ## Options

    * `from_event`

  """
  @spec calendar(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdCalendarGet.t()]} | {:error, Esi.Api.Error.t()}
  def calendar(character_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:from_event])

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Calendar, :calendar},
      url: "/characters/#{character_id}/calendar",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdCalendarGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end
end
