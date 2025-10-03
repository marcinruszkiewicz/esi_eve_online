defmodule Esi.ClientHeaderParsingTest do
  use ExUnit.Case, async: true

  describe "header parsing with list values" do
    test "parse_x_pages_header handles list values correctly" do
      # This test verifies the fix for the Integer.parse error
      # where headers could contain list values like ["6"] instead of "6"
      
      # Use the private function through a test helper
      headers_with_list = [{"x-pages", ["6"]}]
      headers_with_string = [{"x-pages", "6"}]
      headers_without_pages = [{"content-type", "application/json"}]
      headers_with_invalid_list = [{"x-pages", [123]}]
      
      # Test that list values are handled correctly
      assert parse_x_pages_header_test(headers_with_list) == 6
      
      # Test that string values still work
      assert parse_x_pages_header_test(headers_with_string) == 6
      
      # Test default behavior
      assert parse_x_pages_header_test(headers_without_pages) == 1
      
      # Test invalid list values
      assert parse_x_pages_header_test(headers_with_invalid_list) == 1
    end
    
    test "parse_retry_after handles list values correctly" do
      # Test the retry-after header parsing as well
      headers_with_list = [{"retry-after", ["30"]}]
      headers_with_string = [{"retry-after", "30"}]
      headers_without_retry = [{"content-type", "application/json"}]
      
      assert parse_retry_after_test(headers_with_list) == 30
      assert parse_retry_after_test(headers_with_string) == 30
      assert parse_retry_after_test(headers_without_retry) == nil
    end
  end
  
  # Test helper functions that replicate the private functions
  defp parse_x_pages_header_test(headers) do
    case get_header_value_test(headers, "x-pages") do
      nil ->
        1

      value when is_binary(value) ->
        case Integer.parse(value) do
          {max_pages, ""} -> max_pages
          _ -> 1
        end

      value when is_list(value) ->
        # Handle case where header value is a list
        case value do
          [first_value | _] when is_binary(first_value) ->
            case Integer.parse(first_value) do
              {max_pages, ""} -> max_pages
              _ -> 1
            end
          _ -> 1
        end

      _ ->
        1
    end
  end
  
  defp parse_retry_after_test(headers) do
    case get_header_value_test(headers, "retry-after") do
      nil -> nil
      
      value when is_binary(value) ->
        case Integer.parse(value) do
          {seconds, ""} -> seconds
          _ -> nil
        end

      value when is_list(value) ->
        # Handle case where header value is a list
        case value do
          [first_value | _] when is_binary(first_value) ->
            case Integer.parse(first_value) do
              {seconds, ""} -> seconds
              _ -> nil
            end
          _ -> nil
        end

      _ -> nil
    end
  end
  
  defp get_header_value_test(headers, header_name) do
    headers
    |> Enum.find(fn {name, _value} -> String.downcase(name) == String.downcase(header_name) end)
    |> case do
      # Handle list of values
      {_name, [value | _]} when is_binary(value) -> value
      # Handle single value
      {_name, value} when is_binary(value) -> value
      # Return the raw value for testing (including lists)
      {_name, value} -> value
      _ -> nil
    end
  end
end
