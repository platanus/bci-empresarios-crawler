require 'spec_helper'

describe Login do

  it "should login correctly", navigating: 'bci_empresarios_2' do
    navigate rut: ENV['RUT_TEST'], password: ENV['PASSWORD_TEST']
    expect(browser.div(:id => 'encabezado').text).to include 'Jaime Bunzli'
  end

end
