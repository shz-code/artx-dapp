/**
 *   @author Shahidul Alam
 *   @title Artx
 *   @description Contract for Artx platform
 *   @tags solidity, ethereum, asset transfer, digital asset buy/sell
 *   @version v0.8.0 (Testing)
 */

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
        uint256 price; // In ETH
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
        uint256 price; // In ETH
        string artUri;
        uint256 creationDate;
    }
    /**
     * -------------------------------------------------------------------------------
     *   Contract Variables:
     *       owner -> Contract owner
     *       user_id -> Latest registered user id
     *       art_id -> Latest uploaded art id
     *       trans_id -> Latest occurred transaction id
     *   Mappings:
     *       users -> All Users
     *       registered_users -> Checks for registered user using address
     *       arts -> All Arts
     *       userArtsCount -> User Arts Count
     *       transactions -> All Transactions
     * -------------------------------------------------------------------------------
     */
    address public owner;
    uint256 internal user_id;
    uint256 internal art_id;
    uint256 internal trans_id;

    mapping(uint256 => User) internal users;
    mapping(address => bool) internal registered_users;
    mapping(uint256 => Art) internal arts; // All Arts
    mapping(uint256 => Transaction) internal transactions; // All Transactions
    mapping(address => uint256) internal userArtsCount; // User Arts
    mapping(address => uint256) internal userTransactionCount; // User Transactions

    /**
     * -------------------------------------------------------------------------------
     *   Contract Constructor:
     * -------------------------------------------------------------------------------
     */

    constructor() {
        owner = _msgSender();
    }

    /**
     * -------------------------------------------------------------------------------
     *   Contract Functions:
     *       Art:
     *          newArt -> Register new Art
     *          getAllArts -> Get All Arts
     *          getArt -> Get Specific Art
     *          unlockArt -> Unlocks the Art for transferable
     *          lockArt -> Locks the Art so that is is not transferable
     *       User:
     *          newUser -> Register new User
     *          getAllUsers -> Get all Users
     *          getUserArts -> Get User Arts
     *          getUser -> Get specific user
     *          updateUserName -> Update user name
     *       Transaction:
     *          getAllTransactions -> Get all transactions
     *          getUserTransactions-> Get all user transactions
     *          getTransaction -> Get desired transaction
     *          transferArt -> Transfer Art from one user to another
     *
     * -------------------------------------------------------------------------------
     */

    // ==================================ART==========================================
    /**
     *   @dev Function/newArt -> Upload new Art. Only registered users are allowed to upload
     *   @param _uri hash of art uploaded to pinata(IPFS), @param _price Art price in ETH
     */
    function newArt(
        string memory _uri,
        uint256 _price
    ) public onlyRegisteredUser(_msgSender()) {
        Art memory newArtStruct = Art(
            art_id,
            _uri,
            _msgSender(),
            _msgSender(),
            _price * 1e18,
            true,
            block.timestamp,
            block.timestamp
        );
        arts[art_id] = newArtStruct;
        userArtsCount[_msgSender()]++;

        art_id++;
    }

    /**
     *   @dev Function/getAllArts -> Get All Art.
     *   @return All Arts
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
     *   @dev Function/getArt -> Get Specific Art.
     *   @param _artId Art id of desired Art
     *   @return Desired Aty
     */
    function getArt(
        uint256 _artId
    ) public view onlyValidArt(_artId) returns (Art memory) {
        Art memory art = arts[_artId];
        return art;
    }

    /**
     *   @dev Functions/unlockArt -> Unlocks the Art for transferable
     *   @param _artId(art id)
     */
    function unlockArt(
        uint256 _artId
    )
        public
        onlyRegisteredUser(_msgSender())
        onlyArtOwner(_artId, _msgSender())
    {
        arts[_artId].locked = false;
    }

    /**
     *   @dev Functions/lockArt -> locks the Art so that is is not transferable
     *   @param _artId(art id)
     */
    function lockArt(
        uint256 _artId
    )
        public
        onlyRegisteredUser(_msgSender())
        onlyArtOwner(_artId, _msgSender())
    {
        arts[_artId].locked = true;
    }

    // ==================================USER=========================================

    /**
     *   @dev Function/newUser -> Register new User.
     *   @param _name Name of user
     */
    function newUser(
        string memory _name
    ) public onlyAnonymousUser(_msgSender()) {
        User memory newUserStruct = User(
            user_id,
            _name,
            _msgSender(),
            block.timestamp
        );
        users[user_id] = newUserStruct;
        registered_users[_msgSender()] = true;

        user_id++;
    }

    /**
     *   @dev Function/getAllUsers -> Get All Users.
     *   @return All Users
     */
    function getAllUsers() public view returns (User[] memory) {
        uint256 length = getUsersLength();
        User[] memory allUsers = new User[](length);
        for (uint256 i = 0; i < length; i++) {
            allUsers[i] = users[i];
        }
        return allUsers;
    }

    /**
     *   @dev Function/getUserArts -> Get User Art. Filters through the arts mapping and returns all the Arts that matches the currentOwner
     *   @param _addr User id of whom Arts will be fetched
     *   @return User Arts
     */
    function getUserArts(
        address _addr
    ) public view onlyRegisteredUser(_addr) returns (Art[] memory) {
        uint256 userOwnedLength = getUsersArtsCount(_addr); // Get the number of arts the user currently owns
        uint256 length = getArtsLength(); // Get total number of Arts
        Art[] memory allArts = new Art[](userOwnedLength);

        uint256 index = 0;

        for (uint256 i = 0; i < length; i++) {
            if (arts[i].currentOwner == _addr) {
                allArts[index] = arts[i];
                index++;
            }
        }
        return allArts;
    }

    /**
     *   @dev Function/getUser -> Get Specific User.
     *   @param _userId User id of whom info will be fetched
     *   @return User info
     */
    function getUser(
        uint256 _userId
    ) public view onlyValidUser(_userId) returns (User memory) {
        User memory user = users[_userId];
        return user;
    }

    /**
     *   @dev Function/updateUserName -> Update name of user if he is the owner
     *   @param _userId User id of whom name will be updated. @param _newName New name of user
     */
    function updateUserName(
        uint256 _userId,
        string memory _newName
    ) public onlyAccountOwner(_userId) {
        users[_userId].name = _newName;
    }

    // ==================================Transaction======================================

    /**
     *   @dev Functions/getAllTransactions -> Get All Transactions.
     *   @return All Transactions
     */
    function getAllTransactions() public view returns (Transaction[] memory) {
        uint256 length = getTransactionsLength();
        Transaction[] memory allTransactions = new Transaction[](length);
        for (uint256 i = 0; i < length; i++) {
            allTransactions[i] = transactions[i];
        }
        return allTransactions;
    }

    /**
     *   @dev Functions/getUserTransactions -> Get User Transactions. Filters through the transactions mapping and returns all the Transactions that matches the from or to
     *   @param _addr User address
     *   @return All User Transactions that the user was involved
     */
    function getUserTransactions(
        address _addr
    ) public view onlyRegisteredUser(_addr) returns (Transaction[] memory) {
        uint256 userTransLength = getUserTransactionsLength(_addr); // Get the number of transactions the user currently has
        uint256 length = getTransactionsLength(); // Get total number of Transactions
        Transaction[] memory allTrans = new Transaction[](userTransLength);

        uint256 index = 0;

        for (uint256 i = 0; i < length; i++) {
            if (transactions[i].from == _addr || transactions[i].to == _addr) {
                allTrans[index] = transactions[i];
                index++;
            }
        }
        return allTrans;
    }

    /**
     *   @dev Functions/getTransaction -> Get Specific Transaction.
     *   @param _transId Transaction id
     *   @return Desired Transaction
     */
    function getTransaction(
        uint256 _transId
    ) public view onlyValidTransaction(_transId) returns (Transaction memory) {
        Transaction memory trans = transactions[_transId];
        return trans;
    }

    /**
     *   @dev Functions/transferArt -> transfers the Art to new owner
     *   @param _artId(art id)
     *   @return transaction id of the current transaction
     */
    function transferArt(
        uint256 _artId
    )
        public
        payable
        onlyRegisteredUser(_msgSender())
        onlyValidArt(_artId)
        onlyTransferableArt(_artId, _msgSender())
        returns (uint256)
    {
        require(
            arts[_artId].price == msg.value,
            "The transferred fund does not match Art price"
        );

        // Pay the owner
        payable(arts[_artId].currentOwner).transfer(msg.value);

        // Create new transaction record
        Transaction memory newTransactionStruct = Transaction(
            trans_id,
            arts[_artId].currentOwner,
            _msgSender(),
            _artId,
            arts[_artId].price,
            arts[_artId].uri,
            block.timestamp
        );
        transactions[trans_id] = newTransactionStruct;

        uint256 current_id = trans_id;

        trans_id++;

        // Update new owner info
        userArtsCount[arts[_artId].currentOwner]--;
        userArtsCount[_msgSender()]++;

        arts[_artId].currentOwner = _msgSender();
        arts[_artId].price = arts[_artId].price + 5 * 1e18; // Increase Art price by 5 ETH in every purchase
        arts[_artId].lastTransferDate = block.timestamp;
        arts[_artId].locked = true;

        return current_id;
    }

    /**
     * -------------------------------------------------------------------------------
     *   Contract Modifiers:
     *       onlyAnonymousUser -> Only Valid user can register
     *       onlyRegisteredUser -> Only registered users can access [Check using address]
     *       onlyValidUser -> Only registered users can access [Check using user id]
     *       onlyAccountOwner -> Only user himself can access
     *       onlyValidArt -> Check if Art exists
     *       onlyArtOwner -> Only Art owner accessible
     *       onlyTransferableArt -> Only Valid Art can be accessed and transferred
     *       onlyValidTransaction -> Only valid transaction can be accessed
     * -------------------------------------------------------------------------------
     */

    /**
     *   @dev Modifier/onlyAnonymousUser -> Only Valid user can register
     */
    modifier onlyAnonymousUser(address _addr) {
        require(registered_users[_addr] == false, "User already registered");
        _;
    }

    /**
     *   @dev Modifier/onlyRegisteredUser -> Only Registered User on the platform can access [Check using address]
     */
    modifier onlyRegisteredUser(address _addr) {
        require(registered_users[_addr] == true, "User Must be Registered");
        _;
    }

    /**
     *   @dev Modifier/onlyValidUser -> Only Registered User on the platform can access [Check using id]
     */
    modifier onlyValidUser(uint256 _userId) {
        require(users[_userId].addr != address(0), "User not found");
        _;
    }

    /**
     *   @dev Modifier/onlyAccountOwner -> Only user himself can access
     */
    modifier onlyAccountOwner(uint256 _userId) {
        require(
            users[_userId].addr == _msgSender(),
            "You have no permission to change the credentials"
        );
        _;
    }

    /**
     *   @dev Modifier/onlyValidArt -> Check if Art exists
     */
    modifier onlyValidArt(uint256 _artId) {
        require(arts[_artId].creator != address(0), "Art doesn't exists");
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
     *   @dev Modifier/onlyTransferableArt -> Only Valid Art can be accessed and transferred
     */
    modifier onlyTransferableArt(uint256 _artId, address _addr) {
        require(
            arts[_artId].locked == false,
            "Art is not available for purchase"
        );
        require(
            arts[_artId].currentOwner != _addr,
            "User can not purchase his own Art"
        );
        _;
    }

    /**
     *   @dev Modifier/onlyValidTransaction -> Only valid transaction can be accessed
     */
    modifier onlyValidTransaction(uint256 _transId) {
        require(
            transactions[_transId].from != address(0),
            "Transaction not found"
        );
        _;
    }

    /**
     * -------------------------------------------------------------------------------
     *   Contract Utilities:
     *       _msgSender -> Returns msg sender address
     *       getArtsLength -> Returns arts mapping length
     *       getUsersLength -> Returns users mapping length
     *       getUsersArtsCount -> Returns user owned Art count
     *       getTransactionsLength ->
     *       getUserTransactionsLength ->
     * -------------------------------------------------------------------------------
     */

    /**
     *   @dev Utilities/_msgSender
     *   @return address of msg sender.
     */
    function _msgSender() internal view returns (address) {
        return msg.sender;
    }

    /**
     *   @dev Utilities/getArtsLength
     *   @return (arts mapping length == art_id).
     */
    function getArtsLength() internal view returns (uint256) {
        return art_id;
    }

    /**
     *   @dev Utilities/getUsersLength
     *   @return (users mapping length == user_id).
     */
    function getUsersLength() internal view returns (uint256) {
        return user_id;
    }

    /**
     *   @dev Utilities/getUsersArtsCount
     *   @return user Art count
     */
    function getUsersArtsCount(address _addr) internal view returns (uint256) {
        return userArtsCount[_addr];
    }

    /**
     *   @dev Utilities/getTransactionsLength
     *   @return transaction mapping length
     */
    function getTransactionsLength() internal view returns (uint256) {
        return trans_id;
    }

    /**
     *   @dev Utilities/getUserTransactionsLength
     *   @return user Transaction count
     */
    function getUserTransactionsLength(
        address _addr
    ) internal view returns (uint256) {
        return userTransactionCount[_addr];
    }
}
