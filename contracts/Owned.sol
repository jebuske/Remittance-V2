pragma solidity ^0.4.18;

contract Owned {
  address private owner;

  event logOwnerChange(address indexed oldOwner, address indexed newOwner);

  function Owned() public {
    owner = msg.sender;
  }

  modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }

  function getOwner() public view returns (address) {
    return owner;
  }

  function changeOwner(address newOwner) public onlyOwner {
    require(newOwner != address(0));

    logOwnerChange(owner, newOwner);
    owner = newOwner;
  }
}
