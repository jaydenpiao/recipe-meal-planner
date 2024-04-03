import { Button } from "@/components/ui/button";
import axios from "axios";
import { useEffect, useState } from "react";
import MealPlanRecipesCard from "./MealPlanRecipesCard";

const MealPlanRecipesOverlay = ({ mealPlanID, isOpen, onClose }) => {
  //   const [IDPairs, setIDPairs] = useState([]);
  const [recipes, setRecipes] = useState([]);

  useEffect(() => {
    if (!isOpen) return;

    const fetchRecipes = async () => {
      try {
        console.log("Fetching recipes for mealPlanID: ", mealPlanID);
        const idPairsResponse = await axios.get(
          `http://localhost:3000/api/mealplan/mealplanid/${mealPlanID}`
        );
        const recipeIDs = idPairsResponse.data.map((pair) => pair.recipeID);

        const recipeDetails = await Promise.all(
          recipeIDs.map(async (id) => {
            const response = await axios.get(
              `http://localhost:3000/api/recipes/id/${id}`
            );
            return response.data;
          })
        );

        setRecipes(recipeDetails);
      } catch (error) {
        console.error("Error in MealPlanRecipesOverlay: ", error.message);
      }
    };

    fetchRecipes();
  }, [mealPlanID, isOpen]);

  if (!isOpen) {
    return null;
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center">
      <div className="bg-white p-4">
        <h2>Recipes</h2>
        <ul>
          {recipes.map((recipe, index) => (
            <li key={index}>
              <MealPlanRecipesCard recipe={recipe} />
            </li>
          ))}
        </ul>
        <Button onClick={onClose}>Close</Button>
      </div>
    </div>
  );
};

export default MealPlanRecipesOverlay;
