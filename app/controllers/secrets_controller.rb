class SecretsController < ApplicationController
  def show
    token = Token.new(client_token: params[:id])
    begin
      @secret = SecretRetrieval.perform(token)
    rescue RetrievalError
    end
  end

  def new
    @secret = Secret.new
  end

  def create
    token = TokenCreation.perform
    @secret = SecretCreation.perform(secret_params['text'], token)
    @secret.url = secret_url(@secret.token.client_token)
    @secret
  end

private

  def secret_params
    params.require(:secret).permit(:text)
  end
end
