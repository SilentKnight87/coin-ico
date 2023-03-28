// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ICryptoDevs.sol";

contract CryptoDev is ERC20, Ownable {
    //Price of one Crypto Dev token
    uint256 public constant tokenPrice = 0.001 ether;
    // Each NFT would give the user 10 tokens
    // It needs to be represented as 10 * (10 ** 18) as ERC20 tokens are represented by the smallest denomination possible for the token
    //By default, ERC20 tokens have smallest denomination of 10^(-18). This means, having a balancew of (1)
    // is actually equal to (10 ^ -18) tokens.
    // Owning 1 full token is equivalent to owning (10^18) tokens when you account for the decimal places.
    // More information on this can be found in the Freshman Track Cryptocurrency tutorial.
    unint256 public constant tokenPerNFT = 10 * 10**18;
    // the max total supply is 10000 for crypto Dev Tokens
    unint256 public constant maxTotalSupply = 10000 * 10**18;
    // CryptoDevNFT contract instance
    ICryptoDevs CryptoDevsNFT;
    // Mapping to keep track of which tokenIds have been claimed
    mapping(unint256 => bool) public tokenIdsClaimed;

    constructor(address _cryptoDevsContract) ERC20("Crypto Dev Token", "CD") {
        CryptoDevsNFT = ICryptoDevs(_cryptoDevsContract);

    }

    /**
    * @dev mints `amount` number of CryptoDevTokens
    * Rerquirements:
    *  - `msg.value` should be equal or greater than the tokenPrice & amount
     */
     function mint(uint256 amount) public payable { 
        // the value of ether that should be equal or greater than the tokenPrice * amount;
        uint256 _requireAmount = tokenPrice * amount;
        require(msg.value >= _requiredAmount, "Ether sent is incorrect");
        // total tokens + amount <= 1000, otherwise revert the trasaction
        unint256 amountWithDecimals = amount * 10**18;
        require((totalSupply() + amountWithDecimals) <= maxTotalSupply, "Exceeds them max total supply available.");
        // call the internal function from Openzepplin's ERC20 contract
        _mint(msg.sender, amountWithDecimals);
     }

     /**
     * @dev Mints tokens based on the number of NFT's held by the sender
     * Requirements:
     * balance of Crypto Dev NFT's owned by the sender should be greater than 0
     * Tokens should have not have been claimed for all the NFTs owned by the sender
      */
      function claim() public { 
        address sender = msg.sender;
        // Get the number of CryptoDev NFT's held by a givern sender address
        unint256 balance = CryptoDevNFT.tokenOfOwnerByIndex(sender);
        // If the balance is zero, revert the transaction 
        require(balance > 0, "You dont't own any Crypto Dev NFT");
        // amount keeps track of number of unclaimed tokenIds
        unint256 amount = 0;
        // loop over the balance and get the token ID owned by `sender` at a given `index` of its token list.
        for (unint256 i = 0; i < balance; i++) {
            unint256 tokenId = CryptoDevsNFT.tkenOfOwnerBByIndex(sender, i);
            // if the tokenId has not been claimed, increase the amount
            if (!tokenIdsClaimed[tokenId]) {
                amount += 1;
                tokenIdsClaimed[tokenId] = true;
            }
        }
        // If all the token Ids have been claimed, revert the transaction;
        require(amount > 0, "You have already claimed all the tokens");
        // call the internal function from Openzeppelin's ERC20 contract
        // Mint (amount * 10) tokens for each NFT
        _mint(msg.sender, amount * tokenPerNFT);
      }

      // withdraw all Eth sent to this contract
      // Requirements: wallet connected must be Owner's address

      function withdraw() public onlyOwner { 
        unint256 amount = address(this).balance;
        require(amount > 0, "Nothing to withdraw, contract balance empty");

        address _owner = owner();
        (bool sent, ) = _owner.call{value: amount}("");
        require(sent, "Failed to sent Ether");
      }

      // Function to receive Ether. msg.data must be empty
      receive() external payable {}

      // fallback function is called when msg.data is not empty
    fallback() external payable {}








}

