require 'spec_helper'

describe CuentaCorriente do

  let!(:transactions_mock) do
    [
      Transaction.new( amount: 2000, description: 'description', date: Date.today, signature: '1234' ),
      Transaction.new( amount: 4000, description: 'description', date: Date.today )
    ]
  end

  let!(:reducer_cuenta_corriente) do
    spy_reducer(CuentaCorrienteReducer).mock_with transactions: transactions_mock
  end

  let!(:login) {
    navigate "login", {
      rut: ENV['RUT_TEST'],
      password: ENV['PASSWORD_TEST']
    }
  }

  it "should feed the reducer with the movement table element", navigating: 'bci_empresarios_2' do
    navigate
    expect(reducer_cuenta_corriente.target.tbody.id).to eq('frmMovimientos:tblMiniCartola_data')
  end

  it "return the parsed transactions", navigating: 'bci_empresarios_2' do
    results = navigate
    expect(results.document.transactions.count).to eq(2)
  end

end
