require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'バリデーション' do
    it '価格が0未満は無効' do
      item = build(:item, price: -1)
      expect(item).not_to be_valid
    end
  end
end
