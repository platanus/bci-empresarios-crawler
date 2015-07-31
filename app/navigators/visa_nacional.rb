class VisaNacional < Crabfarm::BaseNavigator
  include NavigatorHelper

  def run
    click_on_option_menu [
      'Tarjetas de Crédito',
      'Últimos Movimientos'
    ]

    choose_visa_card('NAC')

    reduce_with_defaults(transactions_table)
  end

  private

  def transactions_table
    wait_until_present iframe_contenido.div(:id => 'formMovimientos:tbl2').table
  end

end
