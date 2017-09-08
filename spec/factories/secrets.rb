FactoryGirl.define do
  factory :secret do
    text 'secret'
    url nil
    token { SecureRandom.urlsafe_base64 }
  end
end
