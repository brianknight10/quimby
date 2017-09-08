class Secret
  include ActiveModel::Model
  include DCI::Data

  attr_accessor :text
  attr_accessor :token
  attr_accessor :url

  def initialize(params = {})
    params.each do |attr, value|
      public_send("#{attr}=", value)
    end if params
  end
end
