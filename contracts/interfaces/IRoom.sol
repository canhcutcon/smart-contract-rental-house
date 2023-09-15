// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {TransferAction} from "../libraries/contanst.sol";

interface IRoom {
    event SetRoomForRent(uint256 _roomId, address _owner, string roomInfo);
    event RentStarted(
        uint256 _roomId,
        address renter,
        string _contractHash,
        uint256 _rentAmount,
        uint256 _deposit
    );
    event PayForRent(uint256 _roomId, string _invoiceHash, uint256 invoiceFee);
    event RentEnded(uint256 _roomId, uint256 depositAmount);
    event EndRentWithPenalty(uint256 _roomId, uint256 penaltyFee);
    event ReOpen(
        uint256 _roomId,
        uint256 _rentAmountPerMonth,
        uint256 _depositAmount
    );
    event ExtendRentalRoom(uint256 _roomId, string _contractHash);
    event TransferBalance(
        address from,
        address to,
        uint256 amount,
        TransferAction action
    );

    struct Room {
        string contractHash;
        string[] invoices;
        uint256 rentAmountPerMonth;
        uint256 depositAmount;
        address payable owner;
        address payable renter;
        bool signed;
        bool forRent;
    }

    function setRoomForRent(
        uint256 _rentAmountPerMonth,
        uint256 _depositAmount,
        address payable _owner, 
        string memory roomInfo
    ) external;

    function signForRental(
        uint256 roomUid,
        string memory contractHash
    ) external payable;

    function endRentalRoom(uint256 roomUid) external payable;

    function endRentalRoomWithPenaltyFee(
        uint256 roomId,
        uint256 penaltyFee
    ) external payable;

    function reOpenRentRoom(
        uint256 roomUid,
        uint256 _rentAmountPerMonth,
        uint256 _depositAmount
    ) external;

    function extendRentalRoom(
        uint256 roomId,
        string memory _contractHash
    ) external;

    function payForRent(
        uint256 roomId,
        string memory _invoiceHash,
        uint256 invoiceFee
    ) external payable;

    function invoicesHistory(
        uint256 roomUid
    ) external view returns (string[] memory);
}
