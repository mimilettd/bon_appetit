require './lib/pantry'
require './lib/recipe'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class PantryTest < Minitest::Test
  def test_it_exists
    pantry = Pantry.new
    assert_instance_of Pantry, pantry
  end

  def test_it_starts_off_with_an_empty_stock
    pantry = Pantry.new
    expected = {}
    assert_equal expected, pantry.stock
  end

  def test_it_can_check_stock
    pantry = Pantry.new
    assert_equal 0, pantry.stock_check("Cheese")
  end

  def test_it_can_restock
    pantry = Pantry.new
    pantry.restock("Cheese", 10)
    assert_equal 10, pantry.stock_check("Cheese")
  end

  def test_it_can_restock_again
    pantry = Pantry.new
    pantry.restock("Cheese", 10)
    pantry.restock("Cheese", 20)
    assert_equal 30, pantry.stock_check("Cheese")
  end

  def test_it_can_convert_units_for_this_recipe
    r = Recipe.new("Spicy Cheese Pizza")
    r.add_ingredient("Cayenne Pepper", 0.025)
    r.add_ingredient("Cheese", 75)
    r.add_ingredient("Flour", 500)
    pantry = Pantry.new

    expected =
    { "Cayenne Pepper" => {quantity: 25, units: "Milli-Units"},
      "Cheese" => {quantity: 75, units: "Universal Units"},
      "Flour" => {quantity: 5, units: "Centi-Units"}
    }
    assert_equal expected, pantry.convert_units(r)
  end

end
