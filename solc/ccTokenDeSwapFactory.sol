//SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;
pragma experimental SMTChecker;
import "./Claimable.sol";
import "./CanReclaimToken.sol";
import "./ccTokenDeSwap.sol";
import "./TransparentUpgradeableProxy.sol";

contract ccTokenDeSwapFactory is Claimable, CanReclaimToken {
    mapping(bytes32 => address) public deSwaps;

    function getDeSwap(string memory _nativeCoinType)
        public
        view
        returns (address)
    {
        bytes32 nativeCoinTypeHash =
            keccak256(abi.encodePacked(_nativeCoinType));
        return deSwaps[nativeCoinTypeHash];
    }

    function deployDeSwap(
        address _cctoken,
        string memory _nativeCoinType,
        address _cctokenRepository,
        address _operator
    ) public onlyOwner returns (bool) {
        bytes32 nativeCoinTypeHash =
            keccak256(abi.encodePacked(_nativeCoinType));
        require(_operator!=_owner(), "owner same as _operator");
        require(deSwaps[nativeCoinTypeHash] == (address)(0), "deEx exists.");
        ccTokenDeSwap cctokenDeSwap = new ccTokenDeSwap();
        TransparentUpgradeableProxy proxy =
            new TransparentUpgradeableProxy(
                (address)(cctokenDeSwap),
                (address)(this),
                abi.encodeWithSignature(
                    "setup(address,string,address,address)",
                        _cctoken,
                    _nativeCoinType,
                        _cctokenRepository,
                    _operator
                )
            );

        proxy.changeAdmin(_owner());
        deSwaps[nativeCoinTypeHash] = (address)(proxy);

        return true;
    }
}
