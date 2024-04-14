// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import "backend/contracts/Lender.sol";

contract Borrower is ERC721, ERC721Pausable{
    address constant token = 0x1D2F0da169ceB9fC7B3144628dB156f3F6c60dBE;

    uint256 private paymentAmount;
    uint256 private amountPaid;

    Lender private creditorContract;

    uint256 private borrowerID;

    uint256[] proposedCollateralIDs;

    constructor(Lender l, uint256 pA, address borrowAddress)
        ERC721("Lend Net Debt", "LND")
    {
        amountPaid = 0;
        creditorContract = l;
        paymentAmount = pA;

        borrowerID = 1;

        _safeMint(borrowAddress, borrowerID);
    }

    // make interval payment
    function makePayment() public payable returns (bool){
        (bool success,) = creditorContract.GetOwner().call{value: paymentAmount}("");
        require(success, "Failed to send Ether");
        return success;
    }

    // overpay
    function MakePayment(uint256 amount) public payable returns (bool){
        emit Approval(msg.sender, address(this), amount);
        if(amount < paymentAmount){ return false;}
        else{
            (bool success,) = creditorContract.GetOwner().call{value: amount}("");
            require(success, "Failed to send Ether");
            return success;
        }
    }

    function PaidInFull() public returns (bool){
        return creditorContract.PaidInFull(amountPaid);
    }

    
    // The following functions are overrides required by Solidity.

    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721, ERC721Pausable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function ProposeCollateral(uint256[] memory collat) external returns (bool){
        
        // below does not work as these NFTs are on a different chain
        /*
        bool owned = true;
        for(uint256 i = 0; i < collat.length; i++){
            if(ownerOf(collat[i]) != msg.sender) owned = false;
        }
        require(owned == true, "you must own NFTs you put up for collateral");
        */

        setApprovalForAll(address(creditorContract), true);
        proposedCollateralIDs = collat;
        
        return true;
    }

    function GetAmountPaid() external view returns (uint256){
        return amountPaid;
    }

    function GetProposedCollateralIDs() external view returns (uint256[] memory){
        return proposedCollateralIDs;
    }

    function GetOwner() external view returns (address){
        return ownerOf(borrowerID);
    }
}
