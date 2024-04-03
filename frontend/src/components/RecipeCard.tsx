const RecipeCard = ({
  recipe,
  onRatingsClick,
  onRecipeClick,
  onNutritionClick,
}) => {
  // Placeholder functions for button clicks
  const handleReviewsClick = () => alert("Reviews");
  const handleRecipeClick = () => alert("Recipe Details");
  const handleNutritionClick = () => alert("Nutrition Info");
  const handleAddToMealPlanClick = () => alert("Added to Meal Plan");

  const formattedRating = Number(recipe.avgrating).toFixed(1);

  return (
    <div className="border p-4 m-2 grid grid-cols-6">
      <h2>{recipe.name}</h2>
      {/* TODO: need to get rating somehow */}
      {/* <p>Rating: {formattedRating}/5</p> */}
      <button onClick={() => onRatingsClick(recipe)}>
        Rating: {formattedRating}/5
      </button>
      {/* TODO: need to get reviews somehow */}
      <button onClick={handleReviewsClick}>{recipe.reviews} Reviews</button>
      <button onClick={() => onRecipeClick(recipe)}>Recipe</button>
      <button onClick={() => onNutritionClick(recipe)}>Nutrition Info</button>
      {/* TODO */}
      <button onClick={handleAddToMealPlanClick}>Add to Meal Plan</button>
    </div>
  );
};

export default RecipeCard;
