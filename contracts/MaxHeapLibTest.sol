// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import { MaxHeapLib } from "./MaxHeapLib.sol";

contract HeapLibTest {
    using MaxHeapLib for MaxHeapLib.MaxHeap;

    MaxHeapLib.MaxHeap private maxHeap;

    function push(uint256 val) external {
        maxHeap.push(val);
    }

    function pop() external {
        maxHeap.pop();
    }

    function getFirst() external view returns (uint256, bool) {
        return maxHeap.getFirst();
    }

    function getValues() external view returns (uint256[] memory values) {
        return maxHeap.getValues();
    }
}
