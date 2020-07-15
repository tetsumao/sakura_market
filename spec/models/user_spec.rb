require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it 'メールアドレスのフォーマット異常は無効' do
      user = build(:user, email: 'aaa.example.com')
      expect(user).not_to be_valid
    end

    it 'ユーザ名は英数字ひらがなカタカナ漢字が使える' do
      user = build(:user, user_name: 'ＡＢCDひらカナ漢字01２３')
      expect(user).to be_valid
    end

    it 'ユーザ名に記号が含まれる場合は無効' do
      user = build(:user, user_name: 'ユーザ.名')
      expect(user).not_to be_valid
    end
  end
end
