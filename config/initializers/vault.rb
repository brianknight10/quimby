Vault.configure do |config|
  # The address of the Vault server, also read as ENV["VAULT_ADDR"]
  config.address = ENV['VAULT_ADDR']

  # The token to authenticate with Vault, also read as ENV["VAULT_TOKEN"]
  config.token = ENV['VAULT_TOKEN']

  # Use SSL verification, also read as ENV["VAULT_SSL_VERIFY"]
  config.ssl_verify = true

  # Timeout the connection after a certain amount of time (seconds), also read
  # as ENV["VAULT_TIMEOUT"]
  config.timeout = 30
end
