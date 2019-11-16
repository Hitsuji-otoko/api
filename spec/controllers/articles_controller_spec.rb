require 'rails_helper'

describe ArticlesController do
    describe '#index' do
        subject { get :index }
        
        it 'should return success response' do
            subject
            expect(response).to have_http_status(:ok)
        end

        it 'should return proper json' do
            articles = create_list :article, 2
            subject
            # 特定の形式のJSONが返された時にパスする
            articles.each_with_index do |article, index|
                expect(json_data[index]['attributes']).to eq({
                    "title" => article.title,
                    "content" => article.content,
                    "slug" => article.slug
                })
            # pp json_data
            end
        end
    end
end