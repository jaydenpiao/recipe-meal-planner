import { Button } from "@/components/ui/button";
import axios from "axios";
import { useEffect, useState } from "react";

const RatingsOverlay = ({ recipeID, isOpen, onClose }) => {
  const [ratings, setRatings] = useState([]);

  useEffect(() => {
    if (!isOpen) return;

    const getRatings = async () => {
      try {
        console.log("Fetching ratings for recipeID: ", recipeID);
        const response = await axios.get(
          `http://localhost:3000/api/recipes/ratingsid/${recipeID}`
        );
        setRatings(response.data);
      } catch (error) {
        console.error("Error in RatingsOverlay: ", error.message);
      }
    };

    getRatings();
  }, [recipeID, isOpen]);

  if (!isOpen) {
    return null;
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center">
      <div className="bg-white p-4">
        <h2>Ratings</h2>
        <ul>
          {ratings.map((rating, index) => (
            <li key={index}>
              Rating: {rating.rating} - Count: {rating.count}
            </li>
          ))}
        </ul>
        <Button onClick={onClose}>Close</Button>
      </div>
    </div>
  );
};

export default RatingsOverlay;
