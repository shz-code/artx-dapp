// import { useEtherContext } from './contexts/etherContext';

import { Route, BrowserRouter as Router, Routes } from "react-router-dom";
import Layout from "./components/Layout";
import Dashboard from "./components/pages/Dashboard";

const App = () => {
  // const {instance} = useEtherContext();

  // console.log(instance);

  return (
    <Router>
      <Layout>
        <Routes>
          <Route path="/" element="" />
          <Route path="/dashboard" element={<Dashboard />} />
        </Routes>
      </Layout>
    </Router>
  );
};

export default App;
