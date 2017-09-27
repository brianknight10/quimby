require 'rails_helper'

describe SecretRetrieval do
  let(:context) { SecretRetrieval.new }
  subject { :context }

  describe '#perform' do
    before do
      @secret = Secret.new
      @secret.expects(:unwrap)
      context.secret_source = proc { @secret }
    end

    it 'sets the token' do
      token = 'test token'
      result = context.perform(token)
      expect(result.token).to eq(token)
    end
  end
end
