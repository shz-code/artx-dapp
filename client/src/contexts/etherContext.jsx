import { createContext, useContext, useState } from "react";
import { ethers} from "ethers";

const EtherContext = createContext();

// eslint-disable-next-line react/prop-types
export const EtherContextProvider = ({ children }) => {
  const [instance, setInstance] = useState({
    account: "",
    contract: "",
  });

  const setContract = async () => {
    if(window.ethereum !== undefined) {
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();
      const account = await signer.getAddress();
      console.log(signer);
      console.log(account);
      setInstance();
      // const contract = new ethers.Contract(
      //   process.env.REACT_APP_CONTRACT_ADDRESS, 
      //   process.env.REACT_APP_CONTRACT_ABI, 
      //   signer
      //   );
      // setInstance({
      //   account: window.ethereum.selectedAddress,
      //   contract,
      // });
    }
  }

  return (
    <EtherContext.Provider
      value={{
        instance,
        setContract
      }}
    >
      {children}
    </EtherContext.Provider>
  );
};

// eslint-disable-next-line react-refresh/only-export-components
export const useEtherContext = () => useContext(EtherContext);