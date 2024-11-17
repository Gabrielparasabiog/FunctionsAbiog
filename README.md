# 🗳️ **Enhanced Voting Contract** 🗳️

A decentralized voting smart contract built using **Solidity** to enable secure and transparent elections on the blockchain. This contract allows voters to cast their votes for candidates, with the contract owner managing the election process and determining the winner.

---

## 🚀 **Features**

- **🧑‍💼 Add Candidates**: The owner can add candidates to the election.
- **🗳️ Vote for Candidates**: Voters can cast their votes for their preferred candidates.
- **🏆 Election End & Winner Declaration**: The owner can close the election and declare the winner based on the most votes.
- **📊 View Results**: After the election ends, anyone can view the election results and the winner.
- **🔒 Voter Integrity**: Ensures that each address can vote only once during the election.

---

## ⚙️ **Smart Contract Breakdown**

### State Variables

- **`owner`**: The Ethereum address of the contract owner (the deployer).
- **`candidatesCount`**: The total number of candidates added to the election.
- **`totalVotes`**: The total number of votes cast by voters.
- **`electionEnded`**: A flag that indicates whether the election has ended or is still ongoing.
- **`candidates`**: A mapping of candidate IDs to their details (name and vote count).
- **`voters`**: A mapping of voter addresses to their voting status.

### Events

- **`CandidateAdded`**: Emitted when a new candidate is added to the election.
- **`Voted`**: Emitted when a voter casts their vote.
- **`ElectionEnded`**: Emitted when the election ends and the winner is announced.

### Modifiers

- **`onlyOwner`**: Ensures that only the owner can execute certain actions.
- **`electionNotEnded`**: Restricts actions to be performed only if the election is still open.
- **`hasNotVoted`**: Ensures that a voter can only vote once.

---

## 📜 **Functions**

### 1. `addCandidate(string memory _name)`
- **Purpose**: Adds a new candidate to the election.
- **Access Control**: Only the contract owner can call this function.
- **Parameters**: `_name` - The name of the candidate.

### 2. `vote(uint256 _candidateId)`
- **Purpose**: Allows a voter to vote for a candidate.
- **Conditions**: Only callable if the election is ongoing and the voter hasn't voted yet.
- **Parameters**: `_candidateId` - The ID of the candidate to vote for.

### 3. `endElection()`
- **Purpose**: Ends the election and declares the winner based on the highest vote count.
- **Access Control**: Only the contract owner can call this function.

### 4. `getCandidate(uint256 _candidateId)`
- **Purpose**: Returns the name and the total vote count of a specific candidate.
- **Parameters**: `_candidateId` - The ID of the candidate.

### 5. `getResults()`
- **Purpose**: Returns the results of the election, including the winning candidate's name and vote count.
- **Conditions**: Can only be called after the election has ended.

### 6. `hasAddressVoted(address _voter)`
- **Purpose**: Checks if a specific address has voted in the election.
- **Parameters**: `_voter` - The address to check.

---

## 📝 **Usage**

1. **Deploy the Contract**: Deploy the smart contract to the Ethereum network or a test network (e.g., Rinkeby or Goerli).
2. **Add Candidates**: As the contract owner, use the `addCandidate` function to add candidates for the election.
3. **Voting**: Voters can call the `vote` function to cast their vote for a candidate.
4. **End the Election**: After the election period, use `endElection` to close the election and determine the winner.
5. **View Results**: Anyone can call `getResults` to view the election results and see who won!

---

## 🔧 **Requirements**

- **Solidity Version**: ^0.8.17
- **Ethereum Network**: Mainnet or Testnets (e.g., Rinkeby, Goerli)

---

## 📑 **License**

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for more information.

---

## 💬 **Contributing**

Feel free to fork this repository, submit issues, and create pull requests. Contributions are welcome!

---

## 📦 **Installation & Setup**

To deploy and interact with the contract:

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/enhanced-voting-contract.git
