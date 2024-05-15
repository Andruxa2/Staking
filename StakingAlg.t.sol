// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/StakingAlg.sol";
import "../src/Staking.sol";
import "../src/Rewarding.sol";
import "forge-std/console.sol";

contract StakingAlgTest is Test {
    StakingToken public staking;
    RewardingToken public rewarding;
    StakingAlg public stakingAlg;

    address self = address(this);

    function setUp() public {
        staking = new StakingToken();
        rewarding = new RewardingToken();
        stakingAlg = new StakingAlg(address(staking), address(rewarding));
    }

    function testGetReward() public {
        staking.approve(address(stakingAlg), 1000);
        rewarding.transfer(address(stakingAlg), 10000);

        stakingAlg.stake(1000);

        uint currentTimeStamp = block.timestamp;
        vm.warp(currentTimeStamp + 10);
        console.log(stakingAlg.earned(self));
        stakingAlg.withdraw(1000);
        
        console.log(stakingAlg.earned(self));

        stakingAlg.getReward();
    }
}
