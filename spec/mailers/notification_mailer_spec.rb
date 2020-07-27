require "rails_helper"

RSpec.describe NotificationMailer, type: :mailer do
  describe 'メール送信' do
    it 'コメントメール' do
      user1 = create(:user)
      user2 = create(:user)
      diary = create(:diary, user_id: user1.id)
      comment = create(:comment, user_id: user2.id, diary_id: diary.id)
      mail = described_class.send_comment(comment)
      expect(mail.subject).to eq('コメントが登録されました')
      expect(mail.to).to eq([user1.email])
    end
    it 'Good!メール' do
      user1 = create(:user)
      user2 = create(:user)
      diary = create(:diary, user_id: user1.id)
      good = Good.create(user_id: user2.id, diary_id: diary.id)
      mail = described_class.send_good(good)
      expect(mail.subject).to eq('Good!が付きました')
      expect(mail.to).to eq([user1.email])
    end
  end
end
