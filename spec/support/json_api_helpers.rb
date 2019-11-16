module JsonApiHelpers
    def json
        # 変数ではなくメソッド呼び出し
        JSON.parse(response.body)
    end

    def json_data
        json["data"]
    end
end