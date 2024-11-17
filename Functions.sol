// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract SimpleVoting {
    address public owner;

    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    struct Voter {
        bool hasVoted;
        uint256 votedCandidateId;
    }

    mapping(uint256 => Candidate) public candidates;
    mapping(address => Voter) public voters;

    uint256 public candidatesCount;
    uint256 public totalVotes;
    bool public electionEnded;

    event Voted(address indexed voter, uint256 candidateId);
    event ElectionEnded(address indexed owner, uint256 winnerId);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action.");
        _;
    }

    modifier electionNotEnded() {
        require(!electionEnded, "The election has already ended.");
        _;
    }

    modifier hasNotVoted() {
        require(!voters[msg.sender].hasVoted, "You have already voted.");
        _;
    }

    constructor() {
        owner = msg.sender; // Set the deployer as the owner
    }

    // Function to add a candidate (only the owner can add candidates)
    function addCandidate(string memory _name) public onlyOwner {
        candidatesCount++;
        candidates[candidatesCount] = Candidate({
            id: candidatesCount,
            name: _name,
            voteCount: 0
        });
    }

    // Function for voters to vote for a candidate
    function vote(uint256 _candidateId) public hasNotVoted electionNotEnded {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID.");

        // Record the vote
        voters[msg.sender].hasVoted = true;
        voters[msg.sender].votedCandidateId = _candidateId;

        // Increment the candidate's vote count
        candidates[_candidateId].voteCount++;

        totalVotes++;

        emit Voted(msg.sender, _candidateId);
    }

    // Function to end the election and determine the winner
    function endElection() public onlyOwner {
        require(!electionEnded, "The election has already ended.");
        electionEnded = true;

        uint256 winningVoteCount = 0;
        uint256 winnerId = 0;

        // Find the candidate with the most votes
        for (uint256 i = 1; i <= candidatesCount; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winnerId = i;
            }
        }

        emit ElectionEnded(msg.sender, winnerId);
    }

    // Function to get the results of the election
    function getResults() public view returns (string memory winnerName, uint256 voteCount) {
        require(electionEnded, "The election has not ended yet.");
        uint256 winnerId;
        uint256 winningVoteCount = 0;

        for (uint256 i = 1; i <= candidatesCount; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winnerId = i;
            }
        }

        winnerName = candidates[winnerId].name;
        voteCount = candidates[winnerId].voteCount;
    }
}