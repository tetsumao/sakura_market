require 'rails_helper'

RSpec.describe "Goods", type: :request do
  # ユーザログイン
  before do
    post user_session_url,
      params: {
        user: {
          email: user2.email,
          password: 'password',
          remember_me: '0'
        }
      }
  end
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:diary) { create(:diary, user_id: user1.id) }

  describe "POST /create" do
    context '正常パラメータを入力' do
      it '新しいGood!を作成' do
        expect {
          post diary_goods_url(diary), xhr: true
        }.to change(Good, :count).by(1)
      end
    end
  end

  describe "DELETE /destroy" do
    it '要求されたGood!を削除する' do
      good = user2.goods.create!(diary_id: diary.id)
      expect {
        delete diary_good_url(diary, good), xhr: true
      }.to change(Good, :count).by(-1)
    end
  end
end
