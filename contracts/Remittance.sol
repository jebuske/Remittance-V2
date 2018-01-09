pragma solidity ^0.4.18;

import "./Mortal.sol";

contract Remittance is Mortal {

  struct Withdrawal {
    address to;
    uint value;
    uint deadline;
    bool active;
  }

mapping(address => mapping(bytes32 => Withdrawal)) public withdrawals;
mapping(address => mapping(bytes32 => bool)) public usedPasswords;

event logWithdrawal(uint amount, address value);
event logSetWithdrawal(address from, address to, uint value, uint deadline, bool active);

  function setWithdrawal(
    bytes32 _passwordHash, 
    address _to, 
    uint _deadline, 
    bool _active
  )
  payable
  public
  returns (bool)
  {
    require (!usedPasswords[msg.sender][_passwordHash]);
    require(_to != 0);
    require(_deadline>0);

    withdrawals[msg.sender][_passwordHash].to = _to;
    withdrawals[msg.sender][_passwordHash].value= msg.value;
    withdrawals[msg.sender][_passwordHash].deadline= now + _deadline;
    withdrawals[msg.sender][_passwordHash].active = _active;
    usedPasswords[msg.sender][_passwordHash]=true;

    logSetWithdrawal(msg.sender, _to, msg.value, _deadline,_active );

    return true;
  }

function withdraw(address _exchangeAddress, string _password1, string _password2) 
  public 
  returns (bool)
  {
    uint amount;
    bytes32 hashedPassword = keccak256(_password1, _password2);
    
    //why are these require statements not working as expected?
    require(withdrawals[_exchangeAddress][hashedPassword].value>0);
    require(withdrawals[_exchangeAddress][hashedPassword].to == msg.sender);
    require(withdrawals[_exchangeAddress][hashedPassword].deadline > now);
    
    amount = withdrawals[_exchangeAddress][hashedPassword].value;
    withdrawals[_exchangeAddress][hashedPassword].value = 0;
    msg.sender.transfer(amount);

    logWithdrawal(amount, msg.sender);

    return true;
  }

  
  function Remittance() {
    // constructor
  }
}
