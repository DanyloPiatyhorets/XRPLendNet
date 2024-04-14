// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import "backend/contracts/Borrower.sol";

contract Lender is ERC721, ERC721Pausable, IERC721Receiver {
    address constant token = 0x1D2F0da169ceB9fC7B3144628dB156f3F6c60dBE;

    uint256 private principal; // Amount of XRP lent in drop
    uint32 private interest; // % interest between 0 and 1000
    
    uint256 private interval; // the time between each repayment
    uint256 private originationDate;

    uint256 private paymentAmount;

    
    Borrower private debtContract;
    uint256 private creditTokenID;
    uint256[] private collateralIDs;


    constructor(uint256 prnc, uint256 term, uint256 itrvl, uint32 intst, address lendAddress, address borrowAddress)
        ERC721("Lend Net Credit", "LNC")
    {
        interest = intst;
        interval = itrvl;
        //originationDate = block.timestamp;

        paymentAmount = prnc / (term / itrvl);
        debtContract = new Borrower(this, paymentAmount, borrowAddress);

        creditTokenID = 1;

        _safeMint(lendAddress, creditTokenID);
    }

    function AcceptLoan() external payable {

        
        (bool success,) = debtContract.GetOwner().call{value: principal}("");
        require(success, "Failed to send Ether");

        originationDate = block.timestamp;

        //sendTokens(debtContract.GetOwner(), address(this), debtContract.GetProposedCollateralIDs());
        
    }


    function PaidInFull(uint256 amountRepaid) external  returns(bool){
        if(amountRepaid > principal + principal * (interest / 1000) * ((block.timestamp - originationDate) / 31556952000)){
            sendCollateral(debtContract.GetOwner());
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
        sendTokens(address(this), recipient, collateralIDs);
    }

    function sendTokens(address sender, address recipient, uint256[] memory tokens) private {
        for(uint i = 0; i < tokens.length; i++){
                safeTransferFrom(sender, recipient, tokens[i]);
        }
    }

    function CheckCollateral() external view returns(uint256[] memory){
        return collateralIDs;
    }

    function CheckProposedCollateral() external view returns(uint256[] memory){
        return debtContract.GetProposedCollateralIDs();
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

    function GetOwner() external view returns (address){
        return ownerOf(creditTokenID);
    }

    function GetDebtContractAddress() external view returns(address){
        return address(debtContract);
    }
}
