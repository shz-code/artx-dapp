import { useEtherContext } from "../../contexts/etherContext";
import AccountDetails from "../AccountDetails";
import Arts from "../Arts";
import OtherUsers from "../OtherUsers";
import Logo from "../ui/Logo";

const Dashboard = () => {
  const { instance } = useEtherContext();
  const { account } = instance;
  return (
    <>
      {account ? (
        <div className="lg:flex justify-between">
          <div className="flex-1">
            <div className="py-4">
              <AccountDetails instance={instance} />
            </div>
            <div className="">
              <Arts />
            </div>
          </div>
          <div className="py-4">
            <OtherUsers />
          </div>
        </div>
      ) : (
        <div className="bg-orange-600 rounded-md">
          <span className="font-bold px-2 text-2xl">
            {" "}
            Connect MetaMask to explore
          </span>
          <span>
            <Logo alt />
          </span>
        </div>
      )}
    </>
  );
};

export default Dashboard;
