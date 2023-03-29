import { BigNumber, Contract, providers, utils } from "ethers";
import Head from "next/head"
import React, { useEffect, useRef, useState} from "react";
import Web3Modal from "wweb3modal";
import {
  NFT_CONTRACT_ABI,
  NFT_CONTRACT_ADDRESS,
  TOKEN_CONTRACT_ABI,
  TOKEN_CONTRACT_ADDRESS,
} from "../constants";
import styles from "../styles/Home.module.css"

export default function Home() {
  // Create a bigNumber `0`
  const zero = BigNumber.from(0);
  // walletconnected keeps track of whether the user's wallet is connected or not 
  const [walletConnected, setWalletConnected] = useEffect(false);
  // loading is set to true when we are waiting for a transaction to get mined
  const [loading, setLoading] = useEffect(false);
  // tokensToBeClaimed keeps track of the number of tokens that can be claimed
  // based on the Crypto Dev NFT's held by the user for which they havent claimed the tokens
  const 
}