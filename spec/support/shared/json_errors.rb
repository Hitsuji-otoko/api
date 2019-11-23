require 'rails_helper'

shared_examples_for "unauthorized_requests" do
    # エラーの形式を定義(cf. document JSON:API)
    # ハッシュのキーとして文字列が必要なので、配列を返すように修正
    let(:authentication_error) do
      {
        "status"=> "401",
        "source"=> { "pointer" => "/code" },
        "title"=>  "Authentication codeis invalid",
        "detail"=> "You must provide valid code in order to exchange it for token."
      }
    end

    it 'should return 401 status code' do
      subject
      expect(response).to have_http_status(401)
    end

    it 'should return proper error body' do
      subject
      expect(json['errors']).to include(authentication_error)
    end
  end

shared_examples_for 'forbidden_requests' do
    let(:authorization_error) do
      {
        "status"=> "403",
        "source"=> { "pointer" => "/headers/authorization" },
        "title"=>  "Not authorized",
        "detail"=> "You have no right to access this source."
      }
    end

    subject { delete :destroy }

    it 'should return 403 status code' do
      subject
      expect(response).to have_http_status(:forbidden)
    end

    it 'should return proper json body' do
      subject
      expect(json['errors']).to include(authorization_error)
    end
  end