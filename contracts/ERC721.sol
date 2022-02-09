// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract ERC721 {
    // event Transfer
    // event Approval
    // event ApprovalForAll

    mapping(address => uint256) internal _balances;

    // Returns the number of NFT's assigned to the owner
    function balanceOf(address _owner) public view returns (uint256) {
        require(_owner != address(0), "Can not be an empty address");
        return _balances[_owner];
    }
}
