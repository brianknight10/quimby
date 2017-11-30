require 'rails_helper'

describe SecretCreation do
  let(:context) { SecretCreation.new }
  subject { :context }

  describe '#perform' do
    before do
      @secret = Secret.new
      @secret.expects(:wrap)
      context.secret_source = proc { @secret }
    end

    it 'sets the token' do
      secret = 'test token'
      ttl = 3600
      result = context.perform(secret, ttl)
      expect(result.text).to eq(secret)
    end

    it 'sets the ttl' do
      secret = 'test token'
      ttl = 21600
      result = context.perform(secret, ttl)
      expect(result.ttl).to eq(ttl)
    end
  end
end
