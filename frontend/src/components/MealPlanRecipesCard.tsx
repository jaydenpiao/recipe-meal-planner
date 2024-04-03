import axios from "axios";

const MealPlanRecipesCard = ({
  recipe,
  mealplanID,
  onRatingsClick,
  onReviewsClick,
  onRecipeClick,
  onNutritionClick,
  onDeleteSuccess,
}) => {
  const handleDeleteFromMealPlanClick = async () => {
    try {
      console.log(
        "Deleting Recipe with ID: ",
        recipe.recipeID,
        " from Meal Plan with ID: ",
        mealplanID
      );
      const response = await axios.delete(
        `http://localhost:3000/api/mealplan/deleterecipe/${mealplanID}/${recipe.recipeID}`
      );
      console.log("Delete recipe from meal plan response: ", response.data);
      onDeleteSuccess();
    } catch (error) {
      console.error("Error in MealPlanCard: ", error.message);
    }
  };
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

      <button onClick={() => handleDeleteFromMealPlanClick()}>
        Delete from Meal Plan
      </button>
    </div>
  );
};

export default MealPlanRecipesCard;
