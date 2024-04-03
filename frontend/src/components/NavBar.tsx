import { Link } from "react-router-dom";
import React, { useState, useEffect } from "react";
import axios from "axios";
import { ChevronDownIcon } from "@radix-ui/react-icons";
import { Button } from "@/components/ui/button";
import { useUser } from "@/context/UserContext";

export function ButtonWithIcon({ onClick, buttonText }) {
  return (
    <Button onClick={onClick} variant="ghost" className="text-2xl font-normal">
      {buttonText}
      <ChevronDownIcon className="ml-1 h-4 w-4" />
    </Button>
  );
}

const NavBar = () => {
  const [users, setUsers] = useState([]);
  const [selectedUser, setSelectedUser] = useState();
  const { setSelectedUserID } = useUser();
  // const [selectedUserID, setSelectedUserID] = useState();
  const [isDropdownVisible, setIsDropdownVisible] = useState(false);

  const toggleDropdown = () => setIsDropdownVisible(!isDropdownVisible);

  const handleSelectUser = (user) => {
    setSelectedUser(user.username);
    setSelectedUserID(user.userID);
    setIsDropdownVisible(false);
    // console.log(user);
    console.log("Selected username: ", user.username);
    console.log("Selected userID: ", user.userID);
  };

  const getUsers = async () => {
    try {
      const response = await axios.get("http://localhost:3000/api/users");
      setUsers(response.data);
    } catch (error) {
      console.error("Error in NavBar: ", error.message);
    }
  };

  useEffect(() => {
    getUsers();
  }, []);

  return (
    <nav className="flex items-center justify-evenly w-full text-2xl p-4 top-0 fixed bg-gray-300">
      <Link to="/">Home</Link>
      <Link to="/recipes">Recipes</Link>
      <Link to="/mealplans">Meal Plans</Link>
      <div className="relative">
        <ButtonWithIcon
          onClick={toggleDropdown}
          buttonText={selectedUser || "Choose User"}
        />
        {isDropdownVisible && (
          <div className="absolute z-10 mt-2 rounded-lg bg-gray-300 w-full text-center text-lg">
            {users.map((user) => (
              // href={`/user/${user.userID}`}
              <div key={user.userID}>
                <a
                  onClick={() => handleSelectUser(user)}
                  className="hover:bg-gray-400 block cursor-pointer"
                >
                  {user.username}
                </a>
              </div>
            ))}
          </div>
        )}
      </div>
    </nav>
  );
};

export default NavBar;
