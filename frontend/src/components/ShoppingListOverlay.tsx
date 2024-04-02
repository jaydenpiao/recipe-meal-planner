import { Button } from "@/components/ui/button";

const ShoppingListOverlay = ({ shoppingList, isOpen, onClose }) => {
  if (!isOpen) {
    return null;
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center">
      <div className="bg-white p-4">
        <h2>Shopping List</h2>
        <ul>
          {shoppingList.map((ingredient, index) => (
            <li key={index}>{ingredient}</li>
          ))}
        </ul>
        <Button onClick={onClose}>Close</Button>
      </div>
    </div>
  );
};

export default ShoppingListOverlay;
