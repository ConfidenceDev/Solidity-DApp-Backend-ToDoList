// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract ToDo{
    struct TodoItem{
        string task;
        bool isCompleted;
    }

    mapping(uint => TodoItem) public list;
    address public owner;
    event TaskCompleted(uint indexed id);
    uint public count = 0;

    constructor(){
        owner = msg.sender;
    }

    function addToDo(string calldata task) onlyOwner public {
        TodoItem memory item = TodoItem({ task: task, isCompleted: false});
        list[count++] = item;
    }

    function completeToDo(uint id) onlyOwner public{
        if(!list[id].isCompleted){
            list[id].isCompleted = true;
            emit TaskCompleted(id);
        }
    }

    modifier onlyOwner(){
        require(owner == msg.sender, "Only owner can manage todos");
        _;
    }
}