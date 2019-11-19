require 'rails_helper'

RSpec.describe AccessTokensController, type: :controller do
  describe '#create' do
    context 'when invalid request' do
      # エラーの形式を定義(cf. document JSON:API)
      # ハッシュのキーとして文字列が必要なので、配列を返すように修正
      let(:error) do
        {
          "status"=> "401",
          "source"=> { "pointer" => "/code" },
          "title"=>  "Authentication codeis invalid",
          "detail"=> "You must provide valid code in order to exchange it for token."
        }
      end
      
      it 'should return 401 status code' do
        post :create
        expect(response).to have_http_status(401)
      end

      it 'should return proper error body' do
        post :create
        expect(json['errors']).to include(error)
      end
    end
    

    context 'when success request' do

    end

  end

end
