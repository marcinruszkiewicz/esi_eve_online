defmodule Esi.Error do
  @moduledoc """
  Standardized error structure for ESI API responses.

  This module provides a consistent error format across all ESI endpoints,
  making error handling predictable and easier to work with.
  """

  @type error_type ::
          :http_error | :api_error | :validation_error | :network_error | :timeout_error

  @type t :: %__MODULE__{
          details: map() | nil,
          message: String.t(),
          request_id: String.t() | nil,
          retry_after: integer() | nil,
          status: integer() | nil,
          type: error_type()
        }

  defstruct [
    :details,
    :message,
    :request_id,
    :retry_after,
    :status,
    :type
  ]

  @doc """
  Creates a new HTTP error from a response.
  """
  @spec http_error(integer(), String.t(), map()) :: t()
  def http_error(status, message, details \\ %{}) do
    %__MODULE__{
      details: details,
      message: message,
      status: status,
      type: :http_error
    }
  end

  @doc """
  Creates a new API error from ESI error response.
  """
  @spec api_error(integer(), String.t(), map()) :: t()
  def api_error(status, message, details \\ %{}) do
    %__MODULE__{
      details: details,
      message: message,
      status: status,
      type: :api_error
    }
  end

  @doc """
  Creates a validation error for invalid request parameters.
  """
  @spec validation_error(String.t(), map()) :: t()
  def validation_error(message, details \\ %{}) do
    %__MODULE__{
      details: details,
      message: message,
      status: nil,
      type: :validation_error
    }
  end

  @doc """
  Creates a network error for connection issues.
  """
  @spec network_error(String.t(), map()) :: t()
  def network_error(message, details \\ %{}) do
    %__MODULE__{
      details: details,
      message: message,
      status: nil,
      type: :network_error
    }
  end

  @doc """
  Creates a timeout error.
  """
  @spec timeout_error(String.t(), map()) :: t()
  def timeout_error(message \\ "Request timed out", details \\ %{}) do
    %__MODULE__{
      details: details,
      message: message,
      status: nil,
      type: :timeout_error
    }
  end

  @doc """
  Extracts retry-after information from error details.
  """
  @spec with_retry_after(t(), integer()) :: t()
  def with_retry_after(%__MODULE__{} = error, retry_after) do
    %{error | retry_after: retry_after}
  end

  @doc """
  Adds request ID for debugging purposes.
  """
  @spec with_request_id(t(), String.t()) :: t()
  def with_request_id(%__MODULE__{} = error, request_id) do
    %{error | request_id: request_id}
  end
end
