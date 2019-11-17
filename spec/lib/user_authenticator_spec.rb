require 'rails_helper'

describe UserAuthenticator do
    describe '#perform' do
        # context:　一連のテストをグループ化
        context 'when code id incorrect' do
            it 'should raise on error' do
                authenticator = described_class.new('sample_code')
                expect{ authenticator.perform }.to raise_error(
                    UserAuthenticator::AuthenticationError
                )
                expect(authenticator.user).to be_nil
            end
        end
    end
end