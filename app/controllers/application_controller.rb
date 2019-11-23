class ApplicationController < ActionController::API
  class AuthorizationError < StandardError; end

    # 処理するエラークラスを第一引数として渡す
    rescue_from UserAuthenticator::AuthenticationError, with: :authencation_error
    rescue_from AuthorizationError, with: :authorization_error

    private

    def authorize!
      raise AuthorizationError unless current_user
    end

    def access_token
      # &ナビゲーション演算子: nilの場合nilを返す
      provided_token = request.authorization&.gsub(/\ABearer\s/, '')
      @access_token = AccessToken.find_by(token: provided_token)
    end

    def current_user
      @current_user = access_token&.user
    end

    def authencation_error
      error = {
        "status"=> "401",
        "source"=> { "pointer" => "/code" },
        "title"=>  "Authentication codeis invalid",
        "detail"=> "You must provide valid code in order to exchange it for token."
      }
      render json: { "errors": [error] }, status: 401
    end

    def authorization_error
      error = {
        "status"=> "403",
        "source"=> { "pointer" => "/headers/authorization" },
        "title"=>  "Not authorized",
        "detail"=> "You have no right to access this source."
      }
      
      render json:{ "errors": [error] }, status: 403
    end
end
