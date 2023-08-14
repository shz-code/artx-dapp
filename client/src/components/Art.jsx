import Button from "./ui/Button";

// eslint-disable-next-line react/prop-types
const Art = ({ art }) => {
  return (
    <>
      <div className="art-item rounded-md bg-zinc-800/75 max-h-[800px] h-full">
        <div className="art-item-header">
          <div className="img-container">
            <img src={art} alt="" />
          </div>
        </div>
        <div className="body py-1 px-2 max-w-[250px] max-h-[500px] h-full">
          <h3 className="text-lg font-bold font-serif">Art Bio</h3>
          <hr />
          <div className="mt-2 grid items-center">
            <p>
              Art name: <span className="text-zinc-400">picaso</span>
            </p>
            <p>
              Author: <span className="text-zinc-400">Shanto</span>
            </p>
            <p>
              Price: <span className="text-slate-400">10 ETH</span>
            </p>
            <div className="action-btn my-2">
              <Button>Check Artx</Button>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default Art;
