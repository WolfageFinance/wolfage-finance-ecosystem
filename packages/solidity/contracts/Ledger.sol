pragma solidity ^0.6.2;

contract Ledger {
    event EtherReceived(address indexed from, uint256 value);

    receive() external payable {
        emit EtherReceived(msg.sender, msg.value);
    }
}
