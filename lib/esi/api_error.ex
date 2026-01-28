defmodule Esi.ApiError do
  @moduledoc """
  Exception raised when an ESI API request fails (e.g. 503 maintenance, 404, 401).

  Use this when calling `get!/2`, `post!/2`, etc. to rescue and handle API errors:

      try do
        EsiEveOnline.get!("/status")
      rescue
        Esi.ApiError -> error ->
          # error.error is the %Esi.Error{} struct
          case error.error.status do
            503 -> IO.puts("ESI in maintenance, retry after: \#{error.error.retry_after}s")
            404 -> IO.puts("Not found")
            _ -> reraise error, __STACKTRACE__
          end
      end
  """
  defexception [:message, :error]

  @type t :: %__MODULE__{message: String.t(), error: Esi.Error.t()}

  @impl true
  def exception(%Esi.Error{} = error) do
    %__MODULE__{message: error.message, error: error}
  end

  def exception(message) when is_binary(message) do
    %__MODULE__{
      message: message,
      error: Esi.Error.network_error(message, %{})
    }
  end
end
