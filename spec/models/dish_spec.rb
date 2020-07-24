require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end
  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many :dish_ingredients}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end

  describe "methods" do
    before :each do
      @chef_1 = Chef.create!(name: "Mr. Guy")
      @dish_1 = Dish.create!(chef: @chef_1, name: "Milk Toast", description: "Literally just milk on toast with sugar")

       @ing_1 = Ingredient.create!(name: "Egg", calories: 350)
       @ing_2 = Ingredient.create!(name: "Toast", calories: 150)
       @ing_3 = Ingredient.create!(name: "Sugar", calories: 150)

      DishIngredient.create!(ingredient: @ing_1, dish: @dish_1)
      DishIngredient.create!(ingredient: @ing_2, dish: @dish_1)
      DishIngredient.create!(ingredient: @ing_3, dish: @dish_1)
    end

    it "#total_calories" do
      expect(@dish_1.total_calories).to eq(650)
    end
  end
end
