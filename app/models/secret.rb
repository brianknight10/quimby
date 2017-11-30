class Secret
  include ActiveModel::Model
  include DCI::Data

  attr_accessor :text
  attr_accessor :token
  attr_accessor :url
  attr_accessor :ttl

  TTL_DEFAULT = 3600
  TTL = [300, 600, 1800, 3600, 21600, 43200, 86400, 172800]

  def initialize(params = {})
    params.each do |attr, value|
      public_send("#{attr}=", value)
    end if params

    self.ttl = TTL_DEFAULT
  end

  def self.ttls
    TTL
  end
end
