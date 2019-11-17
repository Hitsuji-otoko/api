require 'rails_helper'

describe UserAuthenticator do
    describe '#perform' do
        # 全てのテストからauthenticator変数にアクセスできるようにする
        let(:authenticator) { described_class.new('sample_code') }

        subject { authenticator.perform }

        # context:　一連のテストをグループ化
        context 'when code id incorrect' do
            it 'should raise on error' do
                expect{ subject }.to raise_error(
                    UserAuthenticator::AuthenticationError
                )
                expect(authenticator.user).to be_nil
            end
        end

        context 'when code id correct' do
            it 'should save the user when does not exists' do
                expect { subject }.to change{ User.count }.by(1)
            end
        end
    end
end