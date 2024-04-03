import { Button } from "@/components/ui/button";
import axios from "axios";
import { useEffect, useState } from "react";

const ReviewsOverlay = ({ recipeID, isOpen, onClose }) => {
  const [reviews, setReviews] = useState([]);

  useEffect(() => {
    if (!isOpen) return;

    const getReviews = async () => {
      try {
        console.log("Fetching reviews for recipeID: ", recipeID);
        const response = await axios.get(
          `http://localhost:3000/api/recipes/reviews/${recipeID}`
        );
        setReviews(response.data);
      } catch (error) {
        console.error("Error in ReviewsOverlay: ", error.message);
      }
    };

    getReviews();
  }, [recipeID, isOpen]);

  if (!isOpen) {
    return null;
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center">
      <div className="bg-white p-4">
        <h2>Reviews</h2>
        <ul>
          {reviews.map((review, index) => (
            <li key={index}>
              Date: {review.date} - Review: {review.message}
            </li>
          ))}
        </ul>
        <Button onClick={onClose}>Close</Button>
      </div>
    </div>
  );
};

export default ReviewsOverlay;
