// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Progetto {


    uint public TotalHarvest;
    address payable public Owner;
    uint public Goal;
    uint public PeopleWhoDonated;
    bool public ContractOpen = true;


    constructor (uint _valueGoal) {
        Owner = payable (msg.sender);
        Goal = _valueGoal;
    }


    modifier OnlyOwner () {
        require(Owner==msg.sender);
        _;
    }


    modifier Cost () {
        require(msg.value>0);
        _;
    }


    function StatusCrowfounding () public view returns (string memory) {
          if (ContractOpen==false) {
            return "Contract disabled";
        } else {
            if (TotalHarvest>=Goal){
                return "Fundraising goal achieved, the fundraising could be closed at any moment.";
            } else {
                return "Fundraising open.";
            }
        }
    }


    function Donate () payable public Cost {
        require(ContractOpen==true);
        PeopleWhoDonated++;
        TotalHarvest = TotalHarvest + msg.value;
    }


    function Withdraw () OnlyOwner payable  public {
        require(ContractOpen==true);
        require(TotalHarvest>=Goal);
        Owner.transfer(msg.value);
        TotalHarvest = 0;
    }


    function CloseCrowfounding () OnlyOwner public {
       ContractOpen = false;

    }


    function ReOpenCrowfounding () OnlyOwner public {
        ContractOpen = true;
    }

}