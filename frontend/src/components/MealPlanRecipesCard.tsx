import React from "react";

const MealPlanRecipesCard = ({ recipe }) => {
  return (
    <div className="border p-4 rounded">
      <h3>{recipe.name}</h3>
      <p>{recipe.instructions}</p>
    </div>
  );
};

export default MealPlanRecipesCard;
