import React, { createContext, useContext, useState } from "react";

const UserContext = createContext();

export const useUser = () => useContext(UserContext);

export const UserProvider = ({ children }) => {
  const [selectedUserID, setSelectedUserID] = useState();

  return (
    <UserContext.Provider value={{ selectedUserID, setSelectedUserID }}>
      {children}
    </UserContext.Provider>
  );
};
