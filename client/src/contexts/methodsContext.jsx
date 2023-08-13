import { createContext, useContext } from "react";
// import { useEtherContext } from "./etherContext";

const MethodsContext = createContext();

// eslint-disable-next-line react/prop-types
export const MethodsContextProvider = ({ children }) => {
  // const { instance } = useEtherContext;

  // console.log(instance);

  return (
    <MethodsContext.Provider value={{}}>{children}</MethodsContext.Provider>
  );
};

// eslint-disable-next-line react-refresh/only-export-components
export const useMethodsContext = () => useContext(MethodsContext);
