require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  before(:each) do

    @chef_1 = Chef.create!(name: "Mr. Guy")

    @dish_1 = Dish.create!(chef: @chef_1, name: "Milk Toast", description: "Literally just milk on toast with sugar")
    @dish_2 = Dish.create!(chef: @chef_1, name: "Egg Sammy", description: "Literally just a fried egg on bread")


     @ing_1 = Ingredient.create!(name: "Egg", calories: 350)
     @ing_2 = Ingredient.create!(name: "Toast", calories: 150)
     @ing_3 = Ingredient.create!(name: "Sugar", calories: 150)

    DishIngredient.create!(ingredient: @ing_1, dish: @dish_1)
    DishIngredient.create!(ingredient: @ing_2, dish: @dish_1)
    DishIngredient.create!(ingredient: @ing_3, dish: @dish_1)
  end

  describe 'When I visit a dish\'s show page' do
    it 'I see a list of ingredients for that dish and the chef\'s name' do
      visit dish_path(@dish_1.id)

      visit dish_path(@dish_1.id)
      expect(page).to have_content(@ing_1.calories)
      expect(page).to have_content(@ing_2.name)
      expect(page).to have_content(@ing_2.calories)
      expect(page).to have_content(@ing_3.name)
      expect(page).to have_content(@ing_3.calories)
      expect(page).to have_content(@chef_1.name)
    end

    it 'I can see the total calorie count for that dish' do
      visit dish_path(@dish_1.id)

      expect(page).to have_content(@dish_1.total_calories)
    end
  end
end
