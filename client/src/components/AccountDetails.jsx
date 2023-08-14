/* eslint-disable react/prop-types */
import { FileEdit, LogOut } from "lucide-react";
import { useEtherContext } from "../contexts/etherContext";
import { FormatETH } from "../lib/utilities";

const AccountDetails = ({ instance }) => {
  const { account, balance } = instance;
  const { disconnect } = useEtherContext();

  const handleLogout = () => {
    disconnect();
  };
  return (
    <>
      <div className="p-4 bg-zinc-900/75 rounded-lg lg:max-w-[550px] w-full">
        <div className="account-header flex justify-between items-center">
          <h1 className="text-3xl font-bold font-mono">Account Information</h1>
          <span
            className="cursor-pointer hover:bg-zinc-800 p-2 rounded-md transition-all ease-in"
            title="Disconnect Wallet"
            onClick={handleLogout}
          >
            <LogOut size={18} />
          </span>
        </div>

        <div className="wallet-details mt-3">
          <div className="flex gap-1 items-center">
            <p>
              Owner name: <span className="text-zinc-400">Default</span>
            </p>
            {/* onClick={} */}
            <span className="cursor-pointer hover:bg-zinc-800 p-2 rounded-md transition-all ease-in">
              <FileEdit color="white" size={18} />
            </span>
          </div>
          <p className="py-1">
            Wallet Address:{" "}
            <span className="text-zinc-400">
              {account ? account : "0x00...."}
            </span>
          </p>
          <p>
            Balance:{" "}
            <span className="text-zinc-400">
              {balance ? FormatETH(balance) : 0.0} ETH
            </span>
          </p>
        </div>
      </div>
    </>
  );
};

export default AccountDetails;
