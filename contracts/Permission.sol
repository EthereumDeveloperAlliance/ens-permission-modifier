pragma solidity ^0.5.15;

interface ENSMinimal {
    function owner(bytes32 node) external view returns (address);
}

contract Permission {
    address public ENS = address(0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e);
    ENSMinimal private registry = ENSMinimal(ENS);

    modifier isPermissioned(
        string memory _sub,
        string memory _domain
    ) {
        require(registry.owner(computeSubNamehash(_sub, _domain)) == msg.sender, 'Unauthorized to complete transaction.' );
        _;
    }
    
    function computeSubNamehash(string memory _sub, string memory _domain) public pure returns (bytes32 namehash) {
        namehash = 0x0000000000000000000000000000000000000000000000000000000000000000;
        namehash = keccak256(
            abi.encodePacked(namehash, keccak256(abi.encodePacked('eth')))
        );
        namehash = keccak256(
            abi.encodePacked(namehash, keccak256(abi.encodePacked(_domain)))
        );
        namehash = keccak256(
            abi.encodePacked(namehash, keccak256(abi.encodePacked(_sub)))
        );
    }

}
