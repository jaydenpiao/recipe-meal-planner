import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import NavBar from "./components/NavBar";
import HomePage from "./pages/HomePage";
import RecipesPage from "./pages/RecipesPage";
import MealPlansPage from "./pages/MealPlansPage";
import MealPlanRecipesPage from "./pages/MealPlanRecipesPage";

function App() {
  return (
    <Router>
      <NavBar />
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/recipes" element={<RecipesPage />} />
        <Route path="/mealplans" element={<MealPlansPage />} />
        <Route
          path="/mealplans/:mealPlanName"
          element={<MealPlanRecipesPage />}
        />
      </Routes>
    </Router>
  );
}

export default App;
