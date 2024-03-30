// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0<0.9.0;

contract tasktrackr{
    struct TodoItem {
        string task;
        bool isCompleted;
        address owner;
    }

    event TaskCompleted(address indexed owner, uint256 indexed id);
    event TaskUpdated(address indexed owner, uint256 indexed id, string newTask);

    mapping(address => mapping(uint256 => TodoItem)) public list;
    mapping(address => uint256) public count;

    function addTask(string calldata task) public {
        TodoItem memory item = TodoItem({task: task, isCompleted: false, owner: msg.sender});
        list[msg.sender][count[msg.sender]] = item;
        count[msg.sender]++;
    }

    function completeTask(uint256 id) public {
        require(msg.sender == list[msg.sender][id].owner, "Only the owner can complete the task");
        if(!list[msg.sender][id].isCompleted){
            list[msg.sender][id].isCompleted = true;
            emit TaskCompleted(msg.sender, id);
        }
    }

    function updateTask(uint256 id, string calldata newTask) public {
        require(msg.sender == list[msg.sender][id].owner, "Only the owner can update the task");
        list[msg.sender][id].task = newTask;
        emit TaskUpdated(msg.sender, id, newTask);
    }

    function displayAllTasks() public view returns (string[] memory tasks, bool[] memory statuses) {
        string[] memory taskList = new string[](count[msg.sender]);
        bool[] memory statusList = new bool[](count[msg.sender]);

        for (uint256 i = 0; i < count[msg.sender]; i++) {
            TodoItem memory item = list[msg.sender][i];
            taskList[i] = item.task;
            statusList[i] = item.isCompleted;
        }

        return (taskList, statusList);
    }
}