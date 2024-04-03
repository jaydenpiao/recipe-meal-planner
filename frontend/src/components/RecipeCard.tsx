import React, { useState } from "react";

const RecipeCard = ({
  recipe,
  mealplans,
  onAddToMealPlan,
  onRatingsClick,
  onReviewsClick,
  onRecipeClick,
  onNutritionClick,
}) => {
  
  const [showDropdown, setShowDropdown] = useState(false);
  const formattedRating = Number(recipe.avgrating).toFixed(1);

  const handleMealPlanSelect = (mealPlanId) => {
    onAddToMealPlan(recipe.recipeID, mealPlanId);
    setShowDropdown(false);
  };

  return (
    <div className="border p-4 m-2 grid grid-cols-6">
      <h2>{recipe.name}</h2>
      <button onClick={() => onRatingsClick(recipe)}>
        Rating: {formattedRating}/5
      </button>
      <button onClick={() => onReviewsClick(recipe)}>Reviews</button>
      <button onClick={() => onRecipeClick(recipe)}>Recipe</button>
      <button onClick={() => onNutritionClick(recipe)}>Nutrition Info</button>
      <div className="relative">
        <button onClick={() => setShowDropdown(!showDropdown)}>Add to Meal Plan</button>
        {showDropdown && (
          <div className="absolute z-10 mt-1 w-full rounded-md bg-white shadow-lg">      
                {mealplans.map((mealplan) => (
              <div
                key={mealplan.id}
                onClick={() => handleMealPlanSelect(mealplan.id)}
                className="p-2 hover:bg-gray-100 cursor-pointer"
              >
                {mealplan.name}
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

export default RecipeCard;
