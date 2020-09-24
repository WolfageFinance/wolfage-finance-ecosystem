pragma solidity ^0.6.2;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "./ContractRegistry.sol";
import "./EnhancedAddress.sol";

contract GatewayV1 is AccessControl, Pausable {
    using EnhancedAddress for address;

    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    uint256 public constant version = 1;

    ContractRegistry private _registry;

    event GatewayRequest(address indexed sender);

    constructor(address admin, address registry) public {
        _registry = ContractRegistry(registry);
        _setupRole(DEFAULT_ADMIN_ROLE, admin);
        _setupRole(PAUSER_ROLE, admin);
    }

    function pause() external whenNotPaused {
        require(
            hasRole(PAUSER_ROLE, _msgSender()),
            "GatewayV1: must have pauser role to pause"
        );
        _pause();
    }

    function unpause() external whenPaused {
        require(
            hasRole(PAUSER_ROLE, _msgSender()),
            "GatewayV1: must have pauser role to unpause"
        );
        _unpause();
    }

    function sendRequest(uint256[] calldata ids, bytes[] calldata data)
        external
        payable
        whenNotPaused
    {
        require(
            ids.length == data.length,
            "GatewayV1: ids, data length mismatch"
        );
        require(_registry.check(ids), "GatewayV1: IDs invalid");
        for (uint256 i = 0; i < ids.length; i++) {
            _registry.get(ids[i]).delegateCall(data[i]);
        }
        emit GatewayRequest(_msgSender());
    }
}
