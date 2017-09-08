class TokenCreation
  include DCI::Context

  attr_writer :token_source

  def perform(ttl = '12h')
    token = new_token

    token.as(Leasable) { token.generate_lease(ttl) }
    token
  end

private

  def new_token
    token_source.call
  end

  def token_source
    @token_source ||= Token.public_method(:new)
  end
end
