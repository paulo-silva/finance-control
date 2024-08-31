import Config

# Configure your database
config :finance_control, FinanceControl.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "finance_control_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we can use it
# to bundle .js and .css sources.
config :finance_control, FinanceControlWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "owc1TbReROsXNYc0la/MPzAYcdA+KshToW98rxFaTlbu/pM43s6GIlILeKESIZRD",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:finance_control, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:finance_control, ~w(--watch)]}
  ]

# ## SSL Support
#
# In order to use HTTPS in development, a self-signed
# certificate can be generated by running the following
# Mix task:
#
#     mix phx.gen.cert
#
# Run `mix help phx.gen.cert` for more information.
#
# The `http:` config above can be replaced with:
#
#     https: [
#       port: 4001,
#       cipher_suite: :strong,
#       keyfile: "priv/cert/selfsigned_key.pem",
#       certfile: "priv/cert/selfsigned.pem"
#     ],
#
# If desired, both `http:` and `https:` keys can be
# configured to run both http and https servers on
# different ports.

# Watch static and templates for browser reloading.
config :finance_control, FinanceControlWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/(?!uploads/).*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/finance_control_web/(controllers|live|components)/.*(ex|heex)$",
      ~r"lib/finance_control_web/(live|components)/.*neex$",
      ~r"lib/finance_control_web/styles/*.ex$",
      ~r"priv/static/*.styles$"
    ]
  ]

# Enable dev routes for dashboard and mailbox
config :finance_control, dev_routes: true

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

config :phoenix_live_view,
  # Include HEEx debug annotations as HTML comments in rendered markup
  debug_heex_annotations: true,
  # Enable helpful, but potentially expensive runtime checks
  enable_expensive_runtime_checks: true

config :live_view_native_stylesheet,
  annotations: true,
  pretty: true
