// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "forge-std/Test.sol";
import "../src/question_3.2.sol";

contract EmployeeRegistreeTest is Test {
    employeeregistree public employeeRegistree;

    function setUp() public {
        employeeRegistree = new employeeregistree();
    }

    function testAddEmployee() public {
        string memory name = "Sohan";
        string memory position = "CEO";
        uint salary = 200;
        employeeRegistree.AddEmployee(name, position, salary);
        (string memory _name, string memory _position, uint _salary) = employeeRegistree.GetEmployeeDetails(0);
        assertEq(_name, name);
        assertEq(_position, position);
        assertEq(_salary, salary);
    }

    function testUpdateEmployee() public {
        string memory name = "Sohan";
        string memory position = "CEO";
        uint salary = 200;
        employeeRegistree.AddEmployee(name, position, salary);
        string memory newName = "Rohan";
        string memory newPosition = "PM";
        uint newSalary = 500;
        employeeRegistree.UpdateEmployee(0, newName, newPosition, newSalary);
        (string memory _name, string memory _position, uint _salary) = employeeRegistree.GetEmployeeDetails(0);
        assertEq(_name, newName);
        assertEq(_position, newPosition);
        assertEq(_salary, newSalary);
    }

    function testGetEmployeeDetails() public {
        string memory name = "Sohan";
        string memory position = "CEO";
        uint salary = 200;
        employeeRegistree.AddEmployee(name, position, salary);
        (string memory _name, string memory _position, uint _salary) = employeeRegistree.GetEmployeeDetails(0);
        assertEq(_name, name);
        assertEq(_position, position);
        assertEq(_salary, salary);
    }

    function testDeleteEmployee() public {
        string memory name = "Sohan";
        string memory position = "CEO";
        uint salary = 200;
        employeeRegistree.AddEmployee(name, position, salary);
        employeeRegistree.DeleteEmployee(0);
        vm.expectRevert("ID does not exist!");
        employeeRegistree.GetEmployeeDetails(0);
    }

    function testUpdateNonexistentEmployee() public {
        string memory newName = "Rohan";
        string memory newPosition = "PM";
        uint newSalary = 500;
        vm.expectRevert("ID does not exist!");
        employeeRegistree.UpdateEmployee(0, newName, newPosition, newSalary);
    }

    function testDeleteNonExistentEmployee() public {
        vm.expectRevert("ID does not exist!");
        employeeRegistree.DeleteEmployee(0);
    }
}