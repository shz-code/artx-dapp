const Dashboard = () => {
  return (
    <>
      <div className="flex justify-between">
        <div className="bg-red-400 flex-1">
          <div className="py-4">account details</div>
          <div className="bg-green-400">pictures</div>
        </div>
        <div className="md:block bg-sky-400">other users</div>
      </div>
    </>
  );
};

export default Dashboard;
