require 'rails_helper'

RSpec.describe "Diaries", type: :request do
  # ユーザログイン
  before do
    post user_session_url,
      params: {
        user: {
          email: user.email,
          password: 'password',
          remember_me: '0'
        }
      }
  end
  let(:user) { create(:user) }
  let(:valid_attributes) {
    {
      content: '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890'
    }
  }
  let(:invalid_attributes) {
    {
      content: '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890A'
    }
  }

  describe "GET /index" do
    it '成功した応答をレンダリング' do
      user.diaries.create! valid_attributes
      get root_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it '成功した応答をレンダリング' do
      diary = user.diaries.create! valid_attributes
      get diary_url(diary)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context '正常パラメータを入力' do
      it '新しい日記を作成' do
        expect {
          post diaries_url, params: { diary: valid_attributes }
        }.to change(Diary, :count).by(1)
      end

      it '日記作成成功後のリダイレクト' do
        post diaries_url, params: { diary: valid_attributes }
        expect(response).to redirect_to(root_url)
      end
    end

    context '不正パラメータを入力' do
      it '新しい日記を作成できない' do
        expect {
          post diaries_url, params: { diary: invalid_attributes }
        }.to change(Diary, :count).by(0)
      end

      it '日記作成失敗後のリダイレクト' do
        post diaries_url, params: { diary: invalid_attributes }
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
