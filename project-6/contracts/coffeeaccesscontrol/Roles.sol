// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Roles
 * @dev Library for managing addresses assigned to a Role.
 */
library Roles {
    struct Role {
        mapping(address => bool) bearer;
    }

    modifier notEmptyAccount(address account) {
        require(account != address(0));
        _;
    }

    /**
     * @dev give an account access to this role
     */
    function add(Role storage role, address account)
        internal
        notEmptyAccount(account)
    {
        require(!has(role, account));
        role.bearer[account] = true;
    }

    /**
     * @dev remove an account's access to this role
     */
    function remove(Role storage role, address account)
        internal
        notEmptyAccount(account)
    {
        require(has(role, account));
        role.bearer[account] = false;
    }

    /**
     * @dev check if an account has this role
     * @return bool
     */
    function has(Role storage role, address account)
        internal
        view
        notEmptyAccount(account)
        returns (bool)
    {
        return role.bearer[account];
    }
}
