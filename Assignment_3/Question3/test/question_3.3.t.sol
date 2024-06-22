// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Test.sol";
import "../src/question_3.3.sol";

contract LibraryTest is Test {
    Library public libraryContract;

    function setUp() public {
        libraryContract = new Library();
    }

    function testAddBook() public {
        string memory name = "Harry Potter";
        string memory author = "JK Rowling";
        libraryContract.AddBook(name, author);
        (string memory _name, string memory _author, bool _isAvailable) = libraryContract.GetBookDetails(1);
        assertEq(_name, name);
        assertEq(_author, author);
        assertEq(_isAvailable, true);
    }

    function testBorrowBook() public {
        string memory name = "Harry Potter";
        string memory author = "JK Rowling";
        libraryContract.AddBook(name, author);
        libraryContract.BorrowBook(1);
        (string memory _name, string memory _author, bool _isAvailable) = libraryContract.GetBookDetails(1);
        assertEq(_name, name);
        assertEq(_author, author);
        assertEq(_isAvailable, false);
        (, string memory _Name, string memory _Author,) = libraryContract.borrowed_books(address(this), 0);
        assertEq(_Name, name);
        assertEq(_Author, author);
    }

    function testReturnBook() public {
        string memory name = "Harry Potter";
        string memory author = "JK Rowling";
        libraryContract.AddBook(name, author);
        libraryContract.BorrowBook(1);
        libraryContract.ReturnBook(1);
        ( , , bool _isAvailable) = libraryContract.GetBookDetails(1);
        assertEq(_isAvailable, true);
        vm.expectRevert();
        (uint _id, string memory _Name, string memory _Author, ) = libraryContract.borrowed_books(address(this),0);
    }

    function testBorrowUnavailableBook() public {
        string memory name = "Harry Potter";
        string memory author = "JK Rowling";
        libraryContract.AddBook(name, author);
        libraryContract.BorrowBook(1);
        vm.expectRevert("Book Unavailable");
        libraryContract.BorrowBook(1);
    }

    function testBorrowInvalidBookID() public {
        vm.expectRevert("Invalid ID");
        libraryContract.BorrowBook(0);
    }

    function testReturnInvalidBookID() public {
        string memory name = "Harry Potter";
        string memory author = "JK Rowling";
        libraryContract.AddBook(name, author);
        libraryContract.BorrowBook(1);
        vm.expectRevert("Invalid ID");
        libraryContract.ReturnBook(2);
    }

    function testReturnNotBorrowedBook() public {
        string memory name = "Harry Potter";
        string memory author = "JK Rowling";
        libraryContract.AddBook(name, author);
        vm.expectRevert("Book not borrowed by the caller");
        libraryContract.ReturnBook(1);
    }

    function testReturnBookNotBorrowedByCaller() public {
        string memory name = "Harry Potter";
        string memory author = "JK Rowling";
        libraryContract.AddBook(name, author);
        vm.prank(0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc);
        libraryContract.BorrowBook(1);
        vm.expectRevert("Book not borrowed by the caller");
        libraryContract.ReturnBook(1);
    }
}