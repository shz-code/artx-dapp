import Navbar from "./Navbar";

// eslint-disable-next-line react/prop-types
const Layout = ({ children }) => {
  return (
    <div className="container mx-auto px-1">
      <Navbar />
      {children}
    </div>
  );
};

export default Layout;
