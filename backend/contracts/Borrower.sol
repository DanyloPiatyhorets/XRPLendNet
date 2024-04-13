// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";

contract Borrower is ERC721, ERC721Pausable, ERC721Burnable {
    address constant token = 0xe469c4473af82217B30CF17b10BcDb6C8c796e75;

    uint256 private paymentAmount;
    uint256 private amountPaid;

    uint256 lenderID;

    constructor(address initialOwner)
        ERC721("Lend Net Debt", "LND")
        Ownable(initialOwner)
    {
        amountPaid = 0;
    }

    // make interval payment
    function makePayment() public returns (bool){
        return IERC20.transferFrom(msg.sender, ownerOf(lenderID), paymentAmount);
    }

    // overpay
    function makePayment(uint256 amount) public returns (bool){
        if(amount < paymentAmount){ return false;}
        else{return IERC20.transferFrom(msg.sender, ownerOf(lenderID), amount);}
    }

    function paidInFull() public returns (bool){

    }

    function safeMint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }

    // The following functions are overrides required by Solidity.

    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721, ERC721Pausable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function GetAmountPaid() public returns (uint256){
        return amountPaid;
    }
}
