class SecretCreation
  include DCI::Context

  attr_writer :secret_source

  def perform(text, ttl)
    secret = new_secret(text, ttl)

    secret.as(Wrappable) { secret.wrap }
    secret
  end

private

  def new_secret(text, ttl)
    secret_source.call.tap do |s|
      s.text = text
      s.ttl = ttl
    end
  end

  def secret_source
    @secret_source ||= Secret.public_method(:new)
  end
end
