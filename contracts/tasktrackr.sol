// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract tasktrackr {
    struct TodoItem {
        string task;
        bool isCompleted;
        uint256 time;
    }

    event TaskCompleted(uint256 indexed id);
    event TaskUpdated(uint256 indexed id, string newTask);
    event ContractDestroyed(address indexed destroyer);
    
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

    function addTask(string calldata task ) public 
    {
        TodoItem memory item = TodoItem({task: task, isCompleted: false, time:block.timestamp});
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

    // Delete everything

    function destroyContract() public onlyOwner {
        emit ContractDestroyed(msg.sender);
        selfdestruct(payable(owner));
    }


    function displayAllTasks() public view returns (string[] memory tasks, bool[] memory statuses,uint256[] memory times) {
    string[] memory taskList = new string[](count);
    bool[] memory statusList = new bool[](count);
    uint256[] memory timeList = new uint256[](count);
    if(count==0)
    revert("Nothing to display");
    for (uint256 i = 0; i < count; i++) {
        TodoItem memory item = list[i];
        taskList[i] = item.task;
        statusList[i] = item.isCompleted;
        timeList[i] = item.time;
        
    }

    return (taskList, statusList, timeList);
}
    function displayById(uint256 id) public view returns (string memory task, bool isCompleted,uint256 time) {
    require(id < count, "Task with given ID does not exist");
    TodoItem memory item = list[id];
    return (item.task, item.isCompleted, item.time);
    }
    
}

