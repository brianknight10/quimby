module Wrappable
  extend ActiveSupport::Concern

  def wrap
    response = vault.post do |req|
      req.url '/v1/sys/wrapping/wrap'
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-Vault-Token'] = ENV['VAULT_TOKEN']
      req.headers['X-Vault-Wrap-TTL'] = "#{ttl}"
      req.body = "{ \"secret\": \"#{Base64.strict_encode64(text)}\" }"
    end
    self.token = response.body['wrap_info']['token']
  end

  def unwrap
    response = vault.post do |req|
      req.url '/v1/sys/wrapping/unwrap'
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-Vault-Token'] = ENV['VAULT_TOKEN']
      req.body = "{ \"token\": \"#{token}\" }"
    end
    self.text = Base64.strict_decode64("#{response.body['data']['secret']}")
  end

private

  def vault
    Faraday.new(url: ENV['VAULT_ADDR']) do |c|
      c.response :json, content_type: /\bjson$/
      c.response :logger if Rails.env.development?
      c.use RaiseVaultException
      c.adapter Faraday.default_adapter
    end
  end
end
