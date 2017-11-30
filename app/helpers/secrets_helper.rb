module SecretsHelper
  def ttls
    Secret.ttls.map { |t| [ format_ttl(t), t ] }
  end

  def format_ttl(seconds)
    if seconds > 3600
      "#{seconds / 60 / 60} hours"
    elsif seconds < 3600
      "#{seconds / 60} minutes"
    else
        "1 hour"
    end
  end
end
