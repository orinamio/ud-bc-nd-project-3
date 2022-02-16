// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// Provides basic authorization control
contract Ownable {
    address private origOwner;

    // Define an Event
    event TransferOwnership(address indexed oldOwner, address indexed newOwner);

    /// Assign the contract to an owner
    constructor () {
        origOwner = msg.sender;
        emit TransferOwnership(address(0), origOwner);
    }

    /// Define a function modifier 'onlyOwner'
    modifier onlyContractOwner() {
        require(msg.sender == origOwner);
        _;
    }

    /// Define a function to renounce ownerhip
    function renounceOwnership() public onlyContractOwner {
        emit TransferOwnership(origOwner, address(0));
        origOwner = address(0);
    }

    /// Define a public function to transfer ownership
    function transferOwnership(address newOwner) public onlyContractOwner {
        _transferOwnership(newOwner);
    }

    /// Define an internal function to transfer ownership
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0));
        emit TransferOwnership(origOwner, newOwner);
        origOwner = newOwner;
    }
}
