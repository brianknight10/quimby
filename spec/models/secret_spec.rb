require 'rails_helper'

describe Secret do
  before { @secret = FactoryGirl.build(:secret) }

  subject { @secret }

  it { should respond_to(:token) }
  it { should respond_to(:url) }
  it { should respond_to(:text) }
end
