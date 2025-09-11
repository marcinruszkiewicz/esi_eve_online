import Config

config :oapi_generator, default: [
  processor: Esi.CustomProcessor,

  output: [
    base_module: Esi.Api,
    location: "lib/esi/api"
  ]
]