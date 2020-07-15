require 'rails_helper'

RSpec.describe DeliveryPeriod, type: :model do
  describe 'バリデーション' do
    it '開始時・終了時が8未満は無効' do
      delivery_period = build(:delivery_period, hour_from: 7)
      expect(delivery_period).not_to be_valid
    end

    it '開始時・終了時が21超過は無効' do
      delivery_period = build(:delivery_period, hour_to: 22)
      expect(delivery_period).not_to be_valid
    end
  end
end
