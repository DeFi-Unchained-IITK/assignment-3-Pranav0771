// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Voting {
  
    address public admin;
    uint public candidateID;
    uint public voterID;

    struct Candidate{
        string name;
        uint votes;
    }

    struct Voter{
        address voter;
        bool voted;
    }
    
    constructor() {
        admin = msg.sender;
    }
    
    mapping (uint=>Candidate) public Candidates;
    mapping (uint=>Voter) public Voters;
    
    modifier onlyAdmin(){
        require(admin == msg.sender, "Not Admin!");
        _;
    }

    modifier validID(uint id){
        require(id < candidateID, "Invalid ID!");
        _;
    }
    
    function addCandidate(string memory name) public onlyAdmin {
        Candidates[candidateID] = Candidate(name, 0);
        candidateID++;
    }
    
    function registerVoter(address voter) public onlyAdmin {
        for(uint i=0; i<voterID; i++){
            require(Voters[i].voter != voter, "Duplicate Registration!");
        }
        Voters[voterID] = Voter(voter, false);
        voterID++;
    }

    function vote(uint candidateId) public validID(candidateId) {
        for(uint i=0; i<voterID; i++){
            if(msg.sender == Voters[i].voter){
                if(!Voters[i].voted){
                    Candidates[candidateId].votes++;
                    Voters[i].voted = true;
                    return;
                }
                else{
                    revert("Voter already voted!");
                }
            }
        }
        revert("Voter not listed in Voting list!");
    }

    function getVoteCount(uint candidateId) public validID(candidateId) view returns(uint){
        return Candidates[candidateId].votes;
    }

    function getWinner() public view returns(string memory){
        uint max = 0;
        uint point;
        for(uint i=0; i<candidateID; i++){
            if(Candidates[i].votes > max){
                max = Candidates[i].votes;
                point = i;
            }
        }
        return Candidates[point].name;
    }
}