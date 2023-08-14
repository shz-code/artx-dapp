import { Link as LinkIcon } from "lucide-react";
import { Link } from "react-router-dom";

// eslint-disable-next-line react/prop-types
const User = ({ user }) => {
  return (
    <>
      <div className="bg-zinc-800/25 p-2 px-4 rounded-md hover:bg-zinc-800/75 cursor-pointer">
        <p className="flex gap-2 items-center">
          <LinkIcon color="white" size={20} />
          <Link to="/" className="text-zinc-400">
            {user} Lorem ipsum dolor sit amet.
          </Link>
        </p>
      </div>
    </>
  );
};

export default User;
