require "spec_helper"

describe VisaNacionalReducer do

  it "should extract all transactions", reducing: "visa_nacional_transactions" do
    expect(reducer.transactions.count).to eq(7)
  end

  it "should parse the date", reducing: "visa_nacional_transactions" do
    expect(reducer.transactions[0].date).to eq(Date.new(2015,6,3))
  end

  it "should parse the description", reducing: "visa_nacional_transactions" do
    expect(reducer.transactions[0].description).to eq("TRASPASO DEUDA INTERNA TRAS.US$ A $")
  end

  it "should set value when is positive", reducing: "visa_nacional_transactions" do
    expect(reducer.transactions[1].amount).to eq(1000000)
  end

  it "should set value when is negative", reducing: "visa_nacional_transactions" do
    expect(reducer.transactions[0].amount).to eq(-932994)
  end

  it "should set signature", reducing: "visa_nacional_transactions" do
    expect(reducer.transactions[3].signature).to eq("00884612084")
  end

  it "should no set signature when is not present", reducing: "visa_nacional_transactions" do
    expect(reducer.transactions[0].signature).to eq(nil)
    expect(reducer.transactions[1].signature).to eq(nil)
  end

  context "when there are no transactions" do
    it "should return an empty array", reducing: "visa_nacional_empty" do
      expect(reducer.transactions.size).to eq(0)
    end
  end

end
