pragma solidity ^0.6.2;

contract GatewayRegistry {
    event GatewayRegistered(address indexed owner, address indexed gateway);

    function register(address owner, address gateway) public {
        // Add gateway registration implementation
        emit GatewayRegistered(owner, gateway);
    }
}
