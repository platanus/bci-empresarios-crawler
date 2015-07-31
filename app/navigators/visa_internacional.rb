class VisaInternacional < Crabfarm::BaseNavigator
  include NavigatorHelper

  def run
    click_on_option_menu [
      'Tarjetas de Crédito',
      'Últimos Movimientos'
    ]

    choose_visa_card('EXT')

    visa_internacional_reducer = reduce_with_defaults(transactions_table)

    {
      transactions: filter_unsigned_transactions(visa_internacional_reducer.transactions)
    }
  end

  private

  def choose_correct_card
    sleep(0.5)
    iframe_contenido.select_list(:id => 'formMovimientos:select_mostrar').select_value('NAC')
  end

  def transactions_table
    wait_until_present iframe_contenido.div(:id => 'formMovimientos:tbl2').table
  end

  def filter_unsigned_transactions(transactions)
    transactions.select &:is_signed?
  end

end
