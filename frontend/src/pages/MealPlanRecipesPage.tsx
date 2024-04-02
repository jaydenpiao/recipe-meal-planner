import React from "react";
import { useParams } from "react-router-dom";

const MealPlanRecipesPage = ({ mealplans }) => {
  let { mealPlanName } = useParams();
  const mealplan = mealplans.find(
    (mp) => mp.name === mealPlanName.replace(/_/g, " ")
  );

  return (
    <div className="flex flex-col items-center overflow-auto mt-24">
      <h1 className="text-lg font-bold">
        {mealPlanName.replace(/_/g, " ")} Recipes
      </h1>
      <ul>
        {mealplan?.recipes.map((recipe, index) => (
          <li key={index}>{recipe}</li>
        ))}
      </ul>
    </div>
  );
};

export default MealPlanRecipesPage;
