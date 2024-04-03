import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Checkbox } from "@/components/ui/checkbox";
import { useState } from "react";

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
      <Checkbox
        id="sugarFree"
        checked={sugarFree}
        onChange={(e) => setSugarFree(e.target.checked)}
      />
      <label htmlFor="sugarFree">Sugar Free</label>
      <Checkbox
        id="lowCalorie"
        checked={lowCalorie}
        onChange={(e) => setLowCalorie(e.target.checked)}
      />
      <label htmlFor="lowCalorie">Low Calorie</label>
      <Checkbox
        id="vegetarian"
        checked={vegetarian}
        onChange={(e) => setVegetarian(e.target.checked)}
      />
      <label htmlFor="vegetarian">Vegetarian</label>
      <Button type="button" onClick={handleSearch}>
        Search
      </Button>

      {/* <Button type="submit">Search</Button>
      <div className="p-3 m-2 flex rounded-lg border border-gray-400 space-x-1">
        <Checkbox id="potato" />
        <label
          htmlFor="potato"
          className="text-sm font-medium leading-none peer-disabled:cursor-not-allowed"
        >
          potato
        </label>
      </div> */}
    </div>
  );
};

export default SearchBar;
