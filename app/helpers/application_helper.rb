module ApplicationHelper

  def month_payments_graph(product)
    (4.weeks.ago.to_date..Date.today).map do |date|
      if product.sales(date) == nil
        price = 0
      else
        price = product.sales(date)/100.00
      end
      {
        date: date,
        price: price
      }
    end
  end

  def week_payments_graph(product)
    (2.weeks.ago.to_date..Date.today).map do |date|
      if product.sales(date) == nil
        price = 0
      else
        price = product.sales(date)/100.00
      end
      {
        date: date,
        price: price
      }
    end
  end

  def today_payments_graph

  end


end
