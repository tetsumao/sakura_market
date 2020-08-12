require 'rails_helper'

RSpec.describe "Users", type: :request do
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

  describe "GET /show" do
    it '成功した応答をレンダリング' do
      get user_path
      expect(response).to have_http_status(:success)
    end
  end
end
