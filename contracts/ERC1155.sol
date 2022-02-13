// SPDX-License-Identifier: MIT
pragma solidity 0.7.3;

contract ERC1155 {
    // Mapping from TokenId to account balances
    mapping(uint256 => mapping(address => uint256)) internal _balances;

    // gets the balance of an accounts tokens
    function balanceOf(address account, uint256 tokenId)
        public
        view
        returns (uint256)
    {
        require(account != address(0), "account cannot be the zero address");

        return _balances[tokenId][account];
    }
}
