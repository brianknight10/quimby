require 'rails_helper'

describe Secret do
  before do
    @secret = Secret.new(text: 'secret',
                url: nil,
                token: SecureRandom.urlsafe_base64)
  end

  subject { @secret }

  it { should respond_to(:token) }
  it { should respond_to(:url) }
  it { should respond_to(:text) }
  it { should respond_to(:ttl) }

  context 'when communicating with Vault' do
    describe 'and wrapping a secret' do
      it 'creates a valid post to Vault' do
        request = mock('request')
        headers = mock('headers')
        secret = "{ \"secret\": \"#{Base64.strict_encode64(@secret.text)}\" }"

        request.expects(:url).with('/v1/sys/wrapping/wrap')
        request.expects(:headers).returns(headers).times(3)
        request.expects(:body=).returns(secret)

        headers.expects(:[]=).with('Content-Type', 'application/json')
        headers.expects(:[]=).with('X-Vault-Token', nil)
        headers.expects(:[]=).with('X-Vault-Wrap-TTL', '3600')

        Faraday::Connection.any_instance
          .expects(:post)
          .yields(request)
          .returns(wrap_response)

        @secret.as(Wrappable) { @secret.wrap }
      end

      it 'sets the token' do
        Faraday::Connection.any_instance.stubs(:post).returns(wrap_response)

        @secret.as(Wrappable) { @secret.wrap }

        expect(@secret.token).to be_eql('test')
      end
    end

    describe 'and unwrapping a secret' do
      it 'creates a valid post to Vault' do
        request = mock('request')
        headers = mock('headers')
        body = "{ \"token\": \"#{@secret.token}\" }"

        request.expects(:url).with('/v1/sys/wrapping/unwrap')
        request.expects(:headers).returns(headers).times(2)
        request.expects(:body=).returns(body)

        headers.expects(:[]=).with('Content-Type', 'application/json')
        headers.expects(:[]=).with('X-Vault-Token', nil)

        Faraday::Connection.any_instance
          .expects(:post)
          .yields(request)
          .returns(unwrap_response)

        @secret.as(Wrappable) { @secret.unwrap }
      end

      it 'sets the secret text' do
        Faraday::Connection.any_instance.stubs(:post).returns(unwrap_response)

        @secret.as(Wrappable) { @secret.unwrap }

        expect(@secret.text).to be_eql('test')
      end
    end
  end
end

def unwrap_response
  OpenStruct.new({ body: { 'data' => { 'secret' => 'dGVzdA==' } } })
end

def wrap_response
  OpenStruct.new({ body: { 'wrap_info' => { 'token' => 'test' } } })
end
