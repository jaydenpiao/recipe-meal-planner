import { Button } from "@/components/ui/button";

const RecipeOverlay = ({ recipe, isOpen, onClose }) => {
  if (!isOpen) {
    return null;
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center">
      <div className="bg-white p-4">
        <h2>{recipe.name} Recipe</h2>
        <p>{recipe.instructions}</p>
        <Button onClick={onClose}>Close</Button>
      </div>
    </div>
  );
};

export default RecipeOverlay;
