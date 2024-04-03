import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Checkbox } from "@/components/ui/checkbox";

export function CheckboxDisabled() {
  return (
    <div className="flex items-center space-x-2">
      <Checkbox id="terms2" disabled />
      <label
        htmlFor="terms2"
        className="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
      >
        Accept terms and conditions
      </label>
    </div>
  );
}

const SearchBar = () => {
  return (
    <div className="flex w-full max-w-sm items-center space-x-2 m-2">
      <Input type="search" placeholder="Search for a recipe" />
      <Button type="submit">Search</Button>
      <div className="p-3 m-2 flex rounded-lg border border-gray-400 space-x-1">
        <Checkbox id="potato" />
        <label
          htmlFor="potato"
          className="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
        >
          potato
        </label>
      </div>
    </div>
  );
};

export default SearchBar;
