// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract BuyMeCoffee {
    event NewCoffee(address indexed from, string name, string message);

    struct Coffee {
        address from;
        string name;
        string message;
        uint256 timestamp;
    }

    Coffee[] public coffees;
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "Zero ETH");

        coffees.push(Coffee(msg.sender, _name, _message, block.timestamp));
        emit NewCoffee(msg.sender, _name, _message);
    }

    function withdrawTips() external {
        require(msg.sender == owner, "Not owner");
        owner.transfer(address(this).balance);
    }

    function getCoffees() public view returns (Coffee[] memory) {
        return coffees;
    }
}
