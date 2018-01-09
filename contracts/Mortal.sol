pragma solidity ^0.4.18;

import "./Owned.sol";

contract Mortal is Owned {
  event logContractKilled;

  function kill() public onlyOwner {
    logContractKilled();
    selfdestruct(getOwner());
  }
}