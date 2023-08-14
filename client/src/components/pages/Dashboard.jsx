import { useEtherContext } from "../../contexts/etherContext";
import AccountDetails from "../AccountDetails";
import Arts from "../Arts";
import OtherUsers from "../OtherUsers";

const Dashboard = () => {
  const { instance } = useEtherContext();
  return (
    <>
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
    </>
  );
};

export default Dashboard;
