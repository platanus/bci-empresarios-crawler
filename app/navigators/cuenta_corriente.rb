class CuentaCorriente < Crabfarm::BaseNavigator
  include NavigatorHelper

  def run
    click_on_option_menu [
      'Cuentas Corrientes en Pesos',
      'Cartola',
      'Cartola Actual'
    ]

    reduce_with_defaults(transactions_table)
  end

  private

  def transactions_table
    wait_until_present iframe_contenido.div(:id => 'frmMovimientos:tblMiniCartola').table
  end

end
