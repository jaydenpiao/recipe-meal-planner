import axios from "axios";

const MealPlanCard = ({
  mealplan,
  onRecipesClick,
  onShoppingListClick,
  onDeleteSuccess,
}) => {
  const handleDeleteMealPlanClick = async () => {
    try {
      console.log("Deleting meal plan with ID: ", mealplan.mealPlanID);
      const response = await axios.delete(
        `http://localhost:3000/api/mealplan/${mealplan.mealPlanID}`
      );
      console.log("Delete meal plan response: ", response.data);
      onDeleteSuccess();
    } catch (error) {
      console.error("Error in MealPlanCard: ", error.message);
    }
  };

  return (
    <div className="border p-4 m-2 grid grid-cols-4">
      <h2>{mealplan.name}</h2>
      <button onClick={() => onRecipesClick(mealplan)}>Recipes</button>
      <button onClick={() => onShoppingListClick(mealplan)}>
        Shopping List
      </button>
      <button onClick={handleDeleteMealPlanClick}>Delete Meal Plan</button>
    </div>
  );
};

export default MealPlanCard;
