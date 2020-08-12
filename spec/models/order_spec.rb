require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'バリデーション' do
    it '正常' do
      user = create(:user)
      delivery_period = create(:delivery_period)
      order = build(:order, user_id: user.id, delivery_period_id: delivery_period.id)
      expect(order).to be_valid
    end

    it '郵便番号のフォーマットエラーは無効' do
      user = create(:user)
      delivery_period = create(:delivery_period)
      order = build(:order, user_id: user.id, delivery_period_id: delivery_period.id, ship_zip: 'fad-1345')
      expect(order).not_to be_valid
    end

    it '住所なしは無効' do
      user = create(:user)
      delivery_period = create(:delivery_period)
      order = build(:order, user_id: user.id, delivery_period_id: delivery_period.id, ship_address: nil)
      expect(order).not_to be_valid
    end

    it '注文済みの時のみキャンセル可能' do
      user = create(:user)
      delivery_period = create(:delivery_period)
      order = create(:order, user_id: user.id, delivery_period_id: delivery_period.id)
      order.order_status = :canceled
      expect(order).to be_valid
    end

    it '注文済み以外の時のみキャンセル不可' do
      user = create(:user)
      delivery_period = create(:delivery_period)
      order = create(:order, user_id: user.id, delivery_period_id: delivery_period.id, order_status: :processing)
      order.order_status = :canceled
      expect(order).not_to be_valid
    end
  end
end
