import { LogOut } from "lucide-react";
import { useEtherContext } from "../contexts/etherContext";
import { FormatETH } from "../lib/utilities";
import Button from "./ui/Button";
import Logo from "./ui/Logo";
const Navbar = () => {
  const { instance, setContract, disconnect } = useEtherContext();
  const { account, balance } = instance;

  // console.log(instance);

  const handleClick = () => {
    setContract();
  };

  const handleLogout = () => {
    disconnect();
  };

  return (
    <>
      <div className="bg-zinc-800/25 py-4 mb-4">
        <nav className="flex justify-between items-center container mx-auto px-1">
          <Logo />
          <div className="wallet">
            {instance.account ? (
              <>
                <div className="bg-zinc-800/25 px-4 py-1 rounded-md">
                  <div className="wallet-details flex items-center gap-4">
                    <div className="text-zinc-400">
                      {account.slice(0, 6)}.......
                      {account.slice(38)} <br />{" "}
                      {balance ? FormatETH(balance) : 0.0} ETH
                    </div>
                    <span
                      className="cursor-pointer hover:bg-zinc-800 p-2 rounded-md transition-all ease-in"
                      title="Disconnect Wallet"
                      onClick={handleLogout}
                    >
                      <LogOut />
                    </span>
                  </div>
                </div>
              </>
            ) : (
              <div onClick={handleClick}>
                <Button>Connect Wallet</Button>
              </div>
            )}
          </div>
        </nav>
      </div>
    </>
  );
};

export default Navbar;
