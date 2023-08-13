import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App.jsx";
import { EtherContextProvider } from "./contexts/etherContext.jsx";
import { MethodsContextProvider } from "./contexts/methodsContext.jsx";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <EtherContextProvider>
      <MethodsContextProvider>
        <App />
      </MethodsContextProvider>
    </EtherContextProvider>
  </React.StrictMode>
);
