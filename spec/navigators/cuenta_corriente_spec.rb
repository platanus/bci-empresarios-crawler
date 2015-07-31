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

  before do
    navigate "login", {
      rut: '11111111-1',
      password: "password"
    }
  end

  it "should feed the reducer with the movement table element", navigating: 'bci_empresarios' do
    navigate
    expect(reducer_cuenta_corriente.target.id).to eq('tmovimientos')
  end

  it "return the parsed transactions", navigating: 'bci_empresarios' do
    results = state.document
    expect(results[:transactions].count).to eq(2)
  end

end
