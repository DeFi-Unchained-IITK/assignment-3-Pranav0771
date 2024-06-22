// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract employeeregistree{

    struct employee{
        uint ID; 
        string name;
        string position;
        uint salary;
    }

    mapping (uint => employee) public Employees;

    uint public employee_id;

    event newEmployeeAdded (uint ID, string name, string position, uint salary);
    event EmployeeUpdated(uint ID, string name, string position, uint salary);
    event EmployeeDeleted(uint ID, string name, string position, uint salary);

    function AddEmployee (string memory name, string memory position, uint salary) public{
        Employees[employee_id] = employee(employee_id, name, position, salary);
        emit newEmployeeAdded(employee_id, name, position, salary);
        employee_id += 1;
    }

    function UpdateEmployee (uint id, string memory name, string memory position, uint salary) public{
        if(id < employee_id){
            bytes memory tempEmptyStringTest = bytes(Employees[id].name);
            bytes memory _tempEmptyStringTest = bytes(Employees[id].position);
            if(tempEmptyStringTest.length != 0 || _tempEmptyStringTest.length != 0 || salary != 0){
                Employees[id] = employee(id, name, position, salary);
                emit EmployeeUpdated(id, name, position, salary);
            }
            else{
                revert ("ID does not exist!");
            }
        }
        else{
            revert ("ID does not exist!");
        }
    }
    
    function GetEmployeeDetails (uint id) public view returns (string memory, string memory, uint){
       if(id < employee_id){
            bytes memory tempEmptyStringTest = bytes(Employees[id].name);
            bytes memory _tempEmptyStringTest = bytes(Employees[id].position);
            if(tempEmptyStringTest.length != 0 || _tempEmptyStringTest.length != 0 || Employees[id].salary != 0){
                return (Employees[id].name, Employees[id].position, Employees[id].salary);
            }
            else{
                revert ("ID does not exist!");
            }
        }
        else{
            revert ("ID does not exist!");
        }
    }

    function DeleteEmployee (uint id) public {
       if(id < employee_id){
            employee memory EMPLOYEE = Employees[id];
            bytes memory tempEmptyStringTest = bytes(Employees[id].name);
            bytes memory _tempEmptyStringTest = bytes(Employees[id].position);
            if(tempEmptyStringTest.length != 0 || _tempEmptyStringTest.length != 0 || Employees[id].salary != 0){
                delete Employees[id];
                emit EmployeeDeleted(EMPLOYEE.ID, EMPLOYEE.name, EMPLOYEE.position, EMPLOYEE.salary);
            }
            else{
                revert ("ID does not exist!");
            }
        }
        else{
            revert ("ID does not exist!");
        }
    }

}