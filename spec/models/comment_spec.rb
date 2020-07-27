require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'バリデーション' do
    it '正常' do
      user1 = create(:user)
      user2 = create(:user)
      diary = create(:diary, user_id: user1.id)
      comment = build(:comment, user_id: user2.id, diary_id: diary.id)
      expect(comment).to be_valid
    end

    it '内容が140文字超過は無効' do
      user1 = create(:user)
      user2 = create(:user)
      diary = create(:diary, user_id: user1.id)
      comment = build(:comment, user_id: user2.id, diary_id: diary.id,
        content: '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890A')
      expect(comment).not_to be_valid
    end
  end
end
