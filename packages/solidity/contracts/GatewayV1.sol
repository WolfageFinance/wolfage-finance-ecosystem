pragma solidity ^0.6.2;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";

contract GatewayV1 is AccessControl, Pausable {
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    uint256 public constant version = 1;

    constructor(address admin) public {
        _setupRole(DEFAULT_ADMIN_ROLE, admin);
        _setupRole(PAUSER_ROLE, admin);
    }

    function pause() public virtual {
        require(
            hasRole(PAUSER_ROLE, _msgSender()),
            "GatewayV1: must have pauser role to pause"
        );
        _pause();
    }

    function unpause() public virtual {
        require(
            hasRole(PAUSER_ROLE, _msgSender()),
            "GatewayV1: must have pauser role to unpause"
        );
        _unpause();
    }
}
