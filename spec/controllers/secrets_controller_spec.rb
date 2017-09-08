require 'rails_helper'

RSpec.describe SecretsController, type: :controller do
  before do
    @secret = FactoryGirl.build(:secret)
    @token = FactoryGirl.build(:token)
    TokenCreation.stubs(:perform).returns(@token)
  end

  describe "GET #show" do
    it "returns http success" do
      SecretRetrieval.expects(:perform).returns(@secret)

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
      @secret.token = @token
    end

    it "returns http success" do
      post :create, { params: { secret: { text: 'test' } } }
      expect(response).to have_http_status(:success)
    end
  end
end
