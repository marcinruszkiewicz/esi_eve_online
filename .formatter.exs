# Used by "mix format"
[
  plugins: [Quokka],
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"],
  quokka: [
    files: %{
      excluded: [
        "lib/esi_compatibility/api/dogma.ex",
        "lib/esi_compatibility/api/alliance.ex",
        "lib/esi_compatibility/api/character.ex",
        "lib/esi_compatibility/api/contract.ex",
        "lib/esi_compatibility/api/corporation.ex",
        "lib/esi_compatibility/api/dogma.ex",
        "lib/esi_compatibility/api/factionwarfare.ex",
        "lib/esi_compatibility/api/fleet.ex",
        "lib/esi_compatibility/api/incursion.ex",
        "lib/esi_compatibility/api/industry.ex",
        "lib/esi_compatibility/api/insurance.ex",
        "lib/esi_compatibility/api/killmail.ex",
        "lib/esi_compatibility/api/loyalty.ex",
        "lib/esi_compatibility/api/market.ex",
        "lib/esi_compatibility/api/route.ex",
        "lib/esi_compatibility/api/sovereignty.ex",
        "lib/esi_compatibility/api/status.ex",
        "lib/esi_compatibility/api/ui.ex",
        "lib/esi_compatibility/api/universe.ex",
        "lib/esi_compatibility/api/war.ex"
      ]
    },
    exclude: [
      :nums_with_underscores
    ]
  ]
]
