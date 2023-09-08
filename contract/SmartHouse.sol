// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IRoom} from "../interfaces/IRoom.sol";
abstract contract SmartHouseContract is IRoom{
    uint256 public roomId;
    mapping(uint256 => Room) public rooms;
    constructor(){}
}