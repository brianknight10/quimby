class SecretCreation
  include DCI::Context

  attr_writer :secret_source

  def perform(text)
    secret = new_secret(text)

    secret.as(Wrappable) { secret.wrap }
    secret
  end

private

  def new_secret(text)
    secret_source.call.tap do |s|
      s.text = text
    end
  end

  def secret_source
    @secret_source ||= Secret.public_method(:new)
  end
end
