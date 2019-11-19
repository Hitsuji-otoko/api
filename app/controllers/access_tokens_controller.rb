class AccessTokensController < ApplicationController
  def create
    # 認証の際、不適切なデータ形式でトークン送った場合にエラーを返す
    authenticator = User.Authenticator.new(params[:code])
    if authenticator.perform
      
    else error = {
        "status"=> "401",
        "source"=> { "pointer" => "/code" },
        "title"=>  "Authentication codeis invalid",
        "detail"=> "You must provide valid code in order to exchange it for token."
      }
      render json: { "errors": [error] }, status: 401
    end
  end
end
