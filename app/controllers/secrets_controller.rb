class SecretsController < ApplicationController
  def show
    begin
      @secret = SecretRetrieval.perform(params[:id])
    rescue StandardError
    end
  end

  def new
    @secret = Secret.new
  end

  def create
    @secret = SecretCreation.perform(secret_params['text'])
    @secret.url = secret_url(@secret.token)
    @secret
  end

private

  def secret_params
    params.require(:secret).permit(:text)
  end
end
