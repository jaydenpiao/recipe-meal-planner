import React, { useState, useEffect } from "react";
import RecipeCard from "@/components/RecipeCard";
import RecipeOverlay from "@/components/RecipeOverlay";
import NutritionOverlay from "@/components/NutritionOverlay";

const RecipesPage = () => {
  const [isRecipeOverlayOpen, setRecipeOverlayOpen] = useState(false);
  const [isNutritionOverlayOpen, setNutritionOverlayOpen] = useState(false);
  const [currentRecipe, setCurrentRecipe] = useState(null);

  const recipes = [
    {
      name: "Spaghetti",
      rating: 4,
      reviews: 2,
      recipe: "1. cheese 2. sauce 3. pasta",
      nutritionInfo: ["1000 calories", "10 fat", "1 protein"],
    },
    {
      name: "Pizza",
      rating: 4,
      reviews: 2,
      recipe: "1. cheese 2. sauce 3. dough",
      nutritionInfo: ["1200 calories", "10 fat", "1 protein"],
    },
    {
      name: "Potatoes",
      rating: 4,
      reviews: 2,
      recipe: "1. potatoes",
      nutritionInfo: ["500 calories", "10 fat", "1 protein"],
    },
  ];

  const handleRecipeClick = (recipe) => {
    setCurrentRecipe(recipe);
    setRecipeOverlayOpen(true);
  };

  const handleNutritionClick = (recipe) => {
    setCurrentRecipe(recipe);
    setNutritionOverlayOpen(true);
  };

  return (
    <div className="flex flex-col items-center overflow-auto mt-24">
      <h1 className="text-lg font-bold">Recipes Page</h1>
      <div className="w-full">
        {recipes.map((recipe, index) => (
          <RecipeCard
            key={index}
            recipe={recipe}
            onRecipeClick={() => handleRecipeClick(recipe)}
            onNutritionClick={() => handleNutritionClick(recipe)}
          />
        ))}
        <RecipeOverlay
          isOpen={isRecipeOverlayOpen}
          onClose={() => setRecipeOverlayOpen(false)}
          recipe={currentRecipe}
        />
        <NutritionOverlay
          isOpen={isNutritionOverlayOpen}
          onClose={() => setNutritionOverlayOpen(false)}
          nutritionInfo={currentRecipe?.nutritionInfo}
        />
      </div>
    </div>
  );
};

export default RecipesPage;
