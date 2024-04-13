// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";

contract Lender is ERC721, ERC721Pausable {

    uint256 private principal; // Amount of XRP lent in drop
    uint32 private interest; // % interest between 0 and 1000
    
    uint256 private term; // maximum time until loan fully repaid
    uint256 private interval; // the time between each repayment
    uint256 private originationDate;

    uint256 private paymentAmount;

    address private debtID; // not used at the moment
    address private creditID;
    address[] private collateralIDs;


    constructor(address borrower, address lender)
        ERC721("Lend Net Credit", "LNC")
    {
        
    }

    function PaidInFull(uint256 amountRepaid) public returns(bool){
        if(amountRepaid > principal + principal * (interest / 1000) * ((block.timestamp - originationDate) / 31556952000)){
            _pause();
            return true;
        }
        else { return false; }
    }

    function CheckDefault() public returns(bool){
        if((((block.timestamp - originationDate) / 86400000) / interval) * paymentAmount < ){ return true;}
        else {return false; }
    }

    function SeizeCollateralIfDefault() public returns(bool){
        if(CheckDefault){
            for(int i = 0; i < collateralIDs.length; i++){
                safeTransferFrom(this, ownerOf(creditID), collateralIDs[i]);
            }
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
}
