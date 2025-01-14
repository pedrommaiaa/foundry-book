// SPDX-License-Identifier: UNLICENSED
// ANCHOR: all
// ANCHOR: prelude
pragma solidity 0.8.10;

import "ds-test/test.sol";

error Unauthorized();
// ANCHOR_END: prelude

// ANCHOR: contract
contract OwnerUpOnly {
    address public immutable owner;
    uint256 public count;

    constructor() {
        owner = msg.sender;
    }

    function increment() external {
        if (msg.sender != owner) {
            revert Unauthorized();
        }
        count++;
    }
}
// ANCHOR_END: contract

// ANCHOR: cheatcodes
interface CheatCodes {
    // ANCHOR: cheat_prank
    function prank(address) external;
    // ANCHOR_END: cheat_prank
    // ANCHOR: cheat_expectrevert
    function expectRevert(bytes4) external;
    // ANCHOR_END: cheat_expectrevert
}
// ANCHOR_END: cheatcodes

// ANCHOR: test
// ANCHOR: contract_prelude
contract OwnerUpOnlyTest is DSTest {
    OwnerUpOnly upOnly;
// ANCHOR_END: contract_prelude
    // ANCHOR: cheats
    CheatCodes cheats = CheatCodes(HEVM_ADDRESS);
    // ANCHOR_END: cheats

    // ANCHOR: simple_test
    function setUp() public {
        upOnly = new OwnerUpOnly();
    }

    function testIncrementAsOwner() public {
        assertEq(upOnly.count(), 0);
        upOnly.increment();
        assertEq(upOnly.count(), 1);
    }
    // ANCHOR_END: simple_test

    // ANCHOR: test_fail
    function testFailIncrementAsNotOwner() public {
        cheats.prank(address(0));
        upOnly.increment();
    }
    // ANCHOR_END: test_fail

    // ANCHOR: test_expectrevert
    // Notice that we replaced `testFail` with `test`
    function testIncrementAsNotOwner() public {
        cheats.expectRevert(Unauthorized.selector);
        cheats.prank(address(0));
        upOnly.increment();
    }
    // ANCHOR_END: test_expectrevert
}
// ANCHOR_END: test
// ANCHOR_END: all
