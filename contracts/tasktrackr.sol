// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0<0.9.0;
//mapping is to be used
contract tasktrackr{
    struct TodoItem {
        string task;
        bool isCompleted;
    }
    event TaskCompleted(uint256 indexed id);
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


    // Code by Jagpreet153 started
    function displayAllTasks() public view returns (string[] memory tasks, bool[] memory statuses) {
    string[] memory taskList = new string[](count);
    bool[] memory statusList = new bool[](count);
    if(count==0)    // If count is 0 reveret the changes
    revert("Nothing to display");  
    for (uint256 i = 0; i < count; i++) {  // Else if the tasks are completed then display them
        TodoItem memory item = list[i];
        taskList[i] = item.task;
        statusList[i] = item.isCompleted;
    }

    return (taskList, statusList);
    }
     // Code by Jagpreet153 ended
}