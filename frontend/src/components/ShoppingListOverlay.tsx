import { Button } from "@/components/ui/button";
import axios from "axios";
import { useEffect, useState } from "react";

const ShoppingListOverlay = ({ mealPlanID, isOpen, onClose }) => {
  const [shoppingListItems, setShoppingListItems] = useState([]);

  useEffect(() => {
    if (!isOpen) return;

    const getShoppingListItems = async () => {
      try {
        console.log("Fetching items for mealplan ID: ", mealPlanID);
        const response = await axios.get(
          `http://localhost:3000/api/shoppinglist/${mealPlanID}`
        );
        setShoppingListItems(response.data);
      } catch (error) {
        console.error("Error in ShoppingListOverlay: ", error.message);
      }
    };

    getShoppingListItems();
  }, [mealPlanID, isOpen]);

  if (!isOpen) {
    return null;
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center">
      <div className="bg-white p-4">
        <h2>Shopping List</h2>
        <ul>
          {shoppingListItems.map((item, index) => (
            <li key={index}>{item.ingredient}</li>
          ))}
        </ul>
        <Button onClick={onClose}>Close</Button>
      </div>
    </div>
  );
};

export default ShoppingListOverlay;
