import Footer from "./Footer";
import Navbar from "./Navbar";

// eslint-disable-next-line react/prop-types
const Layout = ({ children }) => {
  return (
    <div>
      <Navbar />
      <div className="container mx-auto px-1">{children}</div>
      <Footer />
    </div>
  );
};

export default Layout;
