require 'rails_helper'

describe Token do
  before { @token = FactoryGirl.build(:token) }

  subject { @token }

  it { should respond_to(:client_token) }
  it { should respond_to(:lease_duration) }
  it { should respond_to(:renewable) }
end
