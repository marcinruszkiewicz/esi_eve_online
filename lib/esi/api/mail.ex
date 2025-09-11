defmodule Esi.Api.Mail do
  @moduledoc """
  Provides API endpoints related to mail
  """

  @default_client Esi.Api.Client

  @doc """
  Get mail labels and unread counts

  Return a list of the users mail labels, unread counts for each label and a total unread count.
  """
  @spec labels(integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdMailLabelsGet.t()} | {:error, Esi.Api.Error.t()}
  def labels(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Mail, :labels},
      url: "/characters/#{character_id}/mail/labels",
      method: :get,
      response: [
        {200, {Esi.Api.CharactersCharacterIdMailLabelsGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Create a mail label

  Create a mail label
  """
  @spec labels(integer, map, keyword) :: {:ok, integer} | {:error, Esi.Api.Error.t()}
  def labels(character_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, body: body],
      call: {Esi.Api.Mail, :labels},
      url: "/characters/#{character_id}/mail/labels",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, :integer}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Delete a mail label

  Delete a mail label
  """
  @spec labels(integer, integer, keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def labels(character_id, label_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, label_id: label_id],
      call: {Esi.Api.Mail, :labels},
      url: "/characters/#{character_id}/mail/labels/#{label_id}",
      method: :delete,
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Return mailing list subscriptions

  Return all mailing lists that the character is subscribed to
  """
  @spec lists(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdMailListsGet.t()]} | {:error, Esi.Api.Error.t()}
  def lists(character_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Mail, :lists},
      url: "/characters/#{character_id}/mail/lists",
      method: :get,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdMailListsGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Return mail headers

  Return the 50 most recent mail headers belonging to the character that match the query criteria. Queries can be filtered by label, and last_mail_id can be used to paginate backwards

  ## Options

    * `labels`
    * `last_mail_id`

  """
  @spec mail(integer, keyword) ::
          {:ok, [Esi.Api.CharactersCharacterIdMailGet.t()]} | {:error, Esi.Api.Error.t()}
  def mail(character_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:labels, :last_mail_id])

    client.request(%{
      args: [character_id: character_id],
      call: {Esi.Api.Mail, :mail},
      url: "/characters/#{character_id}/mail",
      method: :get,
      query: query,
      response: [
        {200, [{Esi.Api.CharactersCharacterIdMailGet, :t}]},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Send a new mail

  Create and send a new mail
  """
  @spec mail(integer, map, keyword) :: {:ok, integer} | {:error, Esi.Api.Error.t()}
  def mail(character_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, body: body],
      call: {Esi.Api.Mail, :mail},
      url: "/characters/#{character_id}/mail",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, :integer}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Return a mail

  Return the contents of an EVE mail
  """
  @spec mail(integer, integer, keyword) ::
          {:ok, Esi.Api.CharactersCharacterIdMailMailIdGet.t()} | {:error, Esi.Api.Error.t()}
  def mail(character_id, mail_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, mail_id: mail_id],
      call: {Esi.Api.Mail, :mail},
      url: "/characters/#{character_id}/mail/#{mail_id}",
      method: :get,
      response: [
        {200, {Esi.Api.CharactersCharacterIdMailMailIdGet, :t}},
        default: {Esi.Api.Error, :t}
      ],
      opts: opts
    })
  end

  @doc """
  Update metadata about a mail

  Update metadata about a mail
  """
  @spec mail(integer, integer, map, keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def mail(character_id, mail_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, mail_id: mail_id, body: body],
      call: {Esi.Api.Mail, :mail},
      url: "/characters/#{character_id}/mail/#{mail_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end

  @doc """
  Delete a mail

  Delete a mail
  """
  @spec mail(integer, integer, keyword) :: :ok | {:error, Esi.Api.Error.t()}
  def mail(character_id, mail_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [character_id: character_id, mail_id: mail_id],
      call: {Esi.Api.Mail, :mail},
      url: "/characters/#{character_id}/mail/#{mail_id}",
      method: :delete,
      response: [{204, :null}, default: {Esi.Api.Error, :t}],
      opts: opts
    })
  end
end
