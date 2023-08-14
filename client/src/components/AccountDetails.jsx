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
      <div className="xl:flex justify-between lg:pe-2 items-end">
        <div className="p-4 bg-zinc-900/75 rounded-md lg:max-w-[550px] w-full">
          <div className="account-header flex justify-between items-center">
            <h1 className="text-3xl font-bold font-mono">
              Account Information
            </h1>
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
        <div className="upload-artx lg:max-w-[350px] w-full mt-2">
          <div className="bg-gradient-to-r from-orange-600 to-orange-400 rounded-md p-4">
            <h1 className="text-3xl font-bold font-mono">
              Upload Your <br />
              Artx
            </h1>
            <form className="flex items-center py-3">
              <input
                className="w-full text-sm text-zinc-400 rounded-md cursor-pointer bg-zinc-800 focus:ring-1 focus:ring-white "
                id="file_input"
                type="file"
              />
            </form>
          </div>
        </div>
      </div>
    </>
  );
};

export default AccountDetails;
