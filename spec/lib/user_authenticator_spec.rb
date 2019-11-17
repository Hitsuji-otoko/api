require 'rails_helper'

describe UserAuthenticator do
    describe '#perform' do
        # 全てのテストからauthenticator変数にアクセスできるようにする
        let(:authenticator) { described_class.new('sample_code') }

        subject { authenticator.perform }

        # context:　一連のテストをグループ化
        context 'when code is incorrect' do
            # 保留: あとでrails c でclientを入れて確認
            let(:error) {
                double("Sawyer::Resource", error: "bad_verification_code")
              }
            # Octokit gemが実際のGitHub APIにリクエストを送信せずに、テストを実行したい
            before do
                allow_any_instance_of(Octokit::Client).to receive(
                    :exchange_code_for_token).and_return(error)
            end
        
            it 'should raise on error' do
                expect{ subject }.to raise_error(
                    UserAuthenticator::AuthenticationError
                )
                expect(authenticator.user).to be_nil
            end
        end

        context 'when code is correct' do
            # Github APIが返すユーザデータの定義
            let(:user_data) do
              {
                login: 'jsmith1',
                url: 'http://example.com',
                avatar_url: 'http://example.com/avatar',
                name: 'John Smith'
              }
            end
      
            before do
              allow_any_instance_of(Octokit::Client).to receive(
                :exchange_code_for_token).and_return('validaccesstoken')
      
              allow_any_instance_of(Octokit::Client).to receive(
                :user).and_return(user_data)
            end
      
            it 'should save the user when does not exists' do
              expect{ subject }.to change{ User.count }.by(1)
              expect(User.last.name).to eq('John Smith')
            end

            it 'should reuse alredy registered user' do
                user = create :user, user_data
                expect{ subject }.not_to change{ User.count }
                expect(authenticator.user).to eq(user)
            end
        end
    end
end