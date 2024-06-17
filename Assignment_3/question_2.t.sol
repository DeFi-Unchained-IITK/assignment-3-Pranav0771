// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import "forge-std/Test.sol";
import "/home/krishpra0771/github-classroom/DeFi-Unchained-IITK/assignment-3-Pranav0771/Assignment_3/question_2.sol"; 

contract VotingTest is Test {
    Voting public voting;
    address public admin;
    address public nonAdmin;

    function setUp() public {
        voting = new Voting();
        admin = address(this);
        nonAdmin = address(0x90F79bf6EB2c4f870365E785982E1f101E93b906); 
    }

    function testaddCandidate() public {
        voting.addCandidate("Ramesh");
        (string memory name, uint votes) = voting.Candidates(0);
        assertEq(name, "Ramesh");
        assertEq(votes, 0);
        assertEq(voting.candidateID(), 1); 
    }

    function testregisterVoter() public {
        voting.registerVoter(0x70997970C51812dc3A010C7d01b50e0d17dc79C8);
        (address voter, bool voted) = voting.Voters(0);
        assertEq(voter, 0x70997970C51812dc3A010C7d01b50e0d17dc79C8);
        assertEq(voted, false);
        assertEq(voting.voterID(), 1); 
    }
    
    function testVote() public {
        voting.registerVoter(0x70997970C51812dc3A010C7d01b50e0d17dc79C8);
        voting.addCandidate("Ramesh");
        vm.prank(0x70997970C51812dc3A010C7d01b50e0d17dc79C8);
        voting.vote(0);
        (, uint votes) = voting.Candidates(0);
        assertEq(votes, 1);
    }

    function testFailVoteForInvalidCandidate() public {
        address voterAddress = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
        voting.registerVoter(voterAddress);
        vm.prank(voterAddress);
        voting.vote(999);
    }

    function testFailDuplicateVoterRegistration() public {
        address voterAddress = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
        voting.registerVoter(voterAddress);
        voting.registerVoter(voterAddress);
    }

    function testFailNonAdminCannotAddCandidate() public {
        vm.prank(nonAdmin);
        voting.addCandidate("Suresh");
    }

    function testFailNonAdminCannotRegisterVoter() public {
        address voterAddress = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
        vm.prank(nonAdmin);
        voting.registerVoter(voterAddress);
    }

    function testGetVoteCount() public {
        voting.addCandidate("Ramesh");
        uint candidateId = 0;
        uint voteCount = voting.getVoteCount(candidateId);
        address voterAddress = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
        voting.registerVoter(voterAddress);
        vm.prank(voterAddress);
        voting.vote(candidateId);
        voteCount = voting.getVoteCount(candidateId);
        assertEq(voteCount, 1);
    }

    function testGetWinner() public {
        voting.addCandidate("Ramesh");
        voting.addCandidate("Suresh");
        address voterAddress1 = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
        address voterAddress2 = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC;
        voting.registerVoter(voterAddress1);
        voting.registerVoter(voterAddress2);
        vm.prank(voterAddress1);
        voting.vote(1); 
        vm.prank(voterAddress2);
        voting.vote(1); 
        string memory winner = voting.getWinner();
        assertEq(winner, "Suresh");
    }
}