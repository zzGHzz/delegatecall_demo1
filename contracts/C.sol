// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 < 0.8.0;

contract C {
    uint val;

    function set(uint _val) external {
        val = _val;
    }

    function get() external view returns(uint) {
        return val;
    }
}