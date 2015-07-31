require "spec_helper"

describe VisaInternacional do

  let!(:transactions_mock) do
    [
      Transaction.new( amount: 2000, description: "description", date: Date.today, signature: nil ),
      Transaction.new( amount: 4000, description: "description", date: Date.today, signature: "1234" ),
      Transaction.new( amount: 6000, description: "description", date: Date.today ),
    ]
  end

  let!(:reducer_visa_internacional) do
    spy_reducer(VisaInternacionalReducer).mock_with transactions: transactions_mock
  end

  before do
    navigate "login", {
      rut: '11111111-1',
      password: "password"
    }
  end

  it "should feed the reducer with the movement table element", navigating: "bci_empresarios" do
    navigate

    selected_card = browser.iframe(:id => 'iframeContenido')
                           .select(:id => 'formMovimientos:select_mostrar')

    expect(selected_card.value).to eq('EXT')
    expect(reducer_visa_internacional.target.tbody.id).to eq("formMovimientos:tbl2_data")
  end

  it "return and filter valid parsed transactions", navigating: "bci_empresarios" do
    results = state.document
    expect(results[:transactions].count).to eq(1)
  end

end
