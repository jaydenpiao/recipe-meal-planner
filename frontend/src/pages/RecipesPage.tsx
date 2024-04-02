import RecipeCard from "@/components/RecipeCard";

const RecipesPage = () => {
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
      recipe: "1. cheese 2. sauce 3. pasta",
      nutritionInfo: ["1000 calories", "10 fat", "1 protein"],
    },
    {
      name: "Potatoes",
      rating: 4,
      reviews: 2,
      recipe: "1. cheese 2. sauce 3. pasta",
      nutritionInfo: ["1000 calories", "10 fat", "1 protein"],
    },
    {
      name: "Burger",
      rating: 4,
      reviews: 2,
      recipe: "1. cheese 2. sauce 3. pasta",
      nutritionInfo: ["1000 calories", "10 fat", "1 protein"],
    },
  ];

  return (
    <div className="flex flex-col items-center overflow-auto">
      <h1 className="text-lg font-bold">Recipes Page</h1>
      <div className="w-full">
        {recipes.map((recipe, index) => (
          <RecipeCard key={index} recipe={recipe} />
        ))}
      </div>
    </div>
  );
};

export default RecipesPage;
