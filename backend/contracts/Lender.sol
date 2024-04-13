// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";

contract Lender is ERC721, ERC721Pausable, Ownable, ERC721Burnable {

    uint256 principal; // Amount of XRP lent in drop
    uint32 interest; // % interest between 0 and 1000
    
    uint256 term; // maximum time until loan fully repaid
    uint256 interval; // the time between each repayment



    address borrowerID; // not used at the moment
    address[] collateralIDs;


    constructor(address borrower, address lender)
        ERC721("Lend Net Credit", "LNC")

        

    {}

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
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
}
