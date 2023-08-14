import Logo from "./ui/Logo";

const Footer = () => {
  return (
    <>
      <div className="bg-zinc-800/25 py-12 mt-4">
        <footer className="container mx-auto px-1">
          <div className="grid lg:grid-cols-3 md:grid-cols-2">
            <div className="brand-details">
              <Logo />
              <p className="text-zinc-400 px-2">
                Lorem ipsum, dolor sit amet consectetur adipisicing elit. Sunt,
                sit!
              </p>
            </div>
            <div className="author-details justify-self-center">
              <h3>
                Developed by <span>@shz-code</span>
              </h3>
              <p>Social links...</p>
            </div>
            <div className="tech-details  justify-self-end">
              Tech used
              <p>ethereum, sepolia testnet</p>
            </div>
          </div>
        </footer>
      </div>
    </>
  );
};

export default Footer;
