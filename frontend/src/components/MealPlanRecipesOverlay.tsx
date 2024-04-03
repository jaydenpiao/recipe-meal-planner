import { Button } from "@/components/ui/button";
import axios from "axios";
import { useEffect, useState } from "react";
import MealPlanRecipesCard from "./MealPlanRecipesCard";
import RatingsOverlay from "./RatingsOverlay";
import ReviewsOverlay from "./ReviewsOverlay";

const MealPlanRecipesOverlay = ({ mealPlanID, isOpen, onClose }) => {
  const [recipes, setRecipes] = useState([]);
  const [isRatingsOverlayOpen, setRatingsOverlayOpen] = useState(false);
  const [isReviewsOverlayOpen, setReviewsOverlayOpen] = useState(false);
  const [currentRecipeID, setCurrentRecipeID] = useState(null);

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
            const ratings = await axios.get(
              `http://localhost:3000/api/recipes/ratingsid/${id}`
            );
            return { ...response.data, ratings: ratings.data };
          })
        );

        setRecipes(recipeDetails);
      } catch (error) {
        console.error("Error in MealPlanRecipesOverlay: ", error.message);
      }
    };

    fetchRecipes();
  }, [mealPlanID, isOpen]);

  const handleRatingsClick = (recipeID) => {
    setCurrentRecipeID(recipeID);
    setRatingsOverlayOpen(true);
  };

  const handleReviewsClick = (recipeID) => {
    setCurrentRecipeID(recipeID);
    setReviewsOverlayOpen(true);
  };

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
              <MealPlanRecipesCard
                recipe={recipe}
                onRatingsClick={() => handleRatingsClick(recipe.recipeID)}
                onReviewsClick={() => handleReviewsClick(recipe.recipeID)}
              />
            </li>
          ))}
        </ul>
        <Button onClick={onClose}>Close</Button>
      </div>
      <RatingsOverlay
        isOpen={isRatingsOverlayOpen}
        onClose={() => setRatingsOverlayOpen(false)}
        recipeID={currentRecipeID}
      />
      <ReviewsOverlay
        isOpen={isReviewsOverlayOpen}
        onClose={() => setReviewsOverlayOpen(false)}
        recipeID={currentRecipeID}
      />
    </div>
  );
};

export default MealPlanRecipesOverlay;
