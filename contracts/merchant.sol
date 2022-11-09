// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract Contract {

    address public merchant;
    address public buyer;
    uint256 price;

    constructor(uint _value){
        merchant= msg.sender;
        price = _value;
    }
    // set buyer to new address that pays the amount
    function buy() public payable  {

        require(msg.value >= (price+getGasPrice()));
        buyer = msg.sender;
    }
        //returns the current gas for some resaon it always outputs 1 
    function getGasPrice() public view returns (uint256) {
        uint256 gasPrice;
        assembly {
            gasPrice := gasprice()
        }
        return gasPrice;
    }
    
    // view the current amount
    function prie() external view returns(uint){
        return price;
    }

        // withdraw function by only merchant
    function withdraw() public  {
        require(msg.sender == merchant);
        uint256 amount = address(this).balance;
        (bool sent, ) = merchant.call{value: amount}("");
        require(sent, "failed to withdraw");
    }
}