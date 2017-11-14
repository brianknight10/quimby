require 'rails_helper'

RSpec.describe SecretsController, type: :controller do
  before do
    @secret = Secret.new(text: 'secret',
                url: nil,
                token: SecureRandom.urlsafe_base64)
  end

  describe "GET #show" do
    it "returns http success" do
      SecretRetrieval.expects(:perform).returns(@secret)

      get :show, { params: { id: 'test-token' } }
      expect(response).to have_http_status(:success)
    end

    it "does not raise errors" do
      SecretRetrieval.expects(:perform).raises(VaultError)

      get :show, { params: { id: 'test-token' } }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    before do
      SecretCreation.expects(:perform).returns(@secret)
    end

    it "returns http success" do
      post :create, { params: { secret: { text: 'test' } } }
      expect(response).to have_http_status(:success)
    end

    it "returns a valid URL" do
      post :create, { params: { secret: { text: 'test' } } }
      expect(@secret.url).to eq("http://test.host/secrets/#{@secret.token}")
    end
  end
end
