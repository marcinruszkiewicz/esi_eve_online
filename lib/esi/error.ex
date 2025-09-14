defmodule Esi.Error do
  @moduledoc """
  Standardized error structure for ESI API responses.
  
  This module provides a consistent error format across all ESI endpoints,
  making error handling predictable and easier to work with.
  """

  @type error_type :: :http_error | :api_error | :validation_error | :network_error | :timeout_error

  @type t :: %__MODULE__{
    type: error_type(),
    status: integer() | nil,
    message: String.t(),
    details: map() | nil,
    request_id: String.t() | nil,
    retry_after: integer() | nil
  }

  defstruct [
    :type,
    :status,
    :message,
    :details,
    :request_id,
    :retry_after
  ]

  @doc """
  Creates a new HTTP error from a response.
  """
  @spec http_error(integer(), String.t(), map()) :: t()
  def http_error(status, message, details \\ %{}) do
    %__MODULE__{
      type: :http_error,
      status: status,
      message: message,
      details: details
    }
  end

  @doc """
  Creates a new API error from ESI error response.
  """
  @spec api_error(integer(), String.t(), map()) :: t()
  def api_error(status, message, details \\ %{}) do
    %__MODULE__{
      type: :api_error,
      status: status,
      message: message,
      details: details
    }
  end

  @doc """
  Creates a validation error for invalid request parameters.
  """
  @spec validation_error(String.t(), map()) :: t()
  def validation_error(message, details \\ %{}) do
    %__MODULE__{
      type: :validation_error,
      status: nil,
      message: message,
      details: details
    }
  end

  @doc """
  Creates a network error for connection issues.
  """
  @spec network_error(String.t(), map()) :: t()
  def network_error(message, details \\ %{}) do
    %__MODULE__{
      type: :network_error,
      status: nil,
      message: message,
      details: details
    }
  end

  @doc """
  Creates a timeout error.
  """
  @spec timeout_error(String.t(), map()) :: t()
  def timeout_error(message \\ "Request timed out", details \\ %{}) do
    %__MODULE__{
      type: :timeout_error,
      status: nil,
      message: message,
      details: details
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
