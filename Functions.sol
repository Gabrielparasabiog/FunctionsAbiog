// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract EnhancedVoting {
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

    mapping(uint256 => Candidate) private candidates;
    mapping(address => Voter) private voters;

    uint256 public candidatesCount;
    uint256 public totalVotes;
    bool public electionEnded;

    event CandidateAdded(uint256 indexed candidateId, string name);
    event Voted(address indexed voter, uint256 candidateId);
    event ElectionEnded(uint256 winnerId, string winnerName, uint256 voteCount);

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
    function addCandidate(string memory _name) external onlyOwner {
        require(bytes(_name).length > 0, "Candidate name cannot be empty.");

        candidatesCount++;
        candidates[candidatesCount] = Candidate({
            id: candidatesCount,
            name: _name,
            voteCount: 0
        });

        emit CandidateAdded(candidatesCount, _name);
    }

    // Function for voters to vote for a candidate
    function vote(uint256 _candidateId) external electionNotEnded hasNotVoted {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID.");

        // Record the vote
        voters[msg.sender] = Voter({
            hasVoted: true,
            votedCandidateId: _candidateId
        });

        // Increment the candidate's vote count
        candidates[_candidateId].voteCount++;
        totalVotes++;

        emit Voted(msg.sender, _candidateId);
    }

    // Function to end the election and determine the winner
    function endElection() external onlyOwner {
        require(!electionEnded, "The election has already ended.");
        require(candidatesCount > 0, "No candidates available to determine a winner.");

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

        emit ElectionEnded(winnerId, candidates[winnerId].name, winningVoteCount);
    }

    // Function to get the details of a candidate
    function getCandidate(uint256 _candidateId) external view returns (string memory name, uint256 voteCount) {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID.");

        Candidate memory candidate = candidates[_candidateId];
        return (candidate.name, candidate.voteCount);
    }

    // Function to get the results of the election
    function getResults() external view returns (string memory winnerName, uint256 voteCount) {
        require(electionEnded, "The election has not ended yet.");
        
        uint256 winningVoteCount = 0;
        uint256 winnerId = 0;

        for (uint256 i = 1; i <= candidatesCount; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winnerId = i;
            }
        }

        winnerName = candidates[winnerId].name;
        voteCount = candidates[winnerId].voteCount;
    }

    // Function to check if an address has voted
    function hasAddressVoted(address _voter) external view returns (bool) {
        return voters[_voter].hasVoted;
    }
}
