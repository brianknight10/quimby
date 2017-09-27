require 'rails_helper'

describe RaiseVaultException do
  let(:context) { RaiseVaultException.new }
  subject { :context }

  describe '#on_complete hook' do
    it 'raises a VaultError on 500' do
      response = response(500)
      expect { context.on_complete(response) }.to raise_error(VaultError)
    end
  end
end

def response(code)
  { url: 'https://test.example.com/test',
    method: 'POST',
    status: code }
end
