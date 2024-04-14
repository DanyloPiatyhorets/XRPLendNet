// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "backend/contracts/Lender.sol";

contract Config{

    address[] loans;

    constructor(){
    }

    function CreateLoan(uint256 principal, uint256 term, uint256 interval, uint32 interest, address lenderAddress, address borrowerAddress) external {
        loans.push(address(new Lender(principal, term, interval, interest, lenderAddress, borrowerAddress)));
    }

    function GetLoans() external view returns (address[] memory){
        return loans;
    }

}