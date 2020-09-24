pragma solidity ^0.6.2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./EnhancedAddress.sol";

contract ContractRegistry is Ownable {
    using EnhancedAddress for address;

    mapping(uint256 => address) private _addresses;

    mapping(uint256 => bool) private _states;

    event ContractRegistered(
        uint256 id,
        address indexed from,
        address indexed to
    );

    event ContractEnabled(uint256 id);

    event ContractDisabled(uint256 id);

    constructor(address admin) public {
        transferOwnership(admin);
    }

    function register(uint256 id, address protocol) external onlyOwner {
        require(protocol.isContract(), "ContractRegistry: not a contract");
        address oldProtocol = _addresses[id];
        _addresses[id] = protocol;
        emit ContractRegistered(id, oldProtocol, protocol);
    }

    function remove(uint256 id) external onlyOwner {
        require(
            _addresses[id] != address(0),
            "ContractRegistry: registry does not exist"
        );
        address oldProtocol = _addresses[id];
        _addresses[id] = address(0);
        emit ContractRegistered(id, oldProtocol, address(0));
    }

    function enable(uint256 id) external onlyOwner {
        require(
            _addresses[id] != address(0),
            "ContractRegistry: registry does not exist"
        );
        _states[id] = true;
        emit ContractEnabled(id);
    }

    function disable(uint256 id) external onlyOwner {
        require(
            _addresses[id] != address(0),
            "ContractRegistry: registry does not exist"
        );
        _states[id] = true;
        emit ContractDisabled(id);
    }

    function get(uint256 id) external view returns (address) {
        return _addresses[id];
    }

    function check(uint256 id) external view returns (bool) {
        return _states[id];
    }

    function check(uint256[] calldata ids) external view returns (bool) {
        for (uint256 i = 0; i < ids.length; i++) {
            if (!_states[ids[i]]) {
                return false;
            }
        }
        return true;
    }
}
