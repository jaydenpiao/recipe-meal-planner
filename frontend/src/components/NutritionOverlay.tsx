import { Button } from "@/components/ui/button";
import axios from "axios";
import { useEffect, useState } from "react";

const NutritionOverlay = ({ recipeID, isOpen, onClose }) => {
  const [nutritions, setNutritions] = useState([]);

  useEffect(() => {
    if (!isOpen) return;

    const getNutrition = async () => {
      try {
        console.log("Fetching nutrition for recipeID: ", recipeID);
        const response = await axios.get(
          `http://localhost:3000/api/recipes/nutrition/${recipeID}`
        );
        setNutritions(response.data);
      } catch (error) {
        console.error("Error in NutritionOverlay: ", error.message);
      }
    };

    getNutrition();
  }, [recipeID, isOpen]);

  if (!isOpen) {
    return null;
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center">
      <div className="bg-white p-4">
        <h2>Nutrition Info</h2>
        <ul>
          {nutritions.map((info, index) => (
            <li key={index}>
              Calories: {info.calories} | Sugar: {info.sugar} | Protein:{" "}
              {info.protein} | Fat: {info.fat} | Carbs: {info.carbs}
            </li>
          ))}
        </ul>
        <Button onClick={onClose}>Close</Button>
      </div>
    </div>
  );
};

export default NutritionOverlay;
