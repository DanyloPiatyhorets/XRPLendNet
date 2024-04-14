import { Abi } from "viem";

export const configAbi = [
    {
        "inputs": [],
        "stateMutability": "nonpayable",
        "type": "constructor"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "principal",
                "type": "uint256"
            },
            {
                "internalType": "uint256",
                "name": "term",
                "type": "uint256"
            },
            {
                "internalType": "uint256",
                "name": "interval",
                "type": "uint256"
            },
            {
                "internalType": "uint32",
                "name": "interest",
                "type": "uint32"
            },
            {
                "internalType": "address",
                "name": "lenderAddress",
                "type": "address"
            },
            {
                "internalType": "address",
                "name": "borrowerAddress",
                "type": "address"
            }
        ],
        "name": "CreateLoan",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "GetLoans",
        "outputs": [
            {
                "internalType": "address[]",
                "name": "",
                "type": "address[]"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    }
] as Abi;