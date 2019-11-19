class AccessTokensController < ApplicationController

  def create
    # 認証の際、不適切なデータ形式でトークン送った場合にエラーを返す
    authenticator = UserAuthenticator.new(params[:code])
    authenticator.perform
  end
  
end
