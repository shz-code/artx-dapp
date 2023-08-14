import { ethers } from "ethers";
import { createContext, useContext, useEffect, useState } from "react";

const EtherContext = createContext();

// eslint-disable-next-line react/prop-types
export const EtherContextProvider = ({ children }) => {
  const [instance, setInstance] = useState({
    account: "",
    contract: "",
    provider: null,
    balance: null,
  });

  const eventListen = (provider, account) => {
    console.log("Checking");
    window.ethereum.on("accountsChanged", async () => {
      if (window.ethereum.selectedAddress) {
        provider = new ethers.BrowserProvider(window.ethereum);
        let newSigner = await provider.getSigner();
        account = await newSigner.getAddress();
        const balance = await provider.getBalance(account);
        setInstance({
          provider: provider,
          balance: Number(balance),
          account: account,
        });
      } else {
        localStorage.clear();
        setInstance({
          account: "",
          contract: "",
          provider: null,
          balance: null,
        });
      }
    });

    window.ethereum.on("chainChanged", async () => {
      console.log(2);
      let newProvider = new ethers.BrowserProvider(window.ethereum);
      const balance = await newProvider.getBalance(account);
      setInstance({
        provider: newProvider,
        balance: balance,
        account: account,
      });
    });
  };

  useEffect(() => {
    const init = async () => {
      if (localStorage.getItem("account")) {
        const provider = new ethers.BrowserProvider(window.ethereum);
        const signer = await provider.getSigner();
        const account = await signer.getAddress();
        const balance = await provider.getBalance(account);
        setInstance({
          provider: provider,
          account: account,
          balance: Number(balance),
        });
        eventListen(provider, account);
      }
    };
    init();
  }, []);

  const setContract = async () => {
    if (window.ethereum !== undefined) {
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();
      const account = await signer.getAddress();
      const balance = await provider.getBalance(account);
      setInstance({ provider: provider, account: account, balance: balance });
      localStorage.setItem("account", account);
      eventListen(provider, account);
      // const contract = new ethers.Contract(
      //   process.env.REACT_APP_CONTRACT_ADDRESS,
      //   process.env.REACT_APP_CONTRACT_ABI,
      //   signer
      //   );
      // setInstance({
      //   account: window.ethereum.selectedAddress,
      //   contract,
      // });
    } else console.log("No Ethereum Instance available");
  };

  return (
    <EtherContext.Provider
      value={{
        instance,
        setContract,
      }}
    >
      {children}
    </EtherContext.Provider>
  );
};

// eslint-disable-next-line react-refresh/only-export-components
export const useEtherContext = () => useContext(EtherContext);
