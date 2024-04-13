import { ConnectButton } from '@rainbow-me/rainbowkit';
import type { NextPage } from 'next';
import Head from 'next/head';
import { useEffect, useState } from "react";

import Link from 'next/link'

const Home: NextPage = () => {
  const [borrower, setBorrower] = useState("");
  const [amount, setAmount] = useState("");
  const [interest, setInterest] = useState("");
  const [term, setTerm] = useState("");

  

  const handleCreateLoanSubmit = async () => {
    
  }

  return (
      <div className="min-h-screen flex flex-col">
        <Head>
          <title>XRPLendNet</title>
          <meta
              content="Generated by @rainbow-me/create-rainbowkit"
              name="description"
          />
          <link href="/favicon.ico" rel="icon"/>
        </Head>

        <main className="flex-grow">
          <div className="py-10 bg-blue-300 pl-auto pr-10">
            <div className="flex justify-end">
              <div className="mr-30">
                <ConnectButton/>
              </div>
            </div>
          </div>
          <div className="flex justify-center items-center">
            <div className="border border-blue-700 border-2 p-4 text-center italic rounded-lg mt-10">
              <p className="text-blue-900 text-3xl mb-10 font-bold">Create a loan</p>
              <div className="flex flex-col gap-5">
                <div className="flex">
                  <input
                      value={borrower}
                      onChange={(e) => setBorrower(e.target.value)}
                      type="text"
                      placeholder="Enter borrower address"
                      className="flex rounded-full border-black bg-blue-500 px-10 py-2.5 duration-300 ease-in-out placeholder-blue-200 text-xl text-white "
                  />
                </div>
                <div className="flex">
                  <input
                      value={amount}
                      onChange={(e) => setAmount(e.target.value)}
                      type="number"
                      placeholder="Enter loan value in XRP"
                      className="flex rounded-full border-black bg-blue-500 px-10 py-2.5 duration-300 ease-in-out placeholder-blue-200 text-xl text-white"
                  />
                </div>
                <div className="flex">
                  <input
                      value={interest}
                      onChange={(e) => setInterest(e.target.value)}
                      type="number"
                      placeholder="Enter percent interest"
                      className="flex rounded-full border-black bg-blue-500 px-10 py-2.5 duration-300 ease-in-out placeholder-blue-200 text-xl text-white"
                  />
                </div>
                <div className="flex">
                  <input
                      value={term}
                      onChange={(e) => setTerm(e.target.value)}
                      type="number"
                      placeholder="Enter term in days"
                      className="flex rounded-full border-black bg-blue-500 px-10 py-2.5 duration-300 ease-in-out placeholder-blue-200 text-xl text-white"
                  />
                </div>
                <div className="flex">
                  <button
                      onClick={handleCreateLoanSubmit}
                      aria-label="button"
                      className="flex rounded-full border-black bg-blue-500 px-10 py-2.5 duration-300 ease-in-out text-white text-xl"
                  >
                    Submit
                  </button>
                </div>
              </div>
            </div>
          </div>
        </main>
        <footer>
          <div className="py-5 bg-blue-300">
            <a href="https://rainbow.me" rel="noopener noreferrer" target="_blank"
               className="text-blue-900 flex justify-center">
              Made with ❤️ by your friends at #60DaysofXRPL London 😎
            </a>
          </div>
        </footer>
      </div>
  );
};

export default Home;
