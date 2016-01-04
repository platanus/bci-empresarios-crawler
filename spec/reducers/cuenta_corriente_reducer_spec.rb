require 'spec_helper'

describe CuentaCorrienteReducer do

  it "should extract all transactions", reducing: 'cuenta_corriente_transactions' do
    expect(reducer.transactions.count).to eq(15)
  end

  it "should parse the date", reducing: 'cuenta_corriente_transactions' do
    expect(reducer.transactions[0].date).to eq(Date.new(2015,12,21))
  end

  it "should parse the description", reducing: 'cuenta_corriente_transactions' do
    expect(reducer.transactions[0].description).to eq('TRASPASO FONDOS OTRO BANCO EN LINEA')
  end

  it "should set value when is positive", reducing: 'cuenta_corriente_transactions' do
    expect(reducer.transactions[4].amount).to eq(1515185)
  end

  it "should set value when is negative", reducing: 'cuenta_corriente_transactions' do
    expect(reducer.transactions[0].amount).to eq(-99740)
  end

  it "should set signature as null", reducing: 'cuenta_corriente_transactions' do
    expect(reducer.transactions[0].signature).to eq(nil)
  end

end
