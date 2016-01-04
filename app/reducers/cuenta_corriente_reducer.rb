require 'date'

class CuentaCorrienteReducer < Crabfarm::BaseReducer

  has_field :transactions

  def run
    self.transactions = parsed_rows
  end

  private

  def rows
    css('tbody tr')
  end

  def parsed_rows
    rows.map do |elem|
      new_transaction elem.css('td')
    end
  end

  def new_transaction(tds)
    transaction = Transaction.new

    transaction.date = Date.strptime(tds[0].text.strip, '%d/%m/%Y')
    transaction.description = tds[2]
    transaction.signed_amount(tds[5], tds[7])

    transaction
  end

end
