import { ConnectButton } from '@rainbow-me/rainbowkit';
import type { NextPage } from 'next';
import Head from 'next/head';
import { useEffect, useState } from "react";
import Link from "next/link";

const Home: NextPage = () => {
  const [borrower, setBorrower] = useState("");
  const [amount, setAmount] = useState("");

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
            <div className="text-5xl text-center">
              <p className="mt-10 text-blue-900">XRPLendNet</p>
            </div>
          </div>
          <div className="flex justify-center items-center">
            <div className="border border-blue-700 border-2 p-4 text-center italic rounded-lg mt-10">
              <p className="text-blue-900 text-lg">Create, track, trade and pay off your loans</p>
            </div>
          </div>
          <div className="mt-20">
            <div className="flex justify-center gap-40 mt-50">
              <Link
                  href="/lender"
                  aria-label="button"
                  className="flex rounded-full border-black bg-blue-500 px-10 py-2.5 duration-300 ease-in-out text-white text-xl "
              >
                Create
              </Link>

              <Link
                  href="/borrower"
                  aria-label="button"
                  className="flex rounded-full border-black bg-blue-500 px-10 py-2.5 duration-300 ease-in-out text-white text-xl"
              >
                Find
              </Link>

            </div>
          </div>
        </main>

        
      </div>
  );
};

export default Home;
