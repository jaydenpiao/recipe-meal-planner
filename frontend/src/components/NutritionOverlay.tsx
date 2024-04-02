import { Button } from "@/components/ui/button";

const NutritionOverlay = ({ nutritionInfo, isOpen, onClose }) => {
  if (!isOpen) {
    return null;
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center">
      <div className="bg-white p-4">
        <h2>Nutrition Information</h2>
        <ul>
          {nutritionInfo.map((info, index) => (
            <li key={index}>{info}</li>
          ))}
        </ul>
        <Button onClick={onClose}>Close</Button>
      </div>
    </div>
  );
};

export default NutritionOverlay;
