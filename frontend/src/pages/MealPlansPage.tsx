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
    try {
      console.log("Fetching mealplan for userID: ", selectedUserID);
      const response = await axios.get(
        `http://localhost:3000/api/mealplan/id/${selectedUserID}`
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

  //   return (
  //     <div className="flex flex-col items-center overflow-auto mt-24">
  //       <h1 className="text-lg font-bold">Meal Plans Page</h1>
  //       <div className="w-full">
  //         {mealplans.map((mealplan, index) => (
  //           <MealPlanCard
  //             key={index}
  //             mealplan={mealplan}
  //             onRecipesClick={() => handleRecipesClick(mealplan)}
  //             onShoppingListClick={() => handleShoppingListClick(mealplan)}
  //           />
  //         ))}
  //         <ShoppingListOverlay
  //           isOpen={isShoppingListOverlayOpen}
  //           onClose={() => setShoppingListOverlayOpen(false)}
  //           shoppingList={currentMealPlan?.shoppingList}
  //         />
  //       </div>
  //     </div>
  //   );

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
      </div>
    </div>
  );
};

export default MealPlansPage;

// const MealPlansPage = () => {
//   const [isShoppingListOverlayOpen, setShoppingListOverlayOpen] =
//     useState(false);
//   const [currentMealPlan, setCurrentMealPlan] = useState(null);

//   const mealplans = [
//     {
//       name: "Meal Plan 1",
//       recipes: ["Spaghetti", "Pizza"],
//       shoppingList: ["cheese", "sauce", "pasta", "dough"],
//     },
//     {
//       name: "Meal Plan 2",
//       recipes: ["Fries", "Ramen"],
//       shoppingList: ["potatoes", "noodles", "broth"],
//     },
//     {
//       name: "Meal Plan 3",
//       recipes: ["Fried Rice", "Poutine"],
//       shoppingList: ["rice", "potatoes", "gravy", "cheese"],
//     },
//   ];

//   const handleRecipesClick = (mealplan) => {
//     setCurrentMealPlan(mealplan);
//   };

//   const handleShoppingListClick = (mealplan) => {
//     setCurrentMealPlan(mealplan);
//     setShoppingListOverlayOpen(true);
//   };

//   return (
//     <div className="flex flex-col items-center overflow-auto mt-24">
//       <h1 className="text-lg font-bold">Meal Plans Page</h1>
//       <div className="w-full">
//         {mealplans.map((mealplan, index) => (
//           <MealPlanCard
//             key={index}
//             mealplan={mealplan}
//             onRecipesClick={() => handleRecipesClick(mealplan)}
//             onShoppingListClick={() => handleShoppingListClick(mealplan)}
//           />
//         ))}
//         <ShoppingListOverlay
//           isOpen={isShoppingListOverlayOpen}
//           onClose={() => setShoppingListOverlayOpen(false)}
//           shoppingList={currentMealPlan?.shoppingList}
//         />
//       </div>
//     </div>
//   );
// };

// export default MealPlansPage;
