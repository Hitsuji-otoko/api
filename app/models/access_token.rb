class AccessToken < ApplicationRecord
  belongs_to :user
  after_initialize :generate_token

  private

  def generate_token
    # 無限ループ
    loop do
      # アクセストークンがリロードすると異なるバグはここのexistsの部分
      break if token.present? && !AccessToken.where.not(id: id).exists?(token: token)
      self.token = SecureRandom.hex(10)
    end
  end
end
