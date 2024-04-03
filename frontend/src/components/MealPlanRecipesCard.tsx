import React from "react";

const MealPlanRecipesCard = ({
  recipe,
  onRatingsClick,
  onReviewsClick,
  onRecipeClick,
  onNutritionClick,
}) => {
  const sumProductOfRatingsAndCounts = recipe.ratings.reduce(
    (acc, curr) => acc + curr.rating * curr.count,
    0
  );
  const totalCounts = recipe.ratings.reduce((acc, curr) => acc + curr.count, 0);
  const averageRating = sumProductOfRatingsAndCounts / totalCounts;
  const formattedRating = averageRating.toFixed(1);
  return (
    <div className="border p-4 m-2 grid grid-cols-6">
      <p>{recipe.name}</p>
      <button onClick={() => onRatingsClick(recipe)}>
        Rating: {formattedRating}
      </button>
      <button onClick={() => onReviewsClick(recipe)}>Reviews</button>
      <button onClick={() => onRecipeClick(recipe)}>Recipe</button>
      <button onClick={() => onNutritionClick(recipe)}>Nutrition Info</button>
    </div>
  );
};

export default MealPlanRecipesCard;
