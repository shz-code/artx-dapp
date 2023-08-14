import { Link } from "react-router-dom";

const Logo = () => {
  return (
    <Link
      to="/"
      className="logo text-2xl text-purple-500 font-bold bg-gradient-to-r hover:from-indigo-800 hover:to-indigo-600  hover:text-white rounded-md p-2 pb-3 inline-block"
    >
      Artx
    </Link>
  );
};

export default Logo;
