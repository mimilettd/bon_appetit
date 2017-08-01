class Pantry
  attr_reader :stock,
              :cookbook,
              :meals
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
    @meals = []
    cookbook.each do |recipe|
      recipe.ingredients.each do |item, quantity|
        if stock.include?(item) && stock[item] > quantity
          meals << recipe.name
        end
      end
    end
    meals.uniq!
  end

  def how_many_can_i_make
    overall_quantity = Hash.new
    cookbook.map do |recipe|
      stock.each do |item|
        item_name = item[0]
        if recipe.ingredients.include?(item_name)
          overall_quantity[item_name] = stock[item_name] / recipe.ingredients[item_name]
        end
      end
    end
    meal(overall_quantity)
  end

  def meal(overall_quantity)
    meal_quantity = Hash.new
    overall_quantity.map do |key, value|
      cookbook.map do |recipe|
        if recipe.ingredients.has_key?(key) && meals.include?(recipe.name)
          meal_quantity[recipe.name] = value
        end
      end
    end
    meal_quantity
  end

end
