class UserAuthenticator
    class AuthenticationError < StandardError; end
    
    attr_reader :user

    def initialize(code)
        @code = code
    end

    def perform
    # performメソッドがユーザからどのように見えるか
        client = Octokit::client.new(
            client_id: ENV['GITHUB_CLIENT_ID'],
            client_password: ENV['GITHUB_CLIENT_SECRET']
        )
        res = client.exchange_code_for_token(code)
        if res.error.present?
            raise AuthenticationError
        else
        end
    end

    private

    attr_reader :code
end