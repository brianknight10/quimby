class Token
  include ActiveModel::Model
  include DCI::Data

  attr_accessor :client_token
  attr_accessor :lease_duration
  attr_accessor :renewable

  def initialize(params = {})
    params.each do |attr, value|
      public_send("#{attr}=", value)
    end if params
  end
end
