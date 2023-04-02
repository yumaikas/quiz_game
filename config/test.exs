import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :quiz_game, QuizGameWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "BLI8/JadHbDHoK1upk7xYLNt8F1GNtVIZFIgfspCg+or79RZktHpnfoXByqOKEx1",
  server: false

# In test we don't send emails.
config :quiz_game, QuizGame.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
