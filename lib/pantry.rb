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

  def convert_units(recipe)
    converted_units = Hash.new
    recipe.ingredients.each do |key, value|
      if value > 100
        converted_units[key] = Hash.new.merge({quantity: value / 100, units: "Centi-Units"})
      elsif value < 1
        converted_units[key] = Hash.new.merge({quantity: (value * 1000).to_i, units: "Milli-Units"})
      else
        converted_units[key] = Hash.new.merge({quantity: value, units: "Universal Units"})
      end
    end
    converted_units
  end

end
