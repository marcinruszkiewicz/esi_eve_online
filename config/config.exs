import Config

config :oapi_generator,
  default: [
    processor: Esi.CustomProcessor,
    renderer: Esi.CustomProcessor,
    naming: [
      operation_use_tags: false
    ],
    output: [
      base_module: Esi.Api,
      location: "lib/esi/api",
      default_client: Esi.Client
    ]
  ]
