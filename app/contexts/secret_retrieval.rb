class SecretRetrieval
  include DCI::Context

  attr_writer :secret_source

  def perform(token)
    secret = new_secret(token)

    secret.as(Wrappable) { secret.unwrap }
    secret
  end

private

  def new_secret(token)
    secret_source.call.tap do |s|
      s.token = token
    end
  end

  def secret_source
    @secret_source ||= Secret.public_method(:new)
  end
end
