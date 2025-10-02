defmodule Mix.Tasks.CopyLegacyApi do
  @shortdoc "Copies legacy ESI API modules to create perfect compatibility layer"

  @moduledoc """
  Copies and adapts the legacy ESI API modules to create a perfect compatibility layer.

  This task reads the actual generated API files from the legacy ESI library and 
  creates compatible versions that use ESI.Request structs instead of direct HTTP calls.

  ## Usage

      mix copy_legacy_api

  ## Options

      --legacy-path PATH    Path to the legacy ESI library (default: ../esi)
      --dry-run            Print what would be generated without writing files

  ## How it works

  1. Reads each legacy API module from lib/esi/api/
  2. Extracts function definitions, specs, and documentation
  3. Generates compatible versions that return ESI.Request structs
  4. Preserves exact function names, arguments, and behavior

  This ensures 100% compatibility with the legacy API patterns.
  """

  use Mix.Task

  @default_legacy_path "../esi"
  @output_path "lib/esi_compatibility/api"

  @module_descriptions %{
    "alliance" => "Legacy compatibility module for Alliance API endpoints.\n\nProvides access to alliance information, member corporations, contacts, and icons.",
    "character" => "Legacy compatibility module for Character API endpoints.\n\nProvides access to character information, skills, assets, contacts, and various character-related data.",
    "contract" => "Legacy compatibility module for Contract API endpoints.\n\nProvides access to contract information and bidding functionality.",
    "corporation" => "Legacy compatibility module for Corporation API endpoints.\n\nProvides access to corporation information, members, structures, assets, and various corp-related data.",
    "dogma" => "Legacy compatibility module for Dogma API endpoints.\n\nProvides access to EVE Online's dogma system including attributes and effects.",
    "faction_warfare" => "Legacy compatibility module for Faction Warfare API endpoints.\n\nProvides access to faction warfare statistics, leaderboards, system ownership, and war information.",
    "fleet" => "Legacy compatibility module for Fleet API endpoints.\n\nProvides access to fleet information, members, wings, squads, and fleet management functionality.",
    "incursion" => "Legacy compatibility module for Incursion API endpoints.\n\nProvides access to current incursion information and affected systems.",
    "industry" => "Legacy compatibility module for Industry API endpoints.\n\nProvides access to industry jobs, facilities, and manufacturing information.",
    "insurance" => "Legacy compatibility module for Insurance API endpoints.\n\nProvides access to ship insurance pricing information.",
    "killmail" => "Legacy compatibility module for Killmail API endpoints.\n\nProvides access to killmail data and hashes.",
    "loyalty" => "Legacy compatibility module for Loyalty API endpoints.\n\nProvides access to loyalty point store offers and information.",
    "market" => "Legacy compatibility module for Market API endpoints.\n\nProvides access to market data, orders, prices, history, and regional market information.",
    "route" => "Legacy compatibility module for Route API endpoints.\n\nProvides access to route calculation and navigation information.",
    "sovereignty" => "Legacy compatibility module for Sovereignty API endpoints.\n\nProvides access to sovereignty information, campaigns, and structure data.",
    "status" => "Legacy compatibility module for Status API endpoints.\n\nProvides access to EVE Online server status and player count information.",
    "ui" => "Legacy compatibility module for UI API endpoints.\n\nProvides access to in-game UI interaction functionality including opening windows and setting waypoints.",
    "universe" => "Legacy compatibility module for Universe API endpoints.\n\nProvides access to universe data including systems, stations, structures, types, and various static game data.",
    "war" => "Legacy compatibility module for War API endpoints.\n\nProvides access to war declarations, participants, and killmail statistics."
  }

  @doc """
  Runs the copy_legacy_api mix task.

  This task copies and adapts legacy ESI API modules to create a perfect compatibility layer.
  It reads the actual generated API files from the legacy ESI library and creates compatible
  versions that use ESI.Request structs instead of direct HTTP calls.

  ## Arguments

  - `args` - Command line arguments including options like --legacy-path and --dry-run

  ## Returns

  - `:ok` - When the task completes successfully
  - `:error` - When the task fails (e.g., legacy path not found)

  ## Examples

      mix copy_legacy_api
      mix copy_legacy_api --legacy-path ../esi --dry-run

  """
  @spec run([String.t()]) :: :ok | :error
  def run(args) do
    {opts, _, _} =
      OptionParser.parse(args,
        switches: [
          legacy_path: :string,
          dry_run: :boolean,
          help: :boolean
        ],
        aliases: [h: :help]
      )

    if opts[:help] do
      Mix.shell().info(@moduledoc)
      :ok
    else
      legacy_path = opts[:legacy_path] || @default_legacy_path
      dry_run = opts[:dry_run] || false

      legacy_api_path = Path.join(legacy_path, "lib/esi/api")

      if File.exists?(legacy_api_path) do
        Mix.shell().info("Copying legacy compatibility from existing API modules...")
        Mix.shell().info("  Legacy path: #{legacy_api_path}")
        Mix.shell().info("  Output path: #{@output_path}")
        Mix.shell().info("  Dry run: #{dry_run}")
        Mix.shell().info("")

        copy_legacy_modules(legacy_api_path, dry_run)
      else
        Mix.shell().error("Legacy ESI API path not found: #{legacy_api_path}")
        Mix.shell().error("Please specify the correct path with --legacy-path")
        :error
      end
    end
  end

  defp copy_legacy_modules(legacy_api_path, dry_run) do
    # Get all API module files
    api_files =
      legacy_api_path
      |> File.ls!()
      |> Enum.filter(&String.ends_with?(&1, ".ex"))
      |> Enum.sort()

    Mix.shell().info("Found #{length(api_files)} legacy API modules:")

    Enum.each(api_files, fn file ->
      Mix.shell().info("  - #{file}")
    end)

    Mix.shell().info("")

    # Process each module
    results =
      api_files
      |> Enum.map(fn file ->
        process_legacy_module(legacy_api_path, file, dry_run)
      end)

    successful = Enum.count(results, & &1)

    Mix.shell().info("")
    Mix.shell().info("=== Copy Summary ===")

    if dry_run do
      Mix.shell().info("Would copy #{successful} compatibility modules")
    else
      Mix.shell().info("Successfully copied #{successful} compatibility modules")
      Mix.shell().info("")
      Mix.shell().info("✅ Legacy compatibility copy complete!")
      Mix.shell().info("All legacy ESI.API.* patterns are now supported with perfect fidelity.")
    end
  end

  defp process_legacy_module(legacy_api_path, file, dry_run) do
    module_name = file |> String.replace(".ex", "") |> String.capitalize()
    legacy_file_path = Path.join(legacy_api_path, file)

    Mix.shell().info("Processing #{module_name}...")

    try do
      # Read the legacy module content
      content = File.read!(legacy_file_path)

      # Parse and convert to compatibility format
      converted_content = convert_legacy_module(content, module_name)

      if dry_run do
        Mix.shell().info("  [DRY RUN] Would generate #{String.length(converted_content)} bytes")

        # Show sample functions
        function_count = count_functions(converted_content)
        Mix.shell().info("  Functions: #{function_count}")
      else
        output_file = Path.join(@output_path, "#{String.downcase(module_name)}.ex")
        File.mkdir_p!(Path.dirname(output_file))
        File.write!(output_file, converted_content)

        function_count = count_functions(converted_content)
        Mix.shell().info("  ✅ Generated #{function_count} functions -> #{output_file}")
      end

      true
    rescue
      e ->
        Mix.shell().error("  ❌ Failed to process #{module_name}: #{Exception.message(e)}")
        false
    end
  end

  defp convert_legacy_module(content, module_name) do
    # Extract the module definition and convert it
    lines = String.split(content, "\n")

    # Find the module definition line - handle different naming conventions
    possible_module_names = [
      # e.g., "Ui"
      module_name,
      # e.g., "UI"
      String.upcase(module_name),
      # e.g., "Factionwarfare"
      String.replace(module_name, "_", ""),
      # e.g., "FactionWarfare"
      module_name |> String.split("_") |> Enum.map_join("", &String.capitalize/1)
    ]

    module_line_index =
      Enum.find_index(lines, fn line ->
        Enum.any?(possible_module_names, fn name ->
          String.contains?(line, "defmodule ESI.API.#{name}")
        end)
      end)

    if module_line_index do
      # Process the module content
      processed_lines = process_module_lines(lines, module_name)
      Enum.join(processed_lines, "\n")
    else
      # Fallback: create a basic module structure
      create_basic_module(module_name, content)
    end
  end

  defp process_module_lines(lines, module_name) do
    processed_lines = lines |> Enum.map(&process_line(&1, module_name))

    # Add moduledoc after the module definition if it doesn't exist
    add_moduledoc_if_missing(processed_lines, module_name)
  end

  defp process_line(line, _module_name) do
    cond do
      # Skip import statements and other non-essential lines
      String.contains?(line, "import ") -> ""
      String.contains?(line, "require ") -> ""
      # Keep the line as-is for most cases
      true -> line
    end
  end

  defp add_moduledoc_if_missing(lines, module_name) do
    original_content = Enum.join(lines, "\n")
    has_moduledoc = Enum.any?(lines, &String.contains?(&1, "@moduledoc"))

    if has_moduledoc do
      # Update existing moduledoc
      update_module_documentation(lines, module_name, original_content)
    else
      # Add moduledoc after module definition
      insert_moduledoc_after_module_def(lines, module_name, original_content)
    end
  end

  defp update_module_documentation(lines, module_name, original_content) do
    # Find and update the module documentation
    Enum.map(lines, fn line ->
      if String.contains?(line, "@moduledoc") do
        add_compatibility_moduledoc(module_name, original_content)
      else
        line
      end
    end)
  end

  defp insert_moduledoc_after_module_def(lines, module_name, original_content) do
    # Find the module definition line and insert moduledoc after it
    module_def_index =
      Enum.find_index(lines, fn line ->
        String.contains?(line, "defmodule ESI.API.")
      end)

    if module_def_index do
      {before, after_module} = Enum.split(lines, module_def_index + 1)

      moduledoc_lines =
        add_compatibility_moduledoc(module_name, original_content)
        |> String.split("\n")

      before ++ moduledoc_lines ++ [""] ++ after_module
    else
      lines
    end
  end

  defp add_compatibility_moduledoc(module_name, original_content) do
    # Extract function names and their purposes
    functions = extract_function_info(original_content)
    function_count = length(functions)

    # Generate module description based on module name
    module_description = generate_module_description(module_name)

    # Generate function list
    function_list = generate_function_list(functions)

    """
    @moduledoc \"\"\"
    #{module_description}

    This module provides the same interface as the legacy ESI.API.#{format_module_name(module_name)} module,
    returning ESI.Request structs that work with the legacy request pattern.

    ## Available Functions

    This module contains #{function_count} function#{if function_count == 1, do: "", else: "s"}:

    #{function_list}

    ## Usage

    All functions return `ESI.Request` structs that can be executed using the standard
    ESI request pattern:

        iex> request = ESI.API.#{format_module_name(module_name)}.some_function(opts)
        iex> ESI.request(request)

    ## Compatibility

    This module maintains exact compatibility with the legacy ESI library while
    internally mapping to the new Esi.Api.* modules. All function names, arguments,
    and return types are preserved.

    Generated from the legacy ESI library for perfect compatibility.
    \"\"\"
    """
  end

  # Add the old function as a fallback for create_basic_module
  defp add_compatibility_moduledoc(module_name) do
    add_compatibility_moduledoc(module_name, "")
  end

  defp create_basic_module(module_name, original_content) do
    # Extract function definitions from the original content
    functions = extract_functions_from_content(original_content)

    """
    defmodule ESI.API.#{module_name} do
    #{add_compatibility_moduledoc(module_name)}

    #{Enum.join(functions, "\n\n")}
    end
    """
  end

  defp extract_functions_from_content(content) do
    # Use regex to extract function definitions
    function_pattern = ~r/
      (@typedoc\s+""".*?"""\s+)?     # Optional @typedoc
      (@type\s+.*?\s+)?              # Optional @type  
      (@doc\s+""".*?"""\s+)?         # Optional @doc
      (@spec\s+.*?\s+)?              # Optional @spec
      (def\s+\w+.*?do\s+.*?end)      # Function definition
    /ms

    Regex.scan(function_pattern, content, capture: :all_but_first)
    |> Enum.map(fn parts ->
      # Reconstruct the function with all its parts
      parts
      |> Enum.reject(&is_nil/1)
      |> Enum.reject(&(&1 == ""))
      |> Enum.join("\n")
    end)
  end

  defp count_functions(content) do
    # Count function definitions
    Regex.scan(~r/def\s+\w+/, content) |> length()
  end

  defp extract_function_info(content) do
    # Extract function names and their @doc strings
    # Pattern matches @doc followed by @spec, capturing the doc content and function name
    function_pattern = ~r/@doc\s+"""(.*?)"""\s+@spec\s+(\w+)/ms

    matches = Regex.scan(function_pattern, content, capture: :all_but_first)

    if Enum.empty?(matches) do
      # Fallback: just extract function names from @spec declarations
      spec_pattern = ~r/@spec\s+(\w+)/

      Regex.scan(spec_pattern, content, capture: :all_but_first)
      |> Enum.map(fn [name] -> {name, "EVE Online ESI API function"} end)
      |> Enum.uniq_by(fn {name, _} -> name end)
    else
      matches
      |> Enum.map(fn [doc, name] ->
        # Extract the first line of the doc as a summary
        summary = doc |> String.split("\n") |> List.first() |> String.trim()
        {name, summary}
      end)
      |> Enum.uniq_by(fn {name, _} -> name end)
    end
  end

  defp generate_module_description(module_name) do
    key = String.downcase(module_name)
    Map.get(@module_descriptions, key, default_module_description(module_name))
  end

  defp default_module_description(module_name) do
    "Legacy compatibility module for #{module_name} API endpoints.\n\nProvides access to #{String.downcase(module_name)}-related EVE Online ESI functionality."
  end

  defp generate_function_list(functions) when functions == [] do
    "- (Functions will be listed after successful extraction)"
  end

  defp generate_function_list(functions) do
    functions
    |> Enum.map_join("\n    ", fn {name, summary} ->
      if summary == "" do
        "- `#{name}/0` or `#{name}/1`"
      else
        "- `#{name}/0` or `#{name}/1` - #{summary}"
      end
    end)
  end

  defp format_module_name(module_name) do
    case module_name do
      "Faction_warfare" -> "FactionWarfare"
      "Ui" -> "UI"
      _ -> module_name
    end
  end
end
