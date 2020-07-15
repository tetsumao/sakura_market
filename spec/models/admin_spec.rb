require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'バリデーション' do
    it '記号を含むログイン名は無効' do
      admin = build(:admin, login_name: 'login.name')
      expect(admin).not_to be_valid
    end

    it '英数字のみのログイン名は有効' do
      admin = build(:admin, login_name: 'login0001')
      expect(admin).to be_valid
    end

    it '他の管理者のログイン名と重複したログイン名は無効' do
      admin1 = create(:admin)
      admin2 = build(:admin, login_name: admin1.login_name)
      expect(admin2).not_to be_valid
    end
  end

  describe '#password=' do
    it '文字列を与えると、password_digestは長さ60の文字列になる' do
      admin = build(:admin)
      admin.password = 'test_pass'
      expect(admin.password_digest).to be_kind_of(String)
      expect(admin.password_digest.size).to eq(60)
    end

    it 'nilを与えると、password_digestはnilになる' do
      admin = build(:admin, password_digest: 'xxx')
      admin.password = nil
      expect(admin.password_digest).to be_nil
    end
  end
end
