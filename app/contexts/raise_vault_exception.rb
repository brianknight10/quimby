class RaiseVaultException < Faraday::Response::Middleware
  def on_complete(env)
    case env[:status]
    when 500
      raise VaultError, error_message(env, "Something is technically wrong.")
    when 400
      raise VaultError, error_message(env, "Error retrieving the token.")
    end
  end

private

  def error_message(response, body=nil)
    "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{[response[:status].to_s + ':', body].compact.join(' ')}"
  end
end
