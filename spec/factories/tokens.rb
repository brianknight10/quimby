FactoryGirl.define do
  factory :token do
    client_token { SecureRandom.urlsafe_base64 }
    lease_duration 3600
    renewable false
  end
end
