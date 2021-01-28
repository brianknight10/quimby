require 'rails_helper'

describe Secret do
  before do
    @secret = Secret.new(text: 'secret',
                url: nil,
                token: SecureRandom.urlsafe_base64)

    @host = 'https://vault.test.com'
    @token = 'ratsafraz'
    ENV['VAULT_ADDR'] = @host
    ENV['VAULT_TOKEN'] = @token
  end

  after do
    WebMock.reset!
  end

  subject { @secret }

  it { should respond_to(:token) }
  it { should respond_to(:url) }
  it { should respond_to(:text) }
  it { should respond_to(:ttl) }

  context 'when communicating with Vault' do
    describe 'and wrapping a secret' do
      before do
        secret_body = "{ \"secret\": \"#{Base64.strict_encode64(@secret.text)}\" }"

        @stub = stub_request(:post, "#{@host}/v1/sys/wrapping/wrap")
          .with(body: secret_body,
                headers: {
                  'Accept' => '*/*',
                  'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                  'Content-Type' => 'application/json',
                  'X-Vault-Token' => @token,
                  'X-Vault-Wrap-Ttl' => '3600',
                  'User-Agent' => 'Faraday v1.3.0',
                } )
          .to_return(status: 200, 
                     body: wrap_response, 
                     headers: { 'Content-Type' => 'application/json' })
      end

      it 'creates a valid post to Vault' do
        @secret.as(Wrappable) { @secret.wrap }

        expect(@stub).to have_been_requested
      end

      it 'sets the token' do
        @secret.as(Wrappable) { @secret.wrap }

        expect(@secret.token).to be_eql('test')
      end
    end

    describe 'and unwrapping a secret' do
      before do
        token_body = "{ \"token\": \"#{@secret.token}\" }"

        @stub = stub_request(:post, "#{@host}/v1/sys/wrapping/unwrap")
          .with(body: token_body,
                headers: {
                  'Accept' => '*/*',
                  'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                  'Content-Type' => 'application/json',
                  'X-Vault-Token' => @token,
                  'User-Agent' => 'Faraday v1.3.0',
                } )
          .to_return(status: 200, 
                     body: unwrap_response, 
                     headers: { 'Content-Type' => 'application/json' })
      end

      it 'creates a valid post to Vault' do
        @secret.as(Wrappable) { @secret.unwrap }

        expect(@stub).to have_been_requested
      end

      it 'sets the secret text' do
        @secret.as(Wrappable) { @secret.unwrap }

        expect(@secret.text).to be_eql('test')
      end
    end
  end
end

def unwrap_response
  { 'data' => { 'secret' => 'dGVzdA==' } }.to_json
end

def wrap_response
  { 'wrap_info' => { 'token' => 'test' } }.to_json
end
