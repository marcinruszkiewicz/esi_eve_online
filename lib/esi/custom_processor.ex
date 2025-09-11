defmodule Esi.CustomProcessor do
  use OpenAPI.Processor

  defp singularize(word) do
    if String.ends_with?(word, "s") do
      String.slice(word, 0, String.length(word) - 1)
    else
      word
    end
  end

  @impl OpenAPI.Processor
  def operation_module_names(_state, operation) do
    path = operation."$oag_path"
    parts = String.split(path, "/", trim: true)
    base_module = singularize(List.first(parts)) |> Macro.camelize()
    [Module.concat([base_module])]
  end

  @impl OpenAPI.Processor
  def operation_function_name(_state, operation) do
    path = operation."$oag_path"
    method = operation."$oag_path_method"
    parts = String.split(path, "/", trim: true)

    name_parts =
      parts
      |> Enum.drop(1)
      |> Enum.reject(&String.starts_with?(&1, "{"))

    function_name =
      if name_parts == [] do
        if String.starts_with?(List.last(parts), "{") do
          "get"
        else
          "list"
        end
      else
        base = Enum.join(name_parts, "_")
        if String.starts_with?(List.last(parts), "{") do
          "get_#{base}"
        else
          base
        end
      end

    if method == :get do
      function_name
    else
      "#{method}_#{function_name}"
    end
    |> String.replace("-", "_")
    |> String.to_atom()
  end
end
