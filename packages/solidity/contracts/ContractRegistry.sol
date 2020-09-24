pragma solidity ^0.6.2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./EnhancedAddress.sol";

contract ContractRegistry is Ownable {
    using EnhancedAddress for address;

    mapping(uint256 => address) public protocols;

    event ProtocolRegistered(
        uint256 id,
        address indexed from,
        address indexed to
    );

    constructor(address admin) public {
        transferOwnership(admin);
    }

    function register(uint256 id, address protocol) external onlyOwner {
        require(protocol.isContract(), "ContractRegistry: not a contract");
        address oldProtocol = protocols[id];
        protocols[id] = protocol;
        emit ProtocolRegistered(id, oldProtocol, protocol);
    }
}
