require 'rails_helper'

RSpec.describe "Comments", type: :request do
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
  let(:valid_attributes) {
    {
      diary_id: diary.id,
      content: '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890'
    }
  }
  let(:invalid_attributes) {
    {
      diary_id: diary.id,
      content: '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890A'
    }
  }

  describe "POST /create" do
    context '正常パラメータを入力' do
      it '新しいコメントを作成' do
        expect {
          post comments_url, params: { comment: valid_attributes }, xhr: true
        }.to change(Comment, :count).by(1)
      end
    end

    context '不正パラメータを入力' do
      it '新しいコメントを作成できない' do
        expect {
          post comments_url, params: { comment: invalid_attributes }, xhr: true
        }.to change(Comment, :count).by(0)
      end
    end
  end
end
