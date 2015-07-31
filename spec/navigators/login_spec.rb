require 'spec_helper'

describe Login do

  it "should login correctly", navigating: 'bci_empresarios' do
    navigate rut: '11111111-1', password: "password"
    expect(browser.div(:id => 'encabezado').text).to include 'Jaime Bunzli'
  end

end
