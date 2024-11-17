# 🗳️ **Enhanced Voting Contract** 🗳️

A decentralized, tamper-proof voting smart contract built using **Solidity**. This contract allows voters to securely cast their votes, enforces voter integrity, and ensures the integrity of election results through additional checks.

---

## 🚀 **Features**

- **🧑‍💼 Add Candidates**: The owner can add candidates to the election.
- **🗳️ Vote for Candidates**: Voters can cast their vote for their preferred candidate.
- **🏆 Election End & Winner Declaration**: The owner can end the election and declare the winner based on the highest votes.
- **📊 View Results**: Results can be accessed by anyone once the election has ended.
- **🔒 Data Integrity Checks**: Uses `assert` statements to ensure contract consistency during critical operations.
- **🔐 Voter Integrity**: Guarantees that each address votes only once.

---

## ⚙️ **Smart Contract Breakdown**

### Key Changes
- **Data Integrity Assertions**:
  - Ensures `voteCount` updates correctly after each vote.
  - Validates that a winner exists before declaring election results.

### State Variables

- **`owner`**: The Ethereum address of the contract owner (deployer).
- **`candidatesCount`**: The total number of candidates added to the election.
- **`totalVotes`**: The cumulative number of votes cast during the election.
- **`electionEnded`**: Indicates whether the election has ended.
- **`candidates`**: A mapping of candidate IDs to their details (name and vote count).
- **`voters`**: A mapping of voter addresses to their voting status.

### Events

- **`CandidateAdded`**: Emitted when a candidate is added to the election.
- **`Voted`**: Emitted when a voter successfully casts their vote.
- **`ElectionEnded`**: Emitted when the election ends and the winner is announced.

### Modifiers

- **`onlyOwner`**: Restricts actions to the owner of the contract.
- **`electionNotEnded`**: Ensures the election is still ongoing.
- **`hasNotVoted`**: Prevents voters from voting multiple times.

---

## 📜 **Functions**

### 1. `addCandidate(string memory _name)`
- **Purpose**: Adds a new candidate to the election.
- **Access**: Owner-only.
- **Parameters**: `_name` - The name of the candidate.

### 2. `vote(uint256 _candidateId)`
- **Purpose**: Allows eligible voters to vote for a candidate.
- **Conditions**:
  - The voter has not already voted.
  - The election is still ongoing.
- **Parameters**: `_candidateId` - The ID of the candidate to vote for.
- **Data Integrity**:
  - Ensures the candidate’s `voteCount` is updated correctly using `assert`.

### 3. `endElection()`
- **Purpose**: Ends the election and determines the winner.
- **Access**: Owner-only.
- **Data Integrity**:
  - Validates that a winner exists using `assert`.

### 4. `getCandidate(uint256 _candidateId)`
- **Purpose**: Retrieves a candidate's details by their ID.
- **Parameters**: `_candidateId` - The ID of the candidate.
- **Returns**: Candidate name and their vote count.

### 5. `getResults()`
- **Purpose**: Provides the election results, including the winner's name and vote count.
- **Conditions**: The election must have ended.
- **Data Integrity**:
  - Ensures a valid winner is returned using `assert`.

### 6. `hasAddressVoted(address _voter)`
- **Purpose**: Checks whether a specific address has voted.
- **Parameters**: `_voter` - The Ethereum address of the voter.

---

## 📝 **Usage**

1. **Deploy the Contract**: Deploy the contract to a blockchain network (e.g., Ethereum, Rinkeby).
2. **Add Candidates**: As the owner, call `addCandidate` to add one or more candidates.
3. **Voting**: Voters can call `vote` to cast their vote for a specific candidate.
4. **End the Election**: The owner finalizes the election using `endElection`, determining the winner.
5. **View Results**: Call `getResults` to access the election results after it ends.

---

## 🔧 **Requirements**

- **Solidity Version**: ^0.8.17
- **Network**: Ethereum Mainnet or Testnets (e.g., Rinkeby, Goerli)

---

## 📦 **Installation & Setup**

### Step 1: Clone the Repository
```bash
git clone https://github.com/yourusername/enhanced-voting-contract.git
