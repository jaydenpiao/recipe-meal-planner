import React, { useState, useEffect } from "react";
import ShoppingListOverlay from "@/components/ShoppingListOverlay";
import MealPlanCard from "@/components/MealPlanCard";
import { useUser } from "@/context/UserContext";
import axios from "axios";

const MealPlansPage = () => {
  const { selectedUserID } = useUser();
  const [isRecipesOverlayOpen, setRecipesOverlayOpen] = useState(false);
  const [isShoppingListOverlayOpen, setShoppingListOverlayOpen] =
    useState(false);
  const [currentMealPlan, setCurrentMealPlan] = useState(null);
  const [mealplans, setMealPlans] = useState([]);

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

  const handleRecipesClick = (mealplan) => {
    setCurrentMealPlan(mealplan);
    setRecipesOverlayOpen(true);
  };

  const handleShoppingListClick = (mealplan) => {
    setCurrentMealPlan(mealplan);
    setShoppingListOverlayOpen(true);
  };

  return (
    <div className="flex flex-col items-center overflow-auto mt-24">
      <h1 className="text-lg font-bold">Meal Plans Page</h1>
      <div className="w-full">
        {mealplans.map((mealplan) => (
          <MealPlanCard
            key={mealplan.mealPlanID}
            mealplan={mealplan}
            onRecipesClick={() => handleRecipesClick(mealplan)}
            onShoppingListClick={() => handleShoppingListClick(mealplan)}
          />
        ))}
        {/* <RecipesOverlay
          mealPlanID={currentMealPlan?.mealPlanID}
          isOpen={isRecipesOverlayOpen}
          onClose={() => setRecipesOverlayOpen(false)}
        />
        <ShoppingListOverlay
          mealPlanID={currentMealPlan?.mealPlanID}
          isOpen={isShoppingListOverlayOpen}
          onClose={() => setShoppingListOverlayOpen(false)}
        /> */}
      </div>
    </div>
  );
};

export default MealPlansPage;
