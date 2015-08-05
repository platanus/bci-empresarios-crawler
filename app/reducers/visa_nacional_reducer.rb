require 'date'

class VisaNacionalReducer < Crabfarm::BaseReducer

  has_field :transactions

  def run
    self.transactions = parsed_rows
  end

  private

  def rows
    css('tbody tr')
  end

  def parsed_rows
    return [] if there_are_no_transactions?

    rows.map do |elem|
      new_transaction elem.css('td')
    end
  end

  def new_transaction(tds)
    transaction = Transaction.new

    transaction.date = Date.strptime(tds[2].text.strip, '%d-%m-%Y')
    transaction.description = tds[3]
    transaction.amount = signed_amount(tds[4])
    transaction.signature = signature(tds[0].text)

    transaction
  end

  def signature(raw_text)
    # only accepted value is 2505 00887352697
    values = raw_text.strip.split ' '

    return nil if values.count != 2
    return nil if values[1] == '00000000000'

    return values[1]
  end

  def signed_amount(td)
    (td.at_css('.saldo_mas') ? -1 : 1 ) * (assert(td.text).is_f decimal_mark: ',')
  end

  def there_are_no_transactions?
    rows.css('td')[0].text == "Estimado Cliente, no existen movimientos sin facturar"
  end

end
