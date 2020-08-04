 require 'rails_helper'

RSpec.describe "/items", type: :request do
  # 管理者ログイン
  before do
    post admin_session_url,
      params: {
        admin_login_form: {
          login_name: admin.login_name,
          password: 'password'
        }
      }
  end
  let(:admin) { create(:admin) }

  let(:valid_attributes) { attributes_for(:item) }
  let(:invalid_attributes) { attributes_for(:item, price: nil) }

  describe "GET /index" do
    it '成功した応答をレンダリング' do
      Item.create! valid_attributes
      get admin_items_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it '成功した応答をレンダリング' do
      item = Item.create! valid_attributes
      get admin_item_url(item)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it '成功した応答をレンダリング' do
      get new_admin_item_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it '成功した応答' do
      item = Item.create! valid_attributes
      get edit_admin_item_url(item)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context '正常パラメータを入力' do
      it '新しい商品を作成' do
        expect {
          post admin_items_url, params: { item: valid_attributes }
        }.to change(Item, :count).by(1)
      end

      it '新しい商品作成後のリダイレクト' do
        post admin_items_url, params: { item: valid_attributes }
        expect(response).to redirect_to(admin_items_url)
      end
    end

    context '不正パラメータを入力' do
      it '新しい商品を作成できない' do
        expect {
          post admin_items_url, params: { item: invalid_attributes }
        }.to change(Item, :count).by(0)
      end

      it '成功した応答をnewテンプレートからレンダリング' do
        post admin_items_url, params: { item: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context '正常パラメータを入力' do
      let(:new_attributes) {
        {price: 9999999}
      }

      it '要求された商品を更新' do
        item = Item.create! valid_attributes
        patch admin_item_url(item), params: { item: new_attributes }
        item.reload
        expect(item.price).to eq(9999999)
      end

      it '商品更新後のリダイレクト' do
        item = Item.create! valid_attributes
        patch admin_item_url(item), params: { item: new_attributes }
        item.reload
        expect(response).to redirect_to(admin_items_url)
      end
    end

    context '不正パラメータを入力' do
      it 'editテンプレートでレンダリングして成功応答' do
        item = Item.create! valid_attributes
        patch admin_item_url(item), params: { item: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it '要求された商品を削除' do
      item = Item.create! valid_attributes
      expect {
        delete admin_item_url(item)
      }.to change(Item, :count).by(-1)
    end

    it '商品削除後のリダイレクト' do
      item = Item.create! valid_attributes
      delete admin_item_url(item)
      expect(response).to redirect_to(admin_items_url)
    end
  end
end
