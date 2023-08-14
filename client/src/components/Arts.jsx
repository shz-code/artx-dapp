import Art from "./Art";

const Arts = () => {
  const arts = [
    "https://images.unsplash.com/photo-1579783902614-a3fb3927b6a5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=745&q=80",
    "https://images.unsplash.com/photo-1547891654-e66ed7ebb968?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80",
    "https://images.unsplash.com/photo-1561214115-f2f134cc4912?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=709&q=80",
    "https://images.unsplash.com/photo-1515405295579-ba7b45403062?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80",
  ];
  return (
    <>
      <h1 className="text-3xl font-bold font-mono pb-2 mb-2 bg-gradient-to-r from-indigo-600 to-indigo-400 rounded-md px-2 py-2">
        Your Artworks
      </h1>
      <div className="flex flex-wrap gap-5 bg-zinc-900/75 rounded-md p-4">
        {arts.map((art) => (
          <Art art={art} key={art} />
        ))}
      </div>
    </>
  );
};

export default Arts;
