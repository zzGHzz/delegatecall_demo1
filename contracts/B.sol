// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 < 0.8.0;

contract B {
    uint val;

    address delegate;

    constructor(address _delegate) {
        delegate = _delegate;
    }

    fallback() external {
        assembly {
            let target := sload(delegate.slot)
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), target, 0, calldatasize(), 0, 0)            
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 {revert(0, returndatasize())}
            default {return (0, returndatasize())}
        }
    }
}