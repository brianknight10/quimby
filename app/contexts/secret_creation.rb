class SecretCreation
  include DCI::Context

  attr_writer :secret_source

  def perform(text, token)
    secret = new_secret(text, token)

    secret.as(Storable) { secret.write }
    secret
  end

private

  def new_secret(text, token)
    secret_source.call.tap do |s|
      s.text = text
      s.token = token
    end
  end

  def secret_source
    @secret_source ||= Secret.public_method(:new)
  end
end
