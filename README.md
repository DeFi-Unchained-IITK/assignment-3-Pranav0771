[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/wK_5sh4Y)
[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-2e0aaae1b6195c2367325f4f02e2d04e9abb55f0b24a779b69b11b9e10269abc.svg)](https://classroom.github.com/online_ide?assignment_repo_id=15287939&assignment_repo_type=AssignmentRepo)

*QUESTION-2*

So here we are creating a smart contract name Voting, to manage a decentralised voting system.
We are defining state variables like(admin, candidateID, voterID) to store the address of the owner and to provide unique id to candidates and voters. Then struct Candidate and Voter are defined. Then using constructor admin is declared. Then modifiers are defined to check if the input id for getvotes and vote functions are valid or not and also if only admin is adding voters and candidates or not. Then mapping is declared to map each candidate and voter with it’s unique id.
Now, functions are declared. In addCandidate function a candidate is added to the mapping with 0 votes using his name. In registerVoter function firstly it is checked if the voter is already registered, if not then using its address it is added to the Voters map. In vote function firstly it is checked if the person is registered, and further it is checked if h/she has already voted, if not then his/her vote is added to the no. of votes of the candidate he/she voted for using the candidateID. The getVoteCount function returns the no. of votes of the candidate whose ID has been given as argument. The getWinner function returns the name of candidate who won the election by comparing votes of each candidate.
How to run the tests?
The VotingTest smart contract is designed to test the functionalities of the Voting contract, ensuring robustness and correctness. It includes tests for adding candidates, registering voters, allowing voters to cast votes, and verifying results such as candidate vote counts and determining the winner. Setup initializes instances of Voting and defines admin and non-admin addresses. Test functions cover scenarios like successful candidate addition and voter registration, handling invalid votes, preventing duplicate registrations, and ensuring non-admin users cannot perform administrative actions. Assertions confirm expected outcomes, such as correct candidate names and vote counts. These tests aim to validate core contract functionalities and edge cases, providing confidence in the Voting contract's behavior under various conditions.

*QUESTION-3*

****ASS2.Q1****

This Test file verifies the functionality of a primeowner contract. The contract contains a function called work that changes ownership based on a specific condition. The tests cover various scenarios:<br>
Ensuring the initial owner is set correctly.
Verifying ownership transfer when work is called with a valid input (a prime number).
Checking that ownership remains unchanged when work is called with a number other than prime number and a valid input.
Testing for reverting transactions when calling work with an invalid input (like zero).

****ASS2.Q2****

This Test file verifies the functionality of an employeeregistree contract. The tests cover essential employee management operations and various other scenarios::
The tests cover various scenarios:<br> 
testAddEmployee:
Uses assertions(assertEq) to compare the retrieved details (name, position, salary) using GetEmployeeDetails with the original data, verifying successful employee creation.<br>
testUpdateEmployee:
It creates a new employee. Then creates new data for name, position, and salary. Updates the detail using UpdateEmployee. Uses assertions to compare the retrieved details(using get details function) with the updated data, verifying successful employee information change.<br>
testGetEmployeeDetails:
It creates a new employee. Then uses assertions to compare the retrieved details (using GetEmployeeDetails) with the original data, ensuring they both match.<br>
testDeleteEmployee:
Creates a new employee. Calls the DeleteEmployee function to delete the employee. Expects a revert (vm.expectRevert) with message "ID does not exist!" when trying to retrieve details of the deleted employee , verifying successful deletion.<br>
testUpdateNonexistentEmployee:
Directly attempts to update employee details using UpdateEmployee for any random id such that no employee has that id. Expects a revert with message "ID does not exist!" since the update is for a non-existent employee, verifying the contract handles such attempts appropriately.<br>
testDeleteNonExistentEmployee:
Directly attempts to delete an employee using DeleteEmployee for any random id such that no employee has that id. Expects a revert with the message "ID does not exist!" since the deletion is for a non-existent employee, verifying the contract handles such attempts appropriately.


****ASS2.Q3****

This Test file verifies the functionality of a Library contract that manages a collection of books. The tests cover various book lending and management scenarios:<br>
testAddBook: Ensures successful book addition same way as we did in second question(ASS2.Q3).<br>
testBorrowBook: This function verifies successful borrowing by checking books availability to be false after borrowing using assertions(assertEq. Checks if the borrowed book is listed in the caller's borrowed book list using borrowed_books.<br>
testReturnBook: This function verifies that the book availability is set back to true after successful return using assertion. Ensures book is removed from borrowed_books by checking if it reverts if book details are retrieved from borrowed_books.<br>
testBorrowUnavailableBook: Tests if attempting to borrow an already borrowed book results in a "Book Unavailable" revert.<br>
testBorrowInvalidBookID: This function verifies borrowing book with an invalid book id leads to an "Invalid ID" revert.<br>
testReturnInvalidBookID: This function verifies attempting to return a book with an invalid id leads to an "Invalid ID" revert.<br>
testReturnNotBorrowedBook: This function verifies attempting to return a book that hasn't been borrowed results in a "Book not borrowed by the caller" revert.<br>
testReturnBookNotBorrowedByCaller: This function tests that if a different address tries to return a borrowed book, it results in a "Book not borrowed by the caller" revert.<br>
