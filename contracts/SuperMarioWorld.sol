// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./ERC721.sol";

contract SuperMarioWorld is ERC721 {
    string public name; //ERC721MetaData
    string public symbol;
    uint256 public tokenCount;
    mapping(uint256 => string) private _tokenURIs;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
        tokenCount = 0;
    }

    // Returns an URL that points to the metadata of the given token
    function tokenURI(uint256 _tokenId) public view returns (string memory) {
        require(_owners[_tokenId] == address(0), "Token does not exist");
        return _tokenURIs[_tokenId];
    }

    // Creates a new NFT inside our collection
    function mint(string memory _tokenURI) public {
        tokenCount++; // tokenId
        _balances[msg.sender] += 1;
        _owners[tokenCount] = msg.sender;
        _tokenURIs[tokenCount] = _tokenURI;

        emit Transfer(address(0), msg.sender, tokenCount);
    }

    function supportsInterface(bytes4 _interfaceID)
        public
        pure
        override
        returns (bool)
    {
        return _interfaceID == 0x80ac58cd || _interfaceID == 0x525e139f;
    }
}
