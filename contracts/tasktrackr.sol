// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract tasktrackr {
    struct TodoItem {
        string task;
        bool isCompleted;
    }

    event TaskCompleted(uint256 indexed id);
    event TaskUpdated(uint256 indexed id, string newTask);
    event ContractDestroyed(address indexed destroyer);
    event TaskDeleted(uint256 indexed id);
    
    mapping(uint256 => TodoItem) public list;
    uint256 public count = 0;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can call this function");
        _;
    }

    function addTask(string calldata task) public {
        TodoItem memory item = TodoItem({task: task, isCompleted: false});
        list[count] = item;
        count++;
    }

    function completeTask(uint256 id) public onlyOwner {
        require(!list[id].isCompleted, "Task is already completed");
        list[id].isCompleted = true;
        emit TaskCompleted(id);
    }

    //Update task

    function updateTask(uint256 id, string calldata newTask) public onlyOwner {
        require(id < count, "Task with given ID does not exist");
        list[id].task = newTask;
        emit TaskUpdated(id, newTask);
    }

    // Delete according to complete and incomplete

    function deleteCompleteTask(uint256 id) public {
        require(id < count, "Task with given ID does not exist");
        require(list[id].isCompleted, "Task is not completed yet");
        delete list[id];
        emit TaskDeleted(id);
        count--;
    }

    function deleteIncompleteTask(uint256 id) public {
        require(id < count, "Task with given ID does not exist");
        require(!list[id].isCompleted, "Task is already completed");
        delete list[id];
        emit TaskDeleted(id);
        count--;
    }

    // Delete according to ID

    function deleteTask(uint256 id) public {
        require(id < count, "Task with given ID does not exist");
        emit TaskDeleted(id);
        delete list[id];
        count--;
    }
}
