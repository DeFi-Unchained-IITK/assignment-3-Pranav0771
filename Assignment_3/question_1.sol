// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Bank {
  
  address payable public owner;

  constructor() {
    owner = payable(msg.sender);
  }

  modifier onlyOwner(){
    require(owner == msg.sender,"Not Owner");
    _;
  }

  function deposit() external payable{}

  function transfer(address payable to, uint amount) external onlyOwner{
    require(address(this).balance >= amount, "Tranfer value should be less than your current balance");
    to.transfer(amount);
  }

  function withdraw(uint amount) external onlyOwner{
    require(address(this).balance >= amount, "Withdrawal amount should be less than your current balance");
    owner.transfer(amount);
  }

  function getBalance() external view returns(uint){
    return address(this).balance;
  }
}