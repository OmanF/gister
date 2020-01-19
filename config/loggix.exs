use Mix.Config

config :logger, :app_log,
  path: "#{Path.expand("./log")}/app.log",
  level: :debug,
  rotate: %{max_bytes: 40960, keep: 10}

config :logger, :error_log,
  path: "#{Path.expand("./log")}/error.log",
  level: :error,
  rotate: %{max_bytes: 40960, keep: 10}
