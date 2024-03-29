import { expect } from "chai";
import { ethers } from "hardhat";
import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";

describe("MaxHeap unit tests", function () {
  async function deployFixture() {
    const h = await ethers.deployContract("HeapLibTest");
    await h.waitForDeployment();
    return { h };
  }

  describe("Push", function () {
    it("Should push new node", async function () {
      const { h } = await loadFixture(deployFixture);

      for (let i = 1n; i <= 10n; i++) {
        await h.push(i);
        console.log(await h.getFirst());
      }

      await h.push(5);
      console.log(await h.getFirst());

      await h.push(6);
      console.log(await h.getFirst());

      const values = await h.getValues();
      console.log(values);
    });
  });

  describe("Pop", function () {
    it("Should pop node", async function () {
      const { h } = await loadFixture(deployFixture);

      for (let i = 1n; i <= 10n; i++) {
        await h.push(i);
      }

      await h.push(5);
      await h.push(6);

      for (let i = 1n; i <= 12n; i++) {
        console.log(await h.getFirst());
        await h.pop();
      }
      console.log(await h.getFirst());
    });
  });
});
