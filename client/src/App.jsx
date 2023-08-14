// import { useEtherContext } from './contexts/etherContext';

import { Route, BrowserRouter as Router, Routes } from "react-router-dom";
import Layout from "./components/Layout";
import Dashboard from "./components/pages/Dashboard";

const App = () => {
  // const {instance} = useEtherContext();

  // console.log(instance);

  return (
    <Layout>
      <Router>
        <Routes>
          <Route path="/" element="" />
          <Route path="/dashboard" element={<Dashboard />} />
        </Routes>
      </Router>
    </Layout>
  );
};

export default App;
