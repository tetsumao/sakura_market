require 'rails_helper'

RSpec.describe Trader, type: :model do
  describe 'バリデーション' do
    it 'メールアドレスのフォーマット異常は無効' do
      trader = build(:trader, email: 'aaa.example.com')
      expect(trader).not_to be_valid
    end

    it '業者名は英数字ひらがなカタカナ漢字が使える' do
      trader = build(:trader, trader_name: 'ＡＢCDひらカナ漢字01２３')
      expect(trader).to be_valid
    end

    it '業者名に記号が含まれる場合は無効' do
      trader = build(:trader, trader_name: '業者.名')
      expect(trader).not_to be_valid
    end
  end

  describe '#password=' do
    it '文字列を与えると、password_digestは長さ60の文字列になる' do
      trader = build(:trader)
      trader.password = 'test_pass'
      expect(trader.password_digest).to be_kind_of(String)
      expect(trader.password_digest.size).to eq(60)
    end

    it 'nilを与えると、password_digestはnilになる' do
      trader = build(:trader, password_digest: 'xxx')
      trader.password = nil
      expect(trader.password_digest).to be_nil
    end
  end
end
