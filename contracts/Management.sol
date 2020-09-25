// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 < 0.8.0;

import "./Object.sol";

contract Management {
    address delegate;
    address[] instances;

    constructor(address _delegate) {
        delegate = _delegate;
    }

    function newObject() external {
        Object obj = new Object(delegate);
        instances.push(address(obj));

        emit NewObject(msg.sender, instances.length-1, address(obj));
    }

    function set(uint i, uint val) external {
        (bool success, bytes memory result) 
            = instances[i].call(abi.encodeWithSignature("set(uint256)", val));
        require(success, "delegatecall set(uint256) failed");
    }

    function get(uint i) external returns(uint) {
        (bool success, bytes memory result) 
            = instances[i].call(abi.encodeWithSignature("get()"));
        require(success, "delegatecall get() failed");

        return abi.decode(result, (uint));
    }

    event NewObject(address from, uint index, address inst);
}