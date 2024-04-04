import axios from "axios";
import { useState } from "react";

const MealPlanCard = ({
  mealplan,
  onRecipesClick,
  onShoppingListClick,
  onDeleteSuccess,
}) => {
  const [isEditing, setIsEditing] = useState(false);
  const [editedName, setEditedName] = useState(mealplan.name);

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

  const handleNameEdit = async (e) => {
    if (e.key === "Enter") {
      try {
        console.log("Editing meal plan name with ID: ", mealplan.mealPlanID);
        const newName = e.target.value.trim().replace(/\s+/g, "-");
        const response = await axios.put(
          `http://localhost:3000/api/mealplan/${mealplan.mealPlanID}/${newName}`
        );
        console.log("Edit meal plan response: ", response.data);
        setEditedName(newName.replace(/-/g, " "));
        setIsEditing(false);
        onDeleteSuccess();
      } catch (error) {
        console.error("Error in MealPlanCard: ", error.message);
      }
    }
  };

  return (
    <div className="border p-4 m-2 grid grid-cols-4">
      {isEditing ? (
        <input
          type="text"
          value={editedName}
          onChange={(e) => setEditedName(e.target.value)}
          onKeyDown={handleNameEdit}
          autoFocus
          className="col-span-1"
        />
      ) : (
        <h2 onClick={() => setIsEditing(true)}>{mealplan.name}</h2>
      )}
      <button onClick={() => onRecipesClick(mealplan)}>Recipes</button>
      <button onClick={() => onShoppingListClick(mealplan)}>
        Shopping List
      </button>
      <button onClick={handleDeleteMealPlanClick}>Delete Meal Plan</button>
    </div>
  );
};

export default MealPlanCard;
