import Users from "./Users";

const OtherUsers = () => {
  return (
    <>
      <div className="max-w-[400px] w-full">
        <div className="bg-zinc-900/75 rounded-md p-4">
          <h1 className="text-3xl font-bold font-mono">Other Users</h1>
          <div className="mt-4">
            <Users />
          </div>
        </div>
      </div>
    </>
  );
};

export default OtherUsers;
