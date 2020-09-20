pragma solidity ^0.6.2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract ProtocolRegistry is Ownable {
    using Address for address;

    mapping(uint256 => address) public protocols;

    event ProtocolRegistered(
        uint256 id,
        address indexed from,
        address indexed to
    );

    constructor(address newOwner) public {
        transferOwnership(newOwner);
    }

    function register(uint256 id, address protocol) external onlyOwner {
        require(protocol.isContract(), "ProtocolRegistry: not a contract");
        address oldProtocol = protocols[id];
        protocols[id] = protocol;
        emit ProtocolRegistered(id, oldProtocol, protocol);
    }
}
