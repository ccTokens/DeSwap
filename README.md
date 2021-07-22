# Cross-Chain Tokens Express Guidelines
Cross-Chain Tokens(ccTokens) Express provides an almost decentralized way and adapts smart contracts on Ethereum for users to get ccTokens and reverse operation. The users can get ccTokens and redeem the native tokens seamlessly with their decentralized wallets, transactions can be verified on chain. The whole process is very simple and likes normal transactions. 

The third-party audit report of smart contracts can be found [here](https://www.crosschain.network/PeckShield-Audit-Report-DeSwap-v1.0.pdf). 

The following workflow takes exchange between BTC and ccBTC as an example to show the process, while other swap pairs' workflow remains consistent. ccTokens Express requires the users to connect the wallet first to start the transaction.

## Wrap-send BTC/Receive ccBTC
Users request the transaction with the sent amount, received amount, ETH destination address. Requests must be signed with the users’ wallet. After that, the ccTokens Express will generate an order and a unique BTC deposit address for the users. The BTC deposit address and users’ wallets are one-to-one correspondence. Then, the user deposits BTC to the address with the accurate amount, otherwise, the system can not match the order with the deposit transaction, the order will not be able to execute the subsequent process. 

Once the BTC transaction has been sufficiently confirmed by the Bitcoin chain. ccTokens Express will transfer the ccBTC to the user’s ETH destination address by calling the `function Wrap` with the inputs of transaction details, such as the user's ETH address, BTC deposit transaction ID, the signature of order, and so on. 

**Note:**
* For any BTC deposit amount which is more than a minimal deposit amount and not equal to the existing order, the system will create a new unsigned order. Users can get the corresponding amount of ccBTC after signing with the wallet.
* Please deposit BTC within 24 HOURS after the order is created, otherwise, the order will expire.

## Unwrap-send ccBTC/Receive BTC
Users request the transaction with a sent amount, received amount, BTC destination address. The users’ wallet will call the `function unWrap` to trigger the exchange. Before it, the users must first approve the ccTokens Express to transfer the ccBTC in the wallet and confirm the transaction. 

When the transaction is pending, the user can cancel the transaction by calling the `function cancelUnWrapOrder`.

Once the ccBTC transaction gets a sufficient number of confirmations on the Ethereum chain. ccTokens Express will transfer the BTC to the user’s BTC destination address. Then, ccTokens Express calls the `function finishUnWrapOrder` with BTC transaction ID to finish the order.
