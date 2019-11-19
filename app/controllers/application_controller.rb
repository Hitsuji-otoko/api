class ApplicationController < ActionController::API
    # 処理するエラークラスを第一引数として渡す
    rescue_from UserAuthenticator::AuthenticationError, with: :authencation_error

    private

    def authencation_error
      error = {
        "status"=> "401",
        "source"=> { "pointer" => "/code" },
        "title"=>  "Authentication codeis invalid",
        "detail"=> "You must provide valid code in order to exchange it for token."
      }
      render json: { "errors": [error] }, status: 401
    end
end
