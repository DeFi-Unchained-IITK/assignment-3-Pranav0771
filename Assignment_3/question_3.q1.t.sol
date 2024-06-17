// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "forge-std/Test.sol";
import "../src/question_3.q1.sol"; 

contract PrimeOwnerTest is Test {
    primeowner public primeOwner;
    address public initialOwner;
    address public newOwner;

    function setUp() public {
        primeOwner = new primeowner();
        initialOwner = address(this);
        newOwner = address(0x90F79bf6EB2c4f870365E785982E1f101E93b906);
    }

    function testInitialOwner() public view {
        assertEq(primeOwner.owner(), initialOwner);
    }

    function testOwnerChange() public {
        vm.prank(newOwner);
        primeOwner.work(5);
        assertEq(primeOwner.owner(), newOwner);
    }

    function testNoOwnerChange() public {
        vm.prank(newOwner);
        primeOwner.work(4);
        assertEq(primeOwner.owner(), initialOwner);
    }

    function testInvalidInput() public {
        vm.prank(newOwner);
        vm.expectRevert("Invalid Input");
        primeOwner.work(0);
    }

}