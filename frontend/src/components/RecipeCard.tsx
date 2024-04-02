const RecipeCard = ({ recipe }) => {
  // Placeholder functions for button clicks
  const handleReviewsClick = () => alert("Reviews");
  const handleRecipeClick = () => alert("Recipe Details");
  const handleNutritionClick = () => alert("Nutrition Info");
  const handleAddToMealPlanClick = () => alert("Added to Meal Plan");

  return (
    <div className="border p-4 m-2 justify-evenly flex">
      <h2>{recipe.name}</h2>
      <p>Rating: {recipe.rating}/5</p>
      <button onClick={handleReviewsClick}>{recipe.reviews} Reviews</button>
      <button onClick={handleRecipeClick}>Recipe</button>
      <button onClick={handleNutritionClick}>Nutrition Info</button>
      <button onClick={handleAddToMealPlanClick}>Add to Meal Plan</button>
    </div>
  );
};

export default RecipeCard;
