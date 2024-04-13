// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

contract Config{
    address private borrower;
    address private lender;

//    address public LenderAddress;
//    address public BorrowerAddress;
//    uint public initialLoan;
//    uint128 public interest;
//    uint256 public loanDuration;
//    uint256 public repaymentInterval;
    constructor(address _LenderAddress,
                address _BorrowerAddress,
                uint _initialLoan,
                uint128 _interest,
                uint256 _loanDuration,
                uint256 _repaymentInterval
){
        borrower.initialise();
        lender.initialise();
    }

}