require 'spec_helper'

describe Transaction do

  describe "calculate a correct amount" do

    it "when giving a 0 negative value" do
      transaction = Transaction.new

      transaction.signed_amount(0, 1000)

      expect(transaction.amount).to eq(1000)
    end
  end
end
