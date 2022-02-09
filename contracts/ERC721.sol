// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract ERC721 {
    event Transfer(address indexed from, address indexed to, uint256 tokenId);
    event Approval(
        address indexed owner,
        address indexed approved,
        uint256 tokenId
    );
    event ApprovalForAll(
        address indexed owner,
        address indexed spender,
        bool isApproved
    );

    mapping(address => uint256) internal _balances;
    mapping(uint256 => address) _owners;
    mapping(address => mapping(address => bool)) private _operatorApprovals;
    mapping(uint256 => address) private _tokenApprovals;

    // Returns the number of NFT's assigned to the owner
    function balanceOf(address _owner) public view returns (uint256) {
        require(_owner != address(0), "Can not be an empty address");
        return _balances[_owner];
    }

    // Finds the owner of the NFT
    function ownerOf(uint256 _tokenId) public view returns (address) {
        address owner = _owners[_tokenId];
        require(owner != address(0), "Token ID does not exist");
        return owner;
    }

    // operator functions
    // Enables or disables an operator to manage all the msg.senders assets.
    function setApprovalForAll(address _operator, bool _isApproved) public {
        _operatorApprovals[msg.sender][_operator] = _isApproved;
        emit ApprovalForAll(msg.sender, _operator, _isApproved);
    }

    // checks if an address is an operator for another address
    function isApprovedForAll(address _owner, address operator)
        public
        view
        returns (bool)
    {
        return _operatorApprovals[_owner][operator];
    }

    // Updates an approved address for an NFT
    function approve(address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(
            owner == msg.sender || isApprovedForAll(owner, msg.sender),
            "Only the owner can approve another address"
        );
        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    // gets the approved address for a single NFT
    function getApproved(uint256 tokenId) public view returns (address) {
        require(_owners[tokenId] != address(0), "Token ID does not exist");
        return _tokenApprovals[tokenId];
    }

    // transfers ownership of an NFT
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public {
        address currentOwner = ownerOf(tokenId);
        require(
            currentOwner == msg.sender ||
                getApproved(tokenId) == msg.sender ||
                isApprovedForAll(currentOwner, msg.sender),
            "The sender must be the current owner or approved to transfer"
        );
        require(currentOwner == from, "From address is not the owner");
        require(to != address(0), "To address cannot be the zero address");
        require(_owners[tokenId] != address(0), "Token ID does not exist");
        // clear out previous current owner approvals
        approve(address(0), tokenId);

        // Updating respective balances
        _balances[currentOwner] -= 1;
        _balances[to] += 1;

        _owners[tokenId] = to;
        emit Transfer(from, to, tokenId);
    }

    // Checks if onERC721Received is implemented WHEN sending to smart contracts
    // to check if other smart contract is capable of accepting NFTs
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) public {
        transferFrom(from, to, tokenId);
        require(_checkOnERC721Received(), "Receiver Not Implemented");
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public {
        safeTransferFrom(from, to, tokenId, "");
    }

    // Oversimplified
    function _checkOnERC721Received() private pure returns (bool) {
        return true;
    }

    // EIP165 : Query if a contract implements another interface
    // opensea also checks for this function
    function supportsInterface(bytes4 interfaceId)
        public
        pure
        virtual
        returns (bool)
    {
        return interfaceId == 0x80ac58cd;
    }
}
