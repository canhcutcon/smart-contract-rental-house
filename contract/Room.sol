// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IRoom} from "../interfaces/IRoom.sol";
abstract contract RoomRental is IRoom{
    uint256 public roomId;
    mapping(uint256 => Room) private _rooms;

    function setRoomForRent(uint256 rentAmountPerMonth,uint256 depositAmount) public {
        string[] memory invoices;
        _rooms[roomId] = Room(
            "contract",
            invoices,
            rentAmountPerMonth,
            depositAmount,
            payable(msg.sender),
            payable(address(0)),
            false,
            true
        );
        emit SetRoomForRent(roomId);
        roomId++;
    }

    function signForRental(uint256 roomUid, string memory contractHash) payable public {
        require(msg.value >= _rooms[roomUid].rentAmountPerMonth + _rooms[roomUid].depositAmount, '!balance for sign');

        _rooms[roomUid].signed = true;
        _rooms[roomUid].contractHash = contractHash;
        _rooms[roomUid].renter = payable(msg.sender);
        _rooms[roomUid].owner.transfer(_rooms[roomUid].rentAmountPerMonth);

        emit RentStarted(roomUid, _rooms[roomUid].renter,contractHash, _rooms[roomUid].rentAmountPerMonth, _rooms[roomUid].depositAmount);
    }


    function payForRent(uint256 roomUid, string memory invoiceHash, uint256 invoiceFee) payable public {
        require(_rooms[roomUid].forRent,'room not available' );
        require(msg.sender == _rooms[roomUid].renter, '!renter');
        require(msg.value >= _rooms[roomUid].rentAmountPerMonth, '!balance for rent');

        _rooms[roomUid].invoices.push(invoiceHash);
        emit PayForRent(roomUid, invoiceHash, invoiceFee);
    }

    
}