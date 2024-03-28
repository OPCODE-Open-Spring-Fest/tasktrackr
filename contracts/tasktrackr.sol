// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0<0.9.0;
//mapping is to be used
contract tasktrackr{
    struct TodoItem {
        string task;
        bool isCompleted;
    }
    event TaskCompleted(uint256 indexed id);
    
    event TaskUpdated(uint256 indexed id, string newTask);

    mapping( uint256=> TodoItem) public list;

    uint256 public count=0;
    constructor()
    {

    }

    function addTask(string calldata task) public 
    {
        TodoItem memory item = TodoItem({task: task, isCompleted:false});
        list[count]=item;
        count++;
    }
    function completeTask(uint256 id) public
    {
        if(!list[id].isCompleted){
            list[id].isCompleted=true;
            emit TaskCompleted(id);
        }
    }

    function updateTask(uint256 id, string calldata newTask) public 
    {
        require(id < count, "Task with given ID does not exist");
        list[id].task = newTask;
        emit TaskUpdated(id, newTask);
    }

    function displayAllTasks() public view returns (string[] memory tasks, bool[] memory statuses) {
    string[] memory taskList = new string[](count);
    bool[] memory statusList = new bool[](count);
    if(count==0)
    revert("Nothing to display");
    for (uint256 i = 0; i < count; i++) {
        TodoItem memory item = list[i];
        taskList[i] = item.task;
        statusList[i] = item.isCompleted;
    }

    return (taskList, statusList);
}
    function displayById(uint256 id) public view returns (string memory task, bool isCompleted) {
    require(id < count, "Task with given ID does not exist");
    TodoItem memory item = list[id];
    return (item.task, item.isCompleted);
    }
    
}