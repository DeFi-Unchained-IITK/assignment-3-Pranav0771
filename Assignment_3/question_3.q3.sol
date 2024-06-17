// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Library{

    struct Book{
        uint ID;
        string name;
        string author;
        bool isAvailable;
    }

    mapping (uint => Book) public books;
    mapping (address => Book[]) public borrowed_books;

    uint public book_id = 1;

    modifier validID(uint id){
        require(id < book_id, "Invalid ID");
        require(id > 0, "Invalid ID");
        _;
    }

    function AddBook (string memory name, string memory author) public{
        books[book_id] = Book(book_id, name, author, true);
        book_id += 1;
    }

    function BorrowBook (uint id) public validID(id){
        require(books[id].isAvailable, "Book Unavailable");
        borrowed_books[msg.sender].push(books[id]);
        books[id].isAvailable = false;
    }

    function GetBookDetails (uint id) public validID(id) view returns (string memory, string memory, bool){
        return(books[id].name, books[id].author, books[id].isAvailable);
    }

    function ReturnBook (uint id) public validID(id) {
        Book[] memory booksBorrowed = borrowed_books[msg.sender];
        require(booksBorrowed.length != 0, "Book not borrowed by the caller");
        bool flag = false;
        for(uint i=0; i<booksBorrowed.length; i++){
            if(booksBorrowed[i].ID == id){
                borrowed_books[msg.sender][i] = booksBorrowed[booksBorrowed.length-1];
                borrowed_books[msg.sender][booksBorrowed.length-1] = booksBorrowed[i];
                borrowed_books[msg.sender].pop();
                books[id].isAvailable = true;
                flag = true;
                break;
            }
        }
        require(flag,"Book not borrowed by the caller");
    }
}