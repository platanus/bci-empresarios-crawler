require "spec_helper"

describe VisaInternacionalReducer do

  it "should extract all transactions", reducing: "visa_internacional_transactions" do
    expect(reducer.transactions.count).to eq(8)
  end

  it "should parse the date", reducing: "visa_internacional_transactions" do
    expect(reducer.transactions[0].date).to eq(Date.new(2015,4,8))
  end

  it "should parse the description", reducing: "visa_internacional_transactions" do
    expect(reducer.transactions[0].description).to eq("GH GITHUB.COM OU38 SAN FRANCISCOUS")
  end

  it "should set value when is positive", reducing: "visa_internacional_transactions" do
    expect(reducer.transactions[6].amount).to eq(1191.23)
  end

  it "should set value when is negative", reducing: "visa_internacional_transactions" do
    expect(reducer.transactions[0].amount).to eq(-100)
  end

  it "should set signature", reducing: "visa_internacional_transactions" do
    expect(reducer.transactions[0].signature).to eq(nil)
    expect(reducer.transactions[1].signature).to eq(nil)
    expect(reducer.transactions[2].signature).to eq("24692165093000354351399")
  end

  context "when there are no transactions" do
    it "should return an empty array", reducing: "visa_internacional_empty" do
      expect(reducer.transactions.size).to eq(0)
    end
  end

end
