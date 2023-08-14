import User from "./User";

const Users = () => {
  const users = ["user1", "user2"];
  return (
    <div className="grid gap-4">
      {users.map((user) => (
        <User user={user} key={user} />
      ))}{" "}
    </div>
  );
};

export default Users;
