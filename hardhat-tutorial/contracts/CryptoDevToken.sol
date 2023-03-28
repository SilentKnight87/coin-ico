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
    // Mapping top keep track of which tokenIds have been claimed
    mapping(unint256 => bool) public tokenIdsClaimed;

    constructor(address _cryptoDevsContract) ERC20("Crypto Dev Token", "CD") {
        CryptoDevsNFT = ICryptoDevs(_cryptoDevsContract);

    }

    /**
    * @dev mints `amount` number of CryptoDevTokens
    * Rerquirements:
    *  - `msg.value` should be equal or greater than the tokenPrice & amount
     */
     function mint()








}

