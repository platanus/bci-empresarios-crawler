require "spec_helper"

describe VisaNacional do

  let!(:transactions_mock) do
    [
      Transaction.new( amount: 2000, description: "description", date: Date.today, signature: "1234" ),
      Transaction.new( amount: 4000, description: "description", date: Date.today )
    ]
  end

  let!(:reducer_visa_nacional) do
    spy_reducer(VisaNacionalReducer).mock_with transactions: transactions_mock
  end

  before do
    navigate "login", {
      rut: '11111111-1',
      password: "password"
    }
  end

  it "should feed the reducer with the movement table element", navigating: "bci_empresarios" do
    navigate
    expect(reducer_visa_nacional.target.tbody.id).to eq("formMovimientos:tbl2_data")
  end

  it "return the parsed transactions", navigating: "bci_empresarios" do
    results = state.document
    expect(results[:transactions].count).to eq(2)
  end

end
