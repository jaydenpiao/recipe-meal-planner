import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
// import { Checkbox } from "@/components/ui/checkbox";
import { useState } from "react";

const Checkbox = ({ id, checked, onChange }) => (
  <input type="checkbox" id={id} checked={checked} onChange={onChange} />
);

const SearchBar = ({ onSearch }) => {
  const [searchName, setSearchName] = useState("");
  const [minRating, setMinRating] = useState("");
  const [sugarFree, setSugarFree] = useState(false);
  const [lowCalorie, setLowCalorie] = useState(false);
  const [vegetarian, setVegetarian] = useState(false);

  const handleSearch = () => {
    onSearch({
      name: searchName || null,
      minRating: minRating || null,
      sugarFree: sugarFree ? 1 : 0,
      lowCalorie: lowCalorie ? 1 : 0,
      vegetarian: vegetarian ? 1 : 0,
    });
  };

  return (
    <div className="flex border p-2 m-2 items-center space-x-2">
      <Input
        type="search"
        placeholder="Search for a recipe"
        value={searchName}
        onChange={(e) => setSearchName(e.target.value)}
        className="w-1/4"
      />
      <select
        className="p-2"
        value={minRating}
        onChange={(e) => setMinRating(e.target.value)}
      >
        <option value="">Select Min Rating</option>
        {[1, 2, 3, 4].map((rating) => (
          <option key={rating} value={rating}>
            {rating}
          </option>
        ))}
      </select>
      <div className="p-2 flex rounded-lg border space-x-1">
        <Checkbox
          id="sugarFree"
          checked={sugarFree}
          onChange={(e) => setSugarFree(e.target.checked)}
        />
        <label htmlFor="sugarFree">Sugar Free</label>
      </div>

      <div className="p-2 flex rounded-lg border space-x-1">
        <Checkbox
          id="lowCalorie"
          checked={lowCalorie}
          onChange={(e) => setLowCalorie(e.target.checked)}
        />
        <label htmlFor="lowCalorie">Low Calorie</label>
      </div>

      <div className="p-2 flex rounded-lg border space-x-1">
        <Checkbox
          id="vegetarian"
          checked={vegetarian}
          onChange={(e) => setVegetarian(e.target.checked)}
        />
        <label htmlFor="vegetarian">Vegetarian</label>
      </div>
      <Button type="button" onClick={handleSearch}>
        Search
      </Button>
    </div>
  );
};

export default SearchBar;
