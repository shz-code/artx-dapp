// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract ARTX {
    /**
     * -------------------------------------------------------------------------------
     *   Contract Structs [Art,User,Transaction]
     * -------------------------------------------------------------------------------
     */
    struct Art {
        uint256 id;
        string uri;
        address creator;
        address currentOwner;
        uint64 price; // In ETH
        bool locked; // Represents purchaseable Art or not [True -> not purchaseable]
        uint256 creationDate;
        uint256 lastTransferDate;
    }

    struct User {
        uint256 id;
        string name;
        address addr;
        uint256 creationDate;
    }

    struct Transaction {
        uint256 id;
        address from;
        address to;
        uint256 artId;
        uint64 price; // In ETH
        string artUri;
        uint256 creationDate;
    }
    /**
     * -------------------------------------------------------------------------------
     *   Contract Variables [user_id,art_id]
     *   Mappings:
     *       users -> All Users
     *       arts -> All Arts
     *       transactions -> All Transcations
     *       userArtsCount -> User Arts Count
     * -------------------------------------------------------------------------------
     */
    uint256 internal user_id;
    uint256 internal art_id;
    uint256 internal trans_id;

    mapping(uint256 => User) internal users;
    mapping(address => bool) internal registered_users;
    mapping(uint256 => Art) internal arts; // All Arts
    mapping(uint256 => Transaction) internal transactions; // All Transactions
    mapping(address => uint256) internal userArtsCount; // User Arts

    /**
     * -------------------------------------------------------------------------------
     *   Contract Functions:
     *       newArt -> Register new Art
     *       newUser -> Register new User
     *       getAllArts -> Get All Arts
     *       getUserArts -> Get User Arts
     *       unlockArt ->
     *       lockArt ->
     * -------------------------------------------------------------------------------
     */

    /**
     *   @dev Upload new Art.
     *        Only registered users are allowed to upload
     */
    function newArt(
        string memory _uri,
        address _creator,
        uint64 price
    ) public onlyRegisteredUser(_creator) {
        Art memory newArtStruct = Art(
            art_id,
            _uri,
            _creator,
            _creator,
            price * 1e18,
            true,
            block.timestamp,
            block.timestamp
        );
        arts[art_id] = newArtStruct;
        userArtsCount[_creator]++;

        art_id++;
    }

    /**
     *   @dev Register new User.
     */
    function newUser(string memory _name, address _addr) public {
        User memory newUserStruct = User(
            user_id,
            _name,
            _addr,
            block.timestamp
        );
        users[user_id] = newUserStruct;
        registered_users[_addr] = true;

        user_id++;
    }

    /**
     *   @dev Get All Art.
     */
    function getAllArts() public view returns (Art[] memory) {
        uint256 length = getArtsLength();
        Art[] memory allArts = new Art[](length);
        for (uint256 i = 0; i < length; i++) {
            allArts[i] = arts[i];
        }
        return allArts;
    }

    /**
     *   @dev Get User Art.
     *        Filters through the arts mapping and returns all the Arts that matches the currentOwner
     */
    function getUserArts(
        address _addr
    ) public view onlyRegisteredUser(_addr) returns (Art[] memory) {
        uint256 length = getUsersArtsCount(_addr); // Get the number of arts the user currently owns
        Art[] memory allArts = new Art[](length);
        for (uint256 i = 0; i < length; i++) {
            if (arts[i].currentOwner == _addr) {
                allArts[i] = arts[i];
            }
        }
        return allArts;
    }

    /**
     *   @dev Functions/unlockArt -> Unlockes the Art for transferable
     *   @param _artId(art id), _addr(user address), _userId(user id)
     *   @return bool T
     */
    function unlockArt(
        uint256 _artId,
        address _addr
    )
        public
        onlyRegisteredUser(_addr)
        onlyArtOwner(_artId, _addr)
        returns (bool)
    {
        arts[_artId].locked = false;
        return true;
    }

    /**
     *   @dev Functions/lockArt -> lockes the Art for transferable
     *   @param _artId(art id), _addr(user address), _userId(user id)
     *   @return bool T
     */
    function lockArt(
        uint256 _artId,
        address _addr
    )
        public
        onlyRegisteredUser(_addr)
        onlyArtOwner(_artId, _addr)
        returns (bool)
    {
        arts[_artId].locked = true;
        return true;
    }

    /**
     *   @dev Functions/transferArt -> transfers the Art to new owner
     *   @param _artId(art id), _addr(new owner address), _userId(new owner id)
     */
    function transferArt(
        uint256 _artId,
        address _addr
    ) public payable onlyRegisteredUser(_addr) onlyValidArt(_artId) {
        require(
            arts[_artId].price == msg.value,
            "The transfered fund does not match Art price"
        );

        // Pay the owner
        payable(arts[_artId].currentOwner).transfer(msg.value);

        // Create new transaction record
        Transaction memory newTransactionStruct = Transaction(
            trans_id,
            arts[_artId].currentOwner,
            _addr,
            _artId,
            arts[_artId].price,
            arts[_artId].uri,
            block.timestamp
        );
        transactions[trans_id] = newTransactionStruct;
        trans_id++;

        // Update new owner info
        arts[_artId].currentOwner = _addr;
        arts[_artId].price = arts[_artId].price + 5;
        arts[_artId].lastTransferDate = block.timestamp;
        arts[_artId].locked = true;

        userArtsCount[arts[_artId].currentOwner]--;
        userArtsCount[_addr]++;
    }

    /**
     * -------------------------------------------------------------------------------
     *   Contract Modifiers:
     *       onlyRegisteredUser -> Only registered users accessible
     *       onlyArtOwner -> Only Art owner accessible
     *       onlyValidArt ->
     * -------------------------------------------------------------------------------
     */

    /**
     *   @dev Modifier/onlyRegisteredUser -> Only Registered User on the platform can access
     */
    modifier onlyRegisteredUser(address _addr) {
        require(registered_users[_addr] == true, "User Must be Registered");
        _;
    }
    /**
     *   @dev Modifier/onlyArtOwner -> Only valid Art owner can access
     */
    modifier onlyArtOwner(uint256 _artId, address _addr) {
        require(arts[_artId].creator != address(0), "Art doesn't exists");
        require(
            arts[_artId].currentOwner == _addr,
            "User not the current owner of Art"
        );
        _;
    }
    /**
     *   @dev Modifier/onlyValidArt -> Only Valid Art can be accessed and transfered
     */
    modifier onlyValidArt(uint256 _artId) {
        require(arts[_artId].creator != address(0), "Art doesn't exists");
        require(
            arts[_artId].locked == false,
            "Art is not available for purchase"
        );
        _;
    }

    /**
     * -------------------------------------------------------------------------------
     *   Contract Utilities:
     *       getArtsLength -> Returns arts mapping length
     *       getUsersLength -> Returns users mapping length
     *       getUsersArtsCount -> Reutrns user owned Art count
     * -------------------------------------------------------------------------------
     */

    /**
     *   @dev Return (arts mapping length == art_id).
     */
    function getArtsLength() internal view returns (uint256) {
        return art_id;
    }

    /**
     *   @dev Return (users mapping length == user_id).
     */
    function getUsersLength() internal view returns (uint256) {
        return user_id;
    }

    /**
     *   @dev Returns Number of Arts User Currenttly Own.
     */
    function getUsersArtsCount(address _addr) internal view returns (uint256) {
        return userArtsCount[_addr];
    }
}
