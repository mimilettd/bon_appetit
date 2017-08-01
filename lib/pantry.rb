class Pantry
  attr_reader :stock,
              :cookbook
  def initialize
    @stock = {}
    @cookbook = []
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

  def add_to_cookbook(recipe)
    cookbook << recipe
  end

  def what_can_i_make
    tonights_dessert = []
    cookbook.each do |recipe|
      recipe.ingredients.each do |item, quantity|
        if stock.include?(item) && stock[item] > quantity
          tonights_dessert << recipe.name
        end
      end
    end
    tonights_dessert.uniq
  end

end
