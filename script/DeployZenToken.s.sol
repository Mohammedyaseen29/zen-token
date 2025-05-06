//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "forge-std/Script.sol";
import {ZenToken} from "../src/ZenToken.sol";


contract DeployZenToken is Script{
    uint constant initialSupply = 1000 ether;
    function run() external{
        vm.startBroadcast();
        new ZenToken(initialSupply);
        vm.stopBroadcast();
        console.log("ZenToken deployed");
    }
}