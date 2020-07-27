require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe 'バリデーション' do
    it '正常' do
      admin = create(:admin)
      coupon = build(:coupon, admin_id: admin.id, coupon_code: '1234567890AB')
      expect(coupon).to be_valid
    end
    it 'クーポンコードが英数12桁未満は無効' do
      admin = create(:admin)
      coupon = build(:coupon, admin_id: admin.id, coupon_code: '1234567890A')
      expect(coupon).not_to be_valid
    end
    it 'クーポンコードが英数12桁超過は無効' do
      admin = create(:admin)
      coupon = build(:coupon, admin_id: admin.id, coupon_code: '1234567890ABC')
      expect(coupon).not_to be_valid
    end
    it 'クーポンコードが英数以外は無効' do
      admin = create(:admin)
      coupon = build(:coupon, admin_id: admin.id, coupon_code: '123456789あAB')
      expect(coupon).not_to be_valid
    end
    it 'ポイントが0は無効' do
      admin = create(:admin)
      coupon = build(:coupon, admin_id: admin.id, coupon_code: '1234567890AB', point: 0)
      expect(coupon).not_to be_valid
    end
  end
end
