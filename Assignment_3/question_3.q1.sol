// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract primeowner{

    address public owner;

    event ownerChange(address indexed previousOwner, address indexed newOwner);

    constructor(){
        owner = msg.sender;
    }

    function isPrime(uint _num) public pure returns (bool){
        for (uint i = 2; i <= _num / 2; i++) {
            if (_num % i == 0) {
                return false;
            }
        }
        return true;
    }
    
    function work(uint num) public {
        if(num>=1){
            if(isPrime(num)){
                address prevOwner = owner;
                owner = msg.sender;
                emit ownerChange(prevOwner,owner);
            }
        }
        else{
            revert ("Invalid Input");
        }
    }
}