%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["lib/", "test/"],
        excluded: [~r"/lib/esi/api/"]
      },
      checks: %{
        disabled: [
          # this means that `TabsOrSpaces` will not run
          {Credo.Check.Readability.LargeNumbers, []},
        ]
      }
    }
  ]
}
