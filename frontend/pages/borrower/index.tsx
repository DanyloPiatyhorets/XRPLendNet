import { ConnectButton } from '@rainbow-me/rainbowkit';
import type { NextPage } from 'next';
import Head from 'next/head';
import { useEffect, useState } from "react";
import Link from 'next/link'


const Home: NextPage = () => {
  const [amount, setAmount] = useState("");
  

  const names = ['Ada Lovelace', 'Grace Hopper', 'Margaret Hamilton','dmddm'];

  const [nameMap,setMap]= useState(new Map());

  const addItemToMap = (key: string, value: number) => {
    setMap((prevMap) => new Map(prevMap.set(key, value)));
  };



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

        <div>
        <ul>
        {
        names.map((name) => (
          
          <li>{name}
          <p>Amount due:</p>
          <p>Time till due:</p>
          <p>Total remaining:</p>
          <p>Nft info:</p>
          <p>Owner:</p>
          <input
              value={nameMap.get(name)}
              onChange={(e) => addItemToMap(name,+e.target.value)}
              type="number"
              placeholder="Amount to pay (default to remaining payment)"
              className="w-6/12 placeholder-gray-300 flex rounded-full border-black bg-slate-400 px-20 py-2.5 text-black duration-300 ease-in-out"
            />
          <button className="placeholder-gray-300 flex rounded-full border-black bg-slate-400 px-20 py-2.5 text-black duration-300 ease-in-out">Pay</button>


          </li>
        ))}
      </ul>
        </div>
      </main>
    </div>
  );
};

export default Home;
