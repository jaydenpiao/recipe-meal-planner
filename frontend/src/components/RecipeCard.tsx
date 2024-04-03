const RecipeCard = ({
  recipe,
  onRatingsClick,
  onReviewsClick,
  onRecipeClick,
  onNutritionClick,
}) => {
  // Placeholder functions for button clicks
  const handleAddToMealPlanClick = () => alert("Added to Meal Plan");

  const formattedRating = Number(recipe.avgrating).toFixed(1);

  return (
    <div className="border p-4 m-2 grid grid-cols-6">
      <h2>{recipe.name}</h2>
      <button onClick={() => onRatingsClick(recipe)}>
        Rating: {formattedRating}/5
      </button>
      <button onClick={() => onReviewsClick(recipe)}>Reviews</button>
      <button onClick={() => onRecipeClick(recipe)}>Recipe</button>
      <button onClick={() => onNutritionClick(recipe)}>Nutrition Info</button>
      {/* TODO */}
      <button onClick={handleAddToMealPlanClick}>Add to Meal Plan</button>
    </div>
  );
};

export default RecipeCard;
