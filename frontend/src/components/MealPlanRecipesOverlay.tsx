import { Button } from "@/components/ui/button";
import axios from "axios";
import { useEffect, useState } from "react";

const MealPlanRecipesOverlay = ({ mealPlanID, isOpen, onClose }) => {
  const [IDPairs, setIDPairs] = useState([]);

  useEffect(() => {
    if (!isOpen) return;

    const getIDPairs = async () => {
      try {
        console.log("Fetching recipes for mealPlanID: ", mealPlanID);
        const response = await axios.get(
          `http://localhost:3000/api/mealplan/mealplanid/${mealPlanID}`
        );
        setIDPairs(response.data);
      } catch (error) {
        console.error("Error in MealPlanRecipesOverlay: ", error.message);
      }
    };

    getIDPairs();
  }, [mealPlanID, isOpen]);

  if (!isOpen) {
    return null;
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center">
      <div className="bg-white p-4">
        <h2>Recipes</h2>
        <ul>
          {IDPairs.map((pair, index) => (
            <li key={index}>
              Recipe ID: {pair.recipeID} - Meal Plan ID: {pair.mealPlanID}
            </li>
          ))}
        </ul>
        <Button onClick={onClose}>Close</Button>
      </div>
    </div>
  );
};

export default MealPlanRecipesOverlay;
