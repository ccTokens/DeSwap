# Addresses and Guidelines
M-Tokens Express provides an almost decentralized way for users to get M-Tokens and reverse operation. The users can get M-Tokens and redeem the native tokens seamlessly with their decentralized wallets. The whole process is very simple and just like normal transactions. 

M-Tokens Express adapts smart contracts on Ethereum to make the transaction can be verified on chain. In the case of Sending BTC/Receiving MBTC, when M-Tokens Express transfers MBTC to users, it will call the smart contract to input the users’ account(wallet) address and the BTC deposit transaction ID. In the opposite case, when users transfer MBTC to M-Tokens Express, the relevant information is recorded on-chain simultaneously. 

## Owner(to be added)
**[xxxxxx](https://) 

## Smart contracts( to be added)
**MTokenDeSwapFactory is [xxxxxx](https://)  

**TransparentUpgradeableProxy is [xxxxxx](https://)  

**MTokenDeSwap is [xxxxxx](https://)  

The third-party audit report can be found [here](http://). （To be added)

**The following workflow takes exchange between BTC and MBTC as an example to show the process, while other business flow remains consistent. M-Tokens Express requires the users to connect the wallet first to start the transaction.

## Send BTC/Receive MBTC
Users request the transaction with sent amount, received amount, ETH destination address. Requests must be signed with the users’ wallet. After that, the M-Tokens Express will generate an order and an unique BTC deposit address for the users. The BTC deposit address and users’ wallet are one-to-one correspondence. Then, the user deposits BTC to the address with the accurate amount, otherwise, the system can not match the order with the deposit transaction, the order will not be able to execute the subsequent process. 

After the BTC transaction is confirmed on chain and gets the minimum number of confirmations. M-Tokens Express system will transfer the MBTC to the user’s ETH destination address by calling the `function swap` with the inputs of transaction details, such as the user's ETH address, BTC deposit transaction ID, the signature of order and so on. 

**Note:
*Any BTC deposit amount which is more than minimal deposit amount and not equal to the existing order, the system will create a new unsigned order. Users can get the corresponding amount of MBTC after signing with the wallet.
*Please deposit BTC within 24 HOURS after the order is created, otherwise the order will expire.

## Send MBTC/Receive BTC
Users request the transaction with sent amount, received amount, BTC destination address. The users’ wallet will call the `function unWrap` to trigger the exchange. Before it, the users must first approve the M-Tokens Express to transfer the MBTC in the wallet, and confirm the transaction. 

When the transaction is pending, the user can cancel the transaction by calling the `function cancelUnWrapOrder`.

After the MBTC transaction gets the minimum number of confirmations on chain. M-Tokens Express system will transfer the BTC to the user’s BTC destination address. Then, M-Tokens Express system calls the `function finishUnWrapOrder` with BTC transaction ID to finish the order.
