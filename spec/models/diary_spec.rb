require 'rails_helper'

RSpec.describe Diary, type: :model do
  describe 'バリデーション' do
    it '正常' do
      user = create(:user)
      diary = build(:diary, user_id: user.id)
      expect(diary).to be_valid
    end

    it '内容が140文字超過は無効' do
      user = create(:user)
      diary = build(:diary, user_id: user.id,
        content: '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890A')
      expect(diary).not_to be_valid
    end
  end
end
