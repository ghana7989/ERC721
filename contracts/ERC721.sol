// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract ERC721 {
    // event Transfer
    // event Approval
    // event ApprovalForAll

    mapping(address => uint256) internal _balances;
    mapping(uint256 => address) _owners;

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
}
