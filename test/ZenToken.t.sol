// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {Test} from "forge-std/Test.sol";
import {ZenToken} from "../src/ZenToken.sol";

contract ZenTokenTest is Test {
    ZenToken token;
    address bob = address(0xBEEF); //200
    address alice = address(0xDEAD);// 300
    function setUp() public{
        token = new ZenToken(1000 ether);
        token.transfer(bob, 200 ether);
        token.transfer(alice, 300 ether);
    }
    function testInitialSupply() public view{
        assertEq(token.totalSupply(),1000 ether);
        assertEq(token.balanceOf(address(this)),500 ether);
    }
    function testTransferForSuccess() public{
        vm.prank(alice);
        token.transfer(bob, 100 ether);
        assertEq(token.balanceOf(alice),200 ether);
        assertEq(token.balanceOf(bob),300 ether);
    }
    function testTransferFail() public{
        vm.prank(alice);
        vm.expectRevert();
        token.transfer(bob, 400 ether);
    }
    function testAllowance() public{
        vm.prank(alice);
        token.approve(bob,50 ether);
        assertEq(token.allowance(alice,bob),50 ether);
    }
    function testAllowanceOverWrite() public{
        vm.startPrank(bob);
        token.approve(alice,50 ether);
        token.approve(alice,100 ether);
        vm.stopPrank();
        assertEq(token.allowance(bob,alice),100 ether);
    }
}