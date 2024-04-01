import { Link } from "react-router-dom";

const NavBar = () => {
  return (
    <nav className="flex items-center justify-evenly w-full text-2xl">
      <Link to="/">Home</Link>
      <Link to="/recipes">Recipes</Link>
      <Link to="/mealplans">Meal Plans</Link>
    </nav>
  );
};

export default NavBar;
