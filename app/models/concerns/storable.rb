module Storable
  extend ActiveSupport::Concern

  def read
    begin
      self.text = vault.logical.read(path).data[:value]
    rescue Vault::HTTPClientError
      raise RetrievalError
    end
  end

  def write
    vault.logical.write(path, value: text)
  end

private

  def path
    "/cubbyhole/#{token.client_token}"
  end

  def vault
    Vault::Client.new(token: token.client_token)
  end
end
