// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IRoom} from "../interfaces/IRoom.sol";
import {TransferAction} from "../libraries/contanst.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

abstract contract RoomRental is IRoom, Ownable{
    uint256 public roomId;
    mapping(uint256 => Room) private _rooms;

    function setRoomForRent(uint256 _rentAmountPerMonth,uint256 _depositAmount, address payable _owner) public onlyOwner{
        string[] memory invoices;
        _rooms[roomId] = Room(
            "contract",
            invoices,
            _rentAmountPerMonth,
            _depositAmount,
            _owner,
            payable(address(0)),
            false,
            true
        );
        emit SetRoomForRent(roomId, _owner);
        roomId++;
    }

    function signForRental(uint256 roomUid, string memory contractHash) payable public {
        require(msg.value >= _rooms[roomUid].rentAmountPerMonth + _rooms[roomUid].depositAmount, '!balance for sign');

        _rooms[roomUid].signed = true;
        _rooms[roomUid].contractHash = contractHash;
        _rooms[roomUid].renter = payable(msg.sender);
        _rooms[roomUid].owner.transfer(_rooms[roomUid].rentAmountPerMonth);

        emit TransferBalance(_rooms[roomUid].renter, _rooms[roomUid].owner, _rooms[roomUid].rentAmountPerMonth, TransferAction.Sign);
        emit RentStarted(roomUid, _rooms[roomUid].renter,contractHash, _rooms[roomUid].rentAmountPerMonth, _rooms[roomUid].depositAmount);
    }


    function payForRent(uint256 roomUid, string memory invoiceHash, uint256 invoiceFee) payable public {
        require(_rooms[roomUid].forRent,'room not available' );
        require(msg.sender == _rooms[roomUid].renter, '!renter');
        require(msg.value >= _rooms[roomUid].rentAmountPerMonth, '!balance for rent');

        _rooms[roomUid].invoices.push(invoiceHash);
        _rooms[roomUid].owner.transfer(invoiceFee);

        emit TransferBalance(_rooms[roomUid].renter, _rooms[roomUid].owner, invoiceFee, TransferAction.PayForRent);
        emit PayForRent(roomUid, invoiceHash, invoiceFee);
    }

    function endRentalRoom(uint256 roomUid) payable public {
        require(msg.sender == _rooms[roomUid].owner, '!owner');
        require(!_rooms[roomUid].forRent, '!room available' );

        _rooms[roomUid].signed = false;
        _rooms[roomUid].contractHash = "";
        _rooms[roomUid].renter = payable(address(0));
        _rooms[roomUid].renter.transfer(_rooms[roomUid].depositAmount);

        emit TransferBalance(address(this), _rooms[roomUid].renter, _rooms[roomUid].depositAmount, TransferAction.Receive);
        emit RentEnded(roomUid, _rooms[roomUid].depositAmount);
    }

    function endRentalRoomWithPenaltyFee(uint256 roomUid, uint256 penaltyFee) payable public{
        require(msg.sender == _rooms[roomUid].owner && msg.sender == _rooms[roomUid].renter, '!no access');

        _rooms[roomUid].signed = false;
        _rooms[roomUid].contractHash = "";
        _rooms[roomUid].renter = payable(address(0));
        
        if(msg.sender == _rooms[roomUid].renter) {
             _rooms[roomUid].owner.transfer(_rooms[roomUid].depositAmount);
            emit TransferBalance(address(this), _rooms[roomUid].owner, _rooms[roomUid].depositAmount, TransferAction.Receive);
            emit RentEnded(roomUid, _rooms[roomUid].depositAmount);
        }else{
             _rooms[roomUid].renter.transfer(_rooms[roomUid].depositAmount + penaltyFee);
            emit TransferBalance(address(this), _rooms[roomUid].renter, _rooms[roomUid].depositAmount + penaltyFee, TransferAction.Receive);
            emit RentEnded(roomUid, _rooms[roomUid].depositAmount + penaltyFee);
        }
    }

    function reOpenRentRoom(uint256 roomUid,uint256 rentAmountPerMonth,uint256 depositAmount) public {
        require(msg.sender == _rooms[roomUid].owner, "!owner");
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

        emit ReOpen(roomUid,rentAmountPerMonth,depositAmount);
    }

    function extendRentalRoom(uint256 roomUid, string memory contractHash) public {
        require(msg.sender == _rooms[roomUid].owner, "!owner");
        _rooms[roomUid].contractHash = contractHash;

        emit ExtendRentalRoom(roomUid, contractHash);
    }
    
    function invoicesHistory(uint256 roomUid) public view returns(string[] memory){
        return _rooms[roomUid].invoices;
    }

}