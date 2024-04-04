import { Link } from "react-router-dom";
import React, { useState, useEffect } from "react";
import axios from "axios";
import { ChevronDownIcon, StarIcon } from "@radix-ui/react-icons";
import { Button } from "@/components/ui/button";
import { useUser } from "@/context/UserContext";

export function ButtonWithIcon({ onClick, buttonText, isVerified }) {
  return (
    <Button onClick={onClick} variant="ghost" className="text-2xl font-normal">
      {isVerified && <StarIcon className="inline mr-1" />}
      {buttonText}
      <ChevronDownIcon className="ml-1 h-4 w-4" />
    </Button>
  );
}

const NavBar = () => {
  const [users, setUsers] = useState([]);
  const [selectedUser, setSelectedUser] = useState();
  const { setSelectedUserID } = useUser();
  const [verifiedUsers, setVerifiedUsers] = useState([]);
  const [isVerified, setIsVerified] = useState(false);
  const [isDropdownVisible, setIsDropdownVisible] = useState(false);

  const toggleDropdown = () => setIsDropdownVisible(!isDropdownVisible);

  const handleSelectUser = (user) => {
    setSelectedUser(user.username);
    setSelectedUserID(user.userID);
    setIsVerified(verifiedUsers.includes(user.userID));
    setIsDropdownVisible(false);
    console.log("Selected username: ", user.username);
    console.log("Selected userID: ", user.userID);
  };

  const getUsers = async () => {
    try {
      const [usersResponse, verifiedResponse] = await Promise.all([
        axios.get("http://localhost:3000/api/users"),
        axios.get("http://localhost:3000/api/users/verifiedreviewers"),
      ]);
      setUsers(usersResponse.data);
      setVerifiedUsers(verifiedResponse.data.map((vUser) => vUser.userID));
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
          isVerified={isVerified}
        />
        {isDropdownVisible && (
          <div className="absolute z-30 mt-2 rounded-lg bg-gray-300 w-full text-center text-lg opacity-100">
            {users.map((user) => (
              <div key={user.userID}>
                <a
                  onClick={() => handleSelectUser(user)}
                  className="hover:bg-gray-400 block cursor-pointer"
                >
                  {verifiedUsers.includes(user.userID) && (
                    <StarIcon className="inline mr-1 mb-1" />
                  )}
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
