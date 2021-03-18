# M-Tokens Express Guidelines
M-Tokens Express provides an almost decentralized way and adapts smart contracts on Ethereum for users to get M-Tokens and reverse operation. The users can get M-Tokens and redeem the native tokens seamlessly with their decentralized wallets, transactions can be verified on chain. The whole process is very simple and likes normal transactions. 

The third-party audit report of smart contracts can be found [here](http://). （To be added)

The following workflow takes exchange between BTC and MBTC as an example to show the process, while other swap pairs' workflow remains consistent. M-Tokens Express requires the users to connect the wallet first to start the transaction.

## Wrap -Send BTC/Receive MBTC
Users request the transaction with the sent amount, received amount, ETH destination address. Requests must be signed with the users’ wallet. After that, the M-Tokens Express will generate an order and a unique BTC deposit address for the users. The BTC deposit address and users’ wallets are one-to-one correspondence. Then, the user deposits BTC to the address with the accurate amount, otherwise, the system can not match the order with the deposit transaction, the order will not be able to execute the subsequent process. 

Once the BTC transaction has been sufficiently confirmed by the Bitcoin chain. M-Tokens Express will transfer the MBTC to the user’s ETH destination address by calling the `function Wrap` with the inputs of transaction details, such as the user's ETH address, BTC deposit transaction ID, the signature of order, and so on. 

**Note:**
* For any BTC deposit amount which is more than a minimal deposit amount and not equal to the existing order, the system will create a new unsigned order. Users can get the corresponding amount of MBTC after signing with the wallet.
* Please deposit BTC within 24 HOURS after the order is created, otherwise, the order will expire.

## Unwrap-Send MBTC/Receive BTC
Users request the transaction with a sent amount, received amount, BTC destination address. The users’ wallet will call the `function unWrap` to trigger the exchange. Before it, the users must first approve the M-Tokens Express to transfer the MBTC in the wallet and confirm the transaction. 

When the transaction is pending, the user can cancel the transaction by calling the `function cancelUnWrapOrder`.

Once the MBTC transaction gets a sufficient number of confirmations on the Ethereum chain. M-Tokens Express will transfer the BTC to the user’s BTC destination address. Then, M-Tokens Express calls the `function finishUnWrapOrder` with BTC transaction ID to finish the order.
