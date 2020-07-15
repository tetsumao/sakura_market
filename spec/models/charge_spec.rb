require 'rails_helper'

RSpec.describe Charge, type: :model do
  describe 'バリデーション' do
    it '手数料が0未満は無効' do
      charge = build(:charge, charge: -1)
      expect(charge).not_to be_valid
    end
  end
end
