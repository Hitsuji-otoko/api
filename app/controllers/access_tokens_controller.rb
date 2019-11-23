class AccessTokensController < ApplicationController
  skip_before_action :authorize!, only: :create

  def create
    # 認証の際、不適切なデータ形式でトークン送った場合にエラーを返す
    authenticator = UserAuthenticator.new(params[:code])
    authenticator.perform

    render json: authenticator.access_token, status: :created
  end
  
  def destroy
    current_user.access_token.destroy
  end
end
