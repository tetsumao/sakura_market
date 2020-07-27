require 'rails_helper'

RSpec.describe Good, type: :model do
  describe 'バリデーション' do
    it '正常' do
      user1 = create(:user)
      user2 = create(:user)
      diary = create(:diary, user_id: user1.id)
      good = Good.new(user_id: user2.id, diary_id: diary.id)
      expect(good).to be_valid
    end
  end
end
