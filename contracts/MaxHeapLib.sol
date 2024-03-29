// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

library MaxHeapLib {
    struct MaxHeap {
        uint256[] heap;
    }

    function push(MaxHeap storage self, uint256 val) internal {
        uint256 idx = self.heap.length;
        self.heap.push(val);
        if (idx == 0) {
            return;
        }

        while (idx > 0 && self.heap[idx] > self.heap[_parent(idx)]) {
            (self.heap[idx], self.heap[_parent(idx)]) = (self.heap[_parent(idx)], self.heap[idx]);
            idx = _parent(idx);
        }
    }

    function pop(MaxHeap storage self) internal {
        require(self.heap.length > 0, "Heap: heap is empty");

        if (self.heap.length == 1) {
            self.heap.pop();
            return;
        }

        self.heap[0] = self.heap[self.heap.length - 1];
        self.heap.pop();

        uint256 idx = 0;
        uint256 childIdx = 0;
        uint256 childVal = 0;
        (childIdx, childVal) = _biggestChild(self.heap, idx);
        while (self.heap[idx] < childVal) {
            (self.heap[idx], self.heap[childIdx]) = (childVal, self.heap[idx]);
            idx = childIdx;
            (childIdx, childVal) = _biggestChild(self.heap, idx);
        }
    }

    function getFirst(MaxHeap storage self) internal view returns (uint256, bool) {
        if (self.heap.length > 0) {
            return (self.heap[0], true);
        }
        return (0, false);
    }

    function getValues(MaxHeap storage self) internal view returns (uint256[] memory values) {
        return self.heap;
    }

    function _parent(uint256 idx) private pure returns (uint256) {
        require(idx > 0, "zero index");
        return (idx - 1) / 2;
    }

    function _left(uint256 idx) private pure returns (uint256) {
        return (idx * 2) + 1;
    }

    function _right(uint256 idx) private pure returns (uint256) {
        return (idx * 2) + 2;
    }

    function _biggestChild(uint256[] memory heap, uint256 idx) private pure returns (uint256, uint256) {
        uint256 leftIdx = _left(idx);
        if (leftIdx >= heap.length) {
            return (0, 0);
        }
        uint256 leftVal = heap[leftIdx];

        uint256 rightIdx = _right(idx);
        if (rightIdx >= heap.length) {
            return (leftIdx, leftVal);
        }
        uint256 rightVal = heap[rightIdx];

        if (leftVal > rightVal) {
            return (leftIdx, leftVal);
        }
        return (rightIdx, rightVal);
    }
}
