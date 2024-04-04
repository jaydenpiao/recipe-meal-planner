import { useState } from "react";
import axios from "axios";
import { useUser } from "@/context/UserContext";
import { Button } from "./ui/button";
import { Input } from "./ui/input";

const AddMealPlanButton = ({ onAddSuccess }) => {
  const [mealPlanName, setMealPlanName] = useState("");
  const { selectedUserID } = useUser();

  const handleAddMealPlan = async () => {
    if (!mealPlanName.trim() || !selectedUserID) return;

    const formattedMealPlanName = mealPlanName.trim().replace(/\s+/g, "-");
    try {
      console.log("Adding meal plan for userID: ", selectedUserID);
      await axios.post(
        `http://localhost:3000/api/mealplan/create/${selectedUserID}/${formattedMealPlanName}`
      );
      setMealPlanName("");
      onAddSuccess();
    } catch (error) {
      console.error("Failed to add meal plan: ", error.message);
    }
  };

  return (
    <div className="flex border p-2 m-2 items-center space-x-2">
      <Input
        type="text"
        value={mealPlanName}
        onChange={(e) => setMealPlanName(e.target.value)}
        placeholder="Enter meal plan name"
        className="w-1/4"
      />
      <Button onClick={handleAddMealPlan} type="button">
        Add Meal Plan
      </Button>
    </div>
  );
};

export default AddMealPlanButton;
