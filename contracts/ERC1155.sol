// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract ERC1155 {
    // Events
    event ApprovalForAll(
        address indexed owner,
        address indexed operator,
        bool approved
    );

    event TransferSingle(
        address indexed _operator,
        address indexed _from,
        address indexed _to,
        uint256 tokenId,
        uint256 amount
    );
    event TransferBatch(
        address indexed _operator,
        address indexed _from,
        address indexed _to,
        uint256[] ids,
        uint256[] values
    );

    // State Variables

    // Mapping from TokenId to account balances
    mapping(uint256 => mapping(address => uint256)) internal _balances;

    // Operators Approvals
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    // gets the balance of an accounts tokens
    // one owner can have multiple tokens so...
    function balanceOf(address account, uint256 tokenId)
        public
        view
        returns (uint256)
    {
        require(account != address(0), "account cannot be the zero address");

        return _balances[tokenId][account];
    }

    function balanceOfBatch(address[] memory accounts, uint256[] memory ids)
        public
        view
        returns (uint256[] memory)
    {
        require(
            accounts.length == ids.length,
            "accounts and ids must have the same length"
        );

        uint256[] memory batchBalances = new uint256[](accounts.length);

        for (uint256 index = 0; index < batchBalances.length; index++) {
            batchBalances[index] = balanceOf(accounts[index], ids[index]);
        }

        return batchBalances;
    }

    // Checks if an address is an operator for another address
    function isApprovedForAll(address _owner, address _operator)
        public
        view
        returns (bool)
    {
        require(_owner != address(0), "owner cannot be the zero address");
        require(_operator != address(0), "operator cannot be the zero address");
        return _operatorApprovals[_owner][_operator];
    }

    // Enables or disables an operator to manage all of msg.sender's assets
    function setApprovalForAll(address _operator, bool _approved) public {
        require(_operator != address(0), "operator cannot be the zero address");
        require(msg.sender == _operator, "msg.sender must be the operator");

        _operatorApprovals[msg.sender][_operator] = _approved;

        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    function transfer(
        address _from,
        address _to,
        uint256 _id, // a person can have multiple copies of NFT's
        uint256 _amount
    ) private {
        uint256 fromBalance = _balances[_id][_from];
        require(fromBalance >= _amount, "not enough balance");

        _balances[_id][_from] = fromBalance - _amount;
        _balances[_id][_to] += _amount;
    }

    // Oversimplified
    function _checkOnERC1155Received() private pure returns (bool) {
        return true;
    }

    // This is function will make sure that ERC1155 is implemented or not
    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _id,
        uint256 _amount,
        bytes memory _data
    ) public {
        require(
            _from == msg.sender || isApprovedForAll(_from, msg.sender),
            "msg.sender must be approved for all assets or msg.sender is not owner"
        );
        require(_to != address(0), "to address cannot be the zero address");

        transfer(_from, _to, _id, _amount);
        emit TransferSingle(msg.sender, _from, _to, _id, _amount);
        require(
            _checkOnERC1155Received(),
            "ERC1155's Receiver not implemented"
        );
    }

    function _checkOnBatchERC1155Received() private pure returns (bool) {
        return true;
    }

    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public {
        require(
            ids.length == amounts.length,
            "ids and amounts must have the same length"
        );
        require(
            from == msg.sender || isApprovedForAll(from, msg.sender),
            "msg.sender must be approved for all assets or msg.sender is not owner"
        );
        require(to != address(0), "to address cannot be the zero address");

        for (uint256 index = 0; index < ids.length; index++) {
            transfer(from, to, ids[index], amounts[index]);
        }
        emit TransferBatch(msg.sender, from, to, ids, amounts);
        require(
            _checkOnBatchERC1155Received(),
            "ERC1155's Receiver not implemented"
        );
    }

    // ERC165 Complaint
    // Tell everyone that we support the ERC1155 functions
    // interfaceId == 0xd9b67a26
    // opensea actually checks for this function
    function supportsInterface(bytes4 interfaceId)
        public
        pure
        virtual
        returns (bool)
    {
        return interfaceId == 0xd9b67a26;
    }
}
