use Mix.Config

config :gistit,
  user_agent: [{"User-agent", "<<USER AGENT HERE!!!>>"}],
  base_url: "<<BASE URL HERE!!!>>",
  # Set default headers (add to **all** requests!)
  default_headers: [],
  # Set default options (for HTTPoison module) (added to **all** requests!)
  default_options: [parse_response: true],
  # Set username and password if authorization scheme is `:basic`
  user_name: "<<USER NAME HERE!!!!!>>",
  password: "<<PASSWORD HERE!!!>>",
  # Set token if authorization scheme is `:token`
  token: "<<TOKEN HERE!!!>>",
  # Set authorization scheme (`:basic` or `:token`. **ANY** other value defaults to no authorization at all!!!)
  auth_method: "<<`:basic`, `:token` OR `nil`!!!>>"

config :logger,
  backends: [{Loggix, :app_log}, {Loggix, :error_log}],
  utc_log: true

import_config "loggix.exs"

# import_config "#{Mix.env()}.exs"
