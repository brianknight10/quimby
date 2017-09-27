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
      result = context.perform(secret)
      expect(result.text).to eq(secret)
    end
  end
end
