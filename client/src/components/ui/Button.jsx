// eslint-disable-next-line react/prop-types
const Button = ({ children, rest }) => {
  return (
    <button
      className="bg-orange-600 px-4 py-2 rounded-md text-lg font-bold font-mono cursor-pointer hover:bg-orange-700 transition-all ease-in-out focus:ring-2 focus:ring-white active:scale-95"
      {...rest}
    >
      {children}
    </button>
  );
};

export default Button;
