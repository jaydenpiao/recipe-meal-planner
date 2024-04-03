import { useUser } from "@/context/UserContext";
import axios from "axios";
import { useState, useEffect } from "react";
import { ChevronDownIcon } from "@radix-ui/react-icons";

const RecipeCard = ({
  recipe,
  onRatingsClick,
  onReviewsClick,
  onRecipeClick,
  onNutritionClick,
}) => {
  const { selectedUserID } = useUser();
  const [mealplans, setMealPlans] = useState([]);
  const [isAddToMealPlanDropdownVisible, setIsAddToMealPlanDropdownVisible] =
    useState(false);

  const toggleAddToMealPlanDropdown = () =>
    setIsAddToMealPlanDropdownVisible(!isAddToMealPlanDropdownVisible);

  const getMealPlans = async (mealplan) => {
    if (!selectedUserID) return;
    try {
      console.log("Fetching mealplan for userID: ", selectedUserID);
      const response = await axios.get(
        `http://localhost:3000/api/mealplan/${selectedUserID}`
      );
      setMealPlans(response.data);
    } catch (error) {
      console.error("Error in MealPlansPage: ", error.message);
    }
  };

  useEffect(() => {
    getMealPlans();
  }, [selectedUserID]);

  const handleAddToMealPlanClick = async (mealplanID) => {
    try {
      console.log(
        "Adding recipe with ID: ",
        recipe.recipeID,
        " to mealplan with ID: ",
        mealplanID
      );
      await axios.post(
        `http://localhost:3000/api/mealplan/addrecipe/${mealplanID}/${recipe.recipeID}`
      );
      setIsAddToMealPlanDropdownVisible(false);
    } catch (error) {
      console.error("Error in RecipeCard: ", error.message);
    }
  };

  const formattedRating = Number(recipe.avgrating).toFixed(1);

  return (
    <div className="border p-4 m-2 grid grid-cols-6">
      <p>{recipe.name}</p>
      <button onClick={() => onRatingsClick(recipe)}>
        Rating: {formattedRating}/5
      </button>
      <button onClick={() => onReviewsClick(recipe)}>Reviews</button>
      <button onClick={() => onRecipeClick(recipe)}>Recipe</button>
      <button onClick={() => onNutritionClick(recipe)}>Nutrition Info</button>
      <div className="relative">
        <button onClick={toggleAddToMealPlanDropdown} className="flex">
          Add to Meal Plan
          <ChevronDownIcon className="ml-1 h-5 w-4" />
        </button>
        {isAddToMealPlanDropdownVisible && (
          <div className="absolute mt-2 bg-gray-300 text-center text-lg w-full opacity-100 z-10">
            {mealplans.map((plan) => (
              <div
                key={plan.mealPlanID}
                className="hover:bg-gray-400 block cursor-pointer"
              >
                <button
                  onClick={() => handleAddToMealPlanClick(plan.mealPlanID)}
                >
                  {plan.name}
                </button>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

export default RecipeCard;
