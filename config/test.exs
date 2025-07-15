import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :gtd_calc, GtdCalcWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "1GUU69RB9c6HdRBdnrEoCq2ANv7XEv3bIWnFb96iIw8Nq8Kpvt12F8Cv/8WV/zHc",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true
