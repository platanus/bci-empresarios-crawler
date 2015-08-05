class VisaNacional < Crabfarm::BaseNavigator
  include NavigatorHelper

  def run
    click_on_option_menu [
      'Tarjetas de Crédito',
      'Últimos Movimientos'
    ]

    choose_visa_card('NAC')

    reducer = reduce_with_defaults(transactions_table)

    {
      transactions: filter_unsigned_transactions(reducer.transactions)
    }
  end

  private

  def transactions_table
    wait_until_present iframe_contenido.div(:id => 'formMovimientos:tbl2').table
  end

  def filter_unsigned_transactions(transactions)
    transactions.select &:is_signed?
  end

end
