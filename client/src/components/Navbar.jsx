import { useEtherContext } from "../contexts/etherContext";
import Button from "./ui/Button";
const Navbar = () => {
  const { instance, setContract } = useEtherContext();

  // console.log(instance);

  const handleClick = () => {
    setContract();
  };

  return (
    <>
      <div className="flex justify-between items-center py-4">
        <div className="logo text-2xl text-purple-500 font-bold">Artx</div>
        <div className="wallet">
          {instance.account ? (
            <>
              {instance.account.slice(0, 6)}.......{instance.account.slice(38)}{" "}
              <br /> {(Number(instance.balance) / 1e18).toFixed(3)} ETH
            </>
          ) : (
            <div onClick={handleClick}>
              <Button>Connect Wallet</Button>
            </div>
          )}
        </div>
      </div>
    </>
  );
};

export default Navbar;
