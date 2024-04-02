const MealPlanCard = ({ mealplan, onRecipesClick, onShoppingListClick }) => {
  // Placeholder functions for button clicks
  const handleDeleteMealPlanClick = () => alert("Deleted Meal Plan");

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
