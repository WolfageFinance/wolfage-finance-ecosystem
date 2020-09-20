pragma solidity ^0.6.2;

import "@openzeppelin/contracts/utils/Pausable.sol";

contract Ledger is Pausable {
    event EtherReceived(address indexed from, uint256 value);

    receive() external payable {
        emit EtherReceived(msg.sender, msg.value);
    }
}
