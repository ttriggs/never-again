module CuisineHelper
  def cuisines_to_array
    Cuisine.all.map { |c| [c.name, c.id] }
  end
end
