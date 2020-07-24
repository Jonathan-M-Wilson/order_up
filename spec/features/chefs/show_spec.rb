require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  before(:each) do

    @chef_1 = Chef.create!(name: "Mr. Guy")

    @dish_1 = Dish.create!(chef: @chef_1, name: "Milk Toast", description: "Literally just milk on toast with sugar")
    @dish_2 = Dish.create!(chef: @chef_1, name: "Egg Sammy", description: "Literally just a fried egg on bread")


     @ing_1 = Ingredient.create!(name: "Egg", calories: 350)
     @ing_2 = Ingredient.create!(name: "Toast", calories: 150)
     @ing_3 = Ingredient.create!(name: "Sugar", calories: 150)
     @ing_4 = Ingredient.create!(name: "Milk", calories: 250)

    DishIngredient.create!(ingredient: @ing_1, dish: @dish_1)
    DishIngredient.create!(ingredient: @ing_2, dish: @dish_1)
    DishIngredient.create!(ingredient: @ing_3, dish: @dish_1)
    DishIngredient.create!(ingredient: @ing_4, dish: @dish_1)

    DishIngredient.create!(ingredient: @ing_1, dish: @dish_2)
    DishIngredient.create!(ingredient: @ing_2, dish: @dish_2)
  end

  describe 'When I visit a chef\'s show page' do
    it 'I see the name of that chef' do
      visit chef_path(@chef_1.id)

      expect(page).to have_content(@chef_1.name)
    end

    it 'I see a link to view a list of all ingredients that this chef uses in their dishes' do
      visit chef_path(@chef_1.id)

      expect(page).to have_link("View This Chef's Ingredients List")
    end

    describe "When I click on that link" do
      it 'I\'m taken to a chef\'s ingredient index page and I can see a unique list of names of all the ingredients that this chef uses' do
        visit chef_path(@chef_1.id)

        click_link "View This Chef's Ingredients List"

        expect(current_path).to eq(chefs_path(@chef_1))

        expect(page).to have_content(@chef_1.name)

        expect(page).to have_content(@dish_1.ingredients.name)
        expect(page).to have_content(@dish_2.ingredients.name)
        save_and_open_page
      end
    end
  end
end
