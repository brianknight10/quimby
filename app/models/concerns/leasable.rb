module Leasable
  extend ActiveSupport::Concern

  def generate_lease(ttl)
    secret = authenticate!(ttl)

    self.client_token = secret.auth.client_token
    self.lease_duration = secret.auth.lease_duration
    self.renewable = false
  end

private

  def authenticate!(ttl)
    Vault::Client.new.auth_token.create(
      num_uses: 2,
      renewable: false,
      explicit_max_ttl: '24h'
    )
  end
end
