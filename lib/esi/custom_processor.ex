defmodule Esi.CustomProcessor do
  use OpenAPI.Processor

  @impl OpenAPI.Processor
  def operation_function_name(_state, operation) do
    path = operation."$oag_path"
    path
    |> String.split("/")
    |> Enum.reverse()
    |> Enum.find(fn part -> !String.starts_with?(part, "{") and part != "" end)
    |> String.to_atom()
  end
end