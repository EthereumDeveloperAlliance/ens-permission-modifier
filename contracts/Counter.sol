pragma solidity ^0.5.15;

import './Permission.sol';

contract Counter is Permission {
    string  public domain;
    uint256 public counter = 0;

    constructor(string memory _domain) public {
        domain = _domain;
    }

    function increaseCounter(
        string memory _sub
    ) public isPermissioned(_sub, domain) {
        counter += 1;
    }

    function destroy() public {
        selfdestruct(msg.sender);
    }
}
