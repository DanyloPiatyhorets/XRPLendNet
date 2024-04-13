import { ConnectButton } from '@rainbow-me/rainbowkit';
import type { NextPage } from 'next';
import Head from 'next/head';
import styles from '../styles/Home.module.css';
import { useEffect, useState } from "react";

const Home: NextPage = () => {
  const [borrower, setBorrower] = useState("");
  const [amount, setAmount] = useState("");

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
          <div className={styles.container}>
            <div className="content-center content-evenly">
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

      <footer className={styles.footer}>
        <a href="https://rainbow.me" rel="noopener noreferrer" target="_blank">
          Made with ❤️ by your frens at 🌈
        </a>
      </footer>
    </div>
  );
};

export default Home;
