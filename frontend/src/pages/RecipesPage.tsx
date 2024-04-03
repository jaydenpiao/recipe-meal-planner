import React, { useState, useEffect } from "react";
import RecipeCard from "@/components/RecipeCard";
import RecipeOverlay from "@/components/RecipeOverlay";
import NutritionOverlay from "@/components/NutritionOverlay";
import axios from "axios";

const RecipesPage = () => {
  const [isRecipeOverlayOpen, setRecipeOverlayOpen] = useState(false);
  const [isNutritionOverlayOpen, setNutritionOverlayOpen] = useState(false);
  const [currentRecipe, setCurrentRecipe] = useState(null);
  const [recipes, setRecipes] = useState([]);

  const getRecipes = async (recipe) => {
    try {
      const response = await axios.get("http://localhost:3000/api/recipes");
      setRecipes(response.data);
    } catch (error) {
      console.error("Error in RecipesPage: ", error.message);
    }
  };

  useEffect(() => {
    getRecipes();
  }, []);

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
        {recipes.map((recipe) => (
          <RecipeCard
            key={recipe.recipeID}
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
          nutritionInfo={currentRecipe?.instructions} // should be currentRecipe?.nutritionInfo
        />
      </div>
    </div>
  );
};

export default RecipesPage;
