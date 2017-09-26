class RaiseVaultException < Faraday::Response::Middleware
  def on_complete(env)
    case env[:status]
    when 500
      raise VaultError, error_message_500(env, "Something is technically wrong.")
    end
  end

private

  def error_message_500(response, body=nil)
    "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{[response[:status].to_s + ':', body].compact.join(' ')}"
  end
end
