import { Link } from "react-router-dom";

// eslint-disable-next-line react/prop-types
const Logo = ({ alt }) => {
  return (
    <Link
      to="/"
      className={`logo text-2xl ${
        !alt && "text-purple-500"
      } font-bold hover:bg-gradient-to-r hover:from-indigo-800 hover:to-indigo-600  hover:text-white rounded-md p-2 pb-3 inline-block`}
    >
      Artx
    </Link>
  );
};

export default Logo;
