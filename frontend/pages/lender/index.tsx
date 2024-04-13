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
    <div>
      <Head>
        <title>XRPLendNet</title>
        <meta
          content="Generated by @rainbow-me/create-rainbowkit"
          name="description"
        />
        <link href="/favicon.ico" rel="icon" />
      </Head>

      <main>
        <div className="py-10 bg-slate-400 ">
          <div>
            <div className="content-center content">
              <Link href="/">Home</Link>
              <ConnectButton />
            </div>
            
          </div>
          
        </div>

        <div className="mt-10">
          <p className="mt-5 text-black dark:text-black">
            Create a loan
          </p>
          <div className="flex flex-wrap gap-5">
            <input
              value={borrower}
              onChange={(e) => setBorrower(e.target.value)}
              type="text"
              placeholder="Enter borrower address (0x...)"
              className="placeholder-gray-300 flex rounded-full border-black bg-slate-400 px-20 py-2.5 text-black duration-300 ease-in-out"
            />
            <input
              value={amount}
              onChange={(e) => setAmount(e.target.value)}
              type="text"
              placeholder="Enter loan value in XRP"
              className="placeholder-gray-300 flex rounded-full border-black bg-slate-400 px-10 py-2.5 text-black duration-300 ease-in-out"
            />
            <input
              value={interest}
              onChange={(e) => setInterest(e.target.value)}
              type="text"
              placeholder="Enter percent interest"
              className="placeholder-gray-300 flex rounded-full border-black bg-slate-400 px-10 py-2.5 text-black duration-300 ease-in-out"
            />
            <input
              value={term}
              onChange={(e) => setTerm(e.target.value)}
              type="text"
              placeholder="Enter term in days"
              className="placeholder-gray-300 flex rounded-full border-black bg-slate-400 px-10 py-2.5 text-black duration-300 ease-in-out"
            />
            <button
              onClick={handleCreateLoanSubmit}
              aria-label="button"
              className="flex rounded-full border-black bg-slate-400 px-10 py-2.5 text-black duration-300 ease-in-out"
            >
              Submit
            </button>
          </div>
        </div>
      </main>
    </div>
  );
};

export default Home;
