class Dish <ApplicationRecord
  validates_presence_of :name, :description
  belongs_to :chef
  has_many :dish_ingredients
  has_many :ingredients, through: :dish_ingredients

  def total_calories
    self.ingredients.sum(:calories)
  end

  def ingredient_names
    x = self.ingredients.map {|ingredient| ingredient.name}
    x.join(', ')
  end
end
