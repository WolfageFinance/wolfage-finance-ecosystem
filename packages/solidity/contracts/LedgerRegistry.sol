pragma solidity ^0.6.2;

contract LedgerRegistry {
    event LedgerRegistered(address indexed owner, address indexed ledger);

    function register(address owner, address ledger) public {
        // Add ledger registration implementation
        emit LedgerRegistered(owner, ledger);
    }
}
