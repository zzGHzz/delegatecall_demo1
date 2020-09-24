// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 < 0.8.0;

import "./B.sol";

contract A {
    address delegate;
    address[] instances;

    constructor(address _delegate) {
        delegate = _delegate;
    }

    function newB() external {
        B b = new B(delegate);
        instances.push(address(b));

        emit NewB(msg.sender, instances.length-1, address(b));
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

    event NewB(address from, uint index, address inst);
}