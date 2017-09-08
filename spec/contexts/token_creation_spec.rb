require 'rails_helper'

describe TokenCreation do
  let(:context) { TokenCreation.new }
  subject { :context }

  describe '#perform' do
    context 'when the method is called with defaults' do
      before do
        @token = Token.new
        context.token_source = -> { @token }
      end
    end
  end
end
