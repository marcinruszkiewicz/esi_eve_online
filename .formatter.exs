# Used by "mix format"
[
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"],
  plugins: [Quokka],
  quokka: [
    autosort: [:map, :defstruct, :schema],
    files: %{
      included: [
        "lib/",
        "config/",
        "test/"
      ],
      excluded: [
        "lib/esi/api/",
        "lib/esi_compatibility/api/"
      ]
    }
  ]
]
