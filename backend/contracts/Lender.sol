// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

import "backend/contracts/Borrower.sol";

contract Lender is ERC721, ERC721Pausable, IERC721Receiver {

    uint256 private principal; // Amount of XRP lent in drop
    uint32 private interest; // % interest between 0 and 1000
    
    uint256 private term; // maximum time until loan fully repaid
    uint256 private interval; // the time between each repayment
    uint256 private originationDate;

    uint256 private paymentAmount;

    uint256 private debtTokenID;
    Borrower private debtContract;
    uint256 private creditTokenID;
    uint256[] private collateralIDs;


    constructor(address borrower, address lender)
        ERC721("Lend Net Credit", "LNC")
    {
        
    }

    function PaidInFull(uint256 amountRepaid) external  returns(bool){
        if(amountRepaid > principal + principal * (interest / 1000) * ((block.timestamp - originationDate) / 31556952000)){
            sendCollateral(ownerOf(debtTokenID));
            _pause();
            return true;
        }
        else { return false; }
    }

    function CheckDefault() public view returns(bool){
        if((((block.timestamp - originationDate) / 86400000) / interval) * paymentAmount < debtContract.GetAmountPaid()){ return true; }
        else {return false; }
    }

    function SeizeCollateralIfDefault() public returns(bool){
        if(CheckDefault()){
            sendCollateral(ownerOf(creditTokenID));
            return true;
        }
        else { return false; }
    }

    function sendCollateral(address recipient) private {
        for(uint i = 0; i < collateralIDs.length; i++){
                safeTransferFrom(address(this), recipient, collateralIDs[i]);
        }
    }
    // The following functions are overrides required by Solidity.

    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721, ERC721Pausable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function onERC721Received(address, address, uint256 tokenId, bytes memory) external returns (bytes4){
        collateralIDs.push(tokenId);
        return IERC721Receiver.onERC721Received.selector;
    }
}
