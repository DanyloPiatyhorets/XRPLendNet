// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import "backend/contracts/Lender.sol";

contract Borrower is ERC721, ERC721Pausable{
    address constant token = 0xe469c4473af82217B30CF17b10BcDb6C8c796e75;

    uint256 private paymentAmount;
    uint256 private amountPaid;

    Lender private creditorContract;

    uint256 lenderID;

    uint256[] proposedCollateralIDs;

    constructor(Lender l, uint256 pA)
        ERC721("Lend Net Debt", "LND")
    {
        amountPaid = 0;
        creditorContract = l;
        paymentAmount = pA;
    }

    // make interval payment
    function makePayment() public returns (bool){
        amountPaid += paymentAmount;
        return IERC20(token).transferFrom(msg.sender, ownerOf(lenderID), paymentAmount);
    }

    // overpay
    function MakePayment(uint256 amount) public returns (bool){
        if(amount < paymentAmount){ return false;}
        else{
            amountPaid += amount;
            PaidInFull();
            return IERC20(token).transferFrom(msg.sender, ownerOf(lenderID), amount);
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
        bool owned = true;
        for(uint256 i = 0; i < collat.length; i++){
            if(ownerOf(collat[i]) != msg.sender) owned = false;
        }
        require(owned == true, "you must own NFTs you put up for collateral");

        setApprovalForAll(address(creditorContract), true);
        proposedCollateralIDs = collat;
    }

    function GetAmountPaid() public view returns (uint256){
        return amountPaid;
    }
}
