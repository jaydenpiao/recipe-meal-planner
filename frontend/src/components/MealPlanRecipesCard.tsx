import React from "react";

const MealPlanRecipesCard = ({ recipe }) => {
  const sumProductOfRatingsAndCounts = recipe.ratings.reduce(
    (acc, curr) => acc + curr.rating * curr.count,
    0
  );
  const totalCounts = recipe.ratings.reduce((acc, curr) => acc + curr.count, 0);
  const averageRating = sumProductOfRatingsAndCounts / totalCounts;
  const formattedRating = averageRating.toFixed(1);
  return (
    <div className="border p-4 m-2 grid grid-cols-6">
      <p>{recipe.recipeID}</p>
      <p>{recipe.name}</p>
      <p>{recipe.instructions}</p>
      <p>Rating: {formattedRating}</p>
    </div>
  );
};

export default MealPlanRecipesCard;
