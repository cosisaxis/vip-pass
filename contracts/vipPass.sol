// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract VipPasses{
    uint256 vipPrices = 0.06 ether;
    uint256 supply = 50;
    address owner;

    mapping (address => uint256) vpHoldings;

    constructor(){
        owner = msg.sender;
        vpHoldings[msg.sender] = supply;
    }

    function buyVipPass(address _customer, uint256 _amount )payable public {
        require(msg.value >= vipPrices * _amount);
        addPass(_customer, _amount);

    }

    function usePass(address _customer, uint256 _amount) public{
        subPass(_customer, _amount);

    }

    function addPass(address _customer, uint256 _amount) internal{
        vpHoldings[_customer] = vpHoldings[_customer] + _amount;
    }

    function subPass(address _customer, uint256 _amount) internal{
        require(vpHoldings[_customer] >= _amount, "You dont own any tickets");
        vpHoldings[_customer] = vpHoldings[_customer] - _amount;
    }

    function refund() public{
        require(msg.sender == owner, "You dont own any passes,");
        (bool success, ) = payable(owner).call{value: address(this).balance}("");
        require(success);
    }


}