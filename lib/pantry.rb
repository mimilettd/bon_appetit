class Pantry
  attr_reader :stock
  def initialize
    @stock = {}
  end

  def stock_check(item)
    unless stock[item] == nil
      return stock[item]
    else
      return 0
    end
  end

  def restock(item, quantity)
    if stock.include?(item)
      stock[item] = stock[item] + quantity
    else
      stock.merge!(item => quantity)
    end
  end
end
