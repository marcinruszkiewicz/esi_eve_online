defmodule EsiEveOnline.Test.FixtureLoader do
  @moduledoc """
  Helper module for loading and using mock API responses in tests.
  
  This module provides utilities to load mock API responses that simulate
  real ESI API behavior, including proper pagination with x-pages headers.
  """

  @fixtures_dir "test/fixtures"

  @doc """
  Load a mock API response from the fixtures directory.
  
  ## Examples
  
      iex> FixtureLoader.load_response("character_assets_page1.json")
      {:ok, %{endpoint: "/characters/123/assets/", data: [...], headers: %{...}}}
      
      iex> FixtureLoader.load_response("nonexistent.json")
      {:error, :not_found}
  """
  @spec load_response(String.t()) :: {:ok, map()} | {:error, :not_found | :invalid_json}
  def load_response(filename) do
    file_path = Path.join(@fixtures_dir, filename)
    
    case File.read(file_path) do
      {:ok, content} ->
        case Jason.decode(content) do
          {:ok, data} -> {:ok, data}
          {:error, _} -> {:error, :invalid_json}
        end
      
      {:error, :enoent} -> {:error, :not_found}
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  Load a captured API response and return just the data portion.
  
  ## Examples
  
      iex> FixtureLoader.load_data("character_assets_page1.json")
      {:ok, [%{"item_id" => 123, "type_id" => 456}, ...]}
  """
  @spec load_data(String.t()) :: {:ok, term()} | {:error, :not_found | :invalid_json}
  def load_data(filename) do
    case load_response(filename) do
      {:ok, %{"data" => data}} -> {:ok, data}
      {:ok, _} -> {:error, :invalid_json}
      error -> error
    end
  end

  @doc """
  Load a captured API response and return just the headers portion.
  
  ## Examples
  
      iex> FixtureLoader.load_headers("character_assets_page1.json")
      {:ok, %{"x-pages" => "3", "x-esi-request-id" => "abc123"}}
  """
  @spec load_headers(String.t()) :: {:ok, map()} | {:error, :not_found | :invalid_json}
  def load_headers(filename) do
    case load_response(filename) do
      {:ok, %{"headers" => headers}} -> {:ok, headers}
      {:ok, _} -> {:error, :invalid_json}
      error -> error
    end
  end

  @doc """
  Load a captured API response and return the pagination info.
  
  ## Examples
  
      iex> FixtureLoader.load_pagination_info("character_assets_page1.json")
      {:ok, %{x_pages: "3", x_esi_request_id: "abc123"}}
  """
  @spec load_pagination_info(String.t()) :: {:ok, map()} | {:error, :not_found | :invalid_json}
  def load_pagination_info(filename) do
    case load_response(filename) do
      {:ok, %{"pagination" => pagination}} -> {:ok, pagination}
      {:ok, %{"headers" => headers}} -> 
        # Extract pagination info from headers
        pagination = %{
          x_pages: headers["x-pages"],
          x_esi_request_id: headers["x-esi-request-id"],
          x_esi_error_limit_remain: headers["x-esi-error-limit-remain"],
          x_esi_error_limit_reset: headers["x-esi-error-limit-reset"]
        }
        {:ok, pagination}
      {:ok, _} -> {:error, :invalid_json}
      error -> error
    end
  end

  @doc """
  Create a mock response tuple from a captured response.
  
  This is useful for mocking EsiEveOnline.get_with_headers/2 calls.
  
  ## Examples
  
      iex> FixtureLoader.mock_response_tuple("character_assets_page1.json")
      {:ok, [%{"item_id" => 123}], 3}
  """
  @spec mock_response_tuple(String.t()) :: {:ok, term(), integer()} | {:error, any()}
  def mock_response_tuple(filename) do
    case load_response(filename) do
      {:ok, %{"data" => data, "headers" => headers}} ->
        max_pages = case headers["x-pages"] do
          nil -> 1
          pages_str -> 
            case Integer.parse(pages_str) do
              {pages, ""} -> pages
              _ -> 1
            end
        end
        {:ok, data, max_pages}
      
      error -> error
    end
  end

  @doc """
  List all available fixture files.
  
  ## Examples
  
      iex> FixtureLoader.list_fixtures()
      ["character_assets_page1.json", "universe_bloodlines.json", ...]
  """
  @spec list_fixtures() :: [String.t()]
  def list_fixtures do
    case File.ls(@fixtures_dir) do
      {:ok, files} -> 
        files
        |> Enum.filter(&String.ends_with?(&1, ".json"))
        |> Enum.sort()
      {:error, _} -> []
    end
  end

  @doc """
  Create a mock for EsiEveOnline.get_with_headers/2 using captured responses.
  
  This is particularly useful for testing pagination scenarios.
  
  ## Examples
  
      # Mock a paginated endpoint
      with_mock EsiEveOnline, FixtureLoader.mock_get_with_headers([
        "character_assets_page1.json",
        "character_assets_page2.json"
      ]) do
        # Your test code here
      end
  """
  @spec mock_get_with_headers([String.t()]) :: list()
  def mock_get_with_headers(filenames) do
    responses = Enum.map(filenames, fn filename ->
      case mock_response_tuple(filename) do
        {:ok, data, max_pages} -> {:ok, data, max_pages}
        {:error, _} -> {:ok, [], 1}
      end
    end)
    
    # Create a mock function that returns responses in order
    # We'll use a simple counter approach
    counter = :erlang.make_ref()
    
    [get_with_headers: fn(_path, _opts) -> 
      # Get the current counter value
      current = Process.get(counter, 0)
      
      # Return the response at the current index
      response = Enum.at(responses, current, {:ok, [], 1})
      
      # Increment the counter
      Process.put(counter, current + 1)
      
      response
    end]
  end

  @doc """
  Create a mock for EsiEveOnline.get/2 using captured responses.
  
  ## Examples
  
      with_mock EsiEveOnline, FixtureLoader.mock_get([
        "universe_bloodlines.json"
      ]) do
        # Your test code here
      end
  """
  @spec mock_get([String.t()]) :: list()
  def mock_get(filenames) do
    responses = Enum.map(filenames, fn filename ->
      case load_data(filename) do
        {:ok, data} -> {:ok, data}
        {:error, _} -> {:ok, []}
      end
    end)
    
    response_stream = Stream.cycle(responses)
    
    [get: fn(_path, _opts) -> 
      response_stream |> Enum.take(1) |> hd()
    end]
  end
end
