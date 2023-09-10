# smart-contract-rental-houseSolidity

API
RoomRental
Contract
RoomRental : smart-contract/contract/Room.sol

Functions:
setRoomForRent
function setRoomForRent(uint256 rentAmountPerMonth, uint256 depositAmount) public
signForRental
function signForRental(uint256 roomUid, string contractHash) public payable
payForRent
function payForRent(uint256 roomUid, string invoiceHash, uint256 invoiceFee) public payable
endRentalRoom
function endRentalRoom(uint256 roomUid) public payable
endRentalRoomWithPenaltyFee
function endRentalRoomWithPenaltyFee(uint256 roomUid, uint256 penaltyFee) public payable
reOpenRentRoom
function reOpenRentRoom(uint256 roomUid, uint256 rentAmountPerMonth, uint256 depositAmount) public
extendRentalRoom
function extendRentalRoom(uint256 roomUid, string contractHash) public
invoicesHistory
function invoicesHistory(uint256 roomUid) public view returns (string[])
inherits IRoom:

Events:
inherits IRoom:

SetRoomForRent
event SetRoomForRent(uint256 \_roomId)
RentStarted
event RentStarted(uint256 \_roomId, address renter, string \_contractHash, uint256 \_rentAmount, uint256 \_deposit)
PayForRent
event PayForRent(uint256 \_roomId, string \_invoiceHash, uint256 invoiceFee)
RentEnded
event RentEnded(uint256 \_roomId, uint256 depositAmount)
EndRentWithPenalty
event EndRentWithPenalty(uint256 \_roomId, uint256 penaltyFee)
ReOpen
event ReOpen(uint256 \_roomId, uint256 \_rentAmountPerMonth, uint256 \_depositAmount)
ExtendRentalRoom
event ExtendRentalRoom(uint256 \_roomId, string \_contractHash)
TransferBalance
event TransferBalance(address from, address to, uint256 amount, enum TransferAction action)
SmartHouseContract
Contract
SmartHouseContract : smart-contract/contract/SmartHouse.sol

Functions:
inherits RoomRental:

setRoomForRent
function setRoomForRent(uint256 rentAmountPerMonth, uint256 depositAmount) public
signForRental
function signForRental(uint256 roomUid, string contractHash) public payable
payForRent
function payForRent(uint256 roomUid, string invoiceHash, uint256 invoiceFee) public payable
endRentalRoom
function endRentalRoom(uint256 roomUid) public payable
endRentalRoomWithPenaltyFee
function endRentalRoomWithPenaltyFee(uint256 roomUid, uint256 penaltyFee) public payable
reOpenRentRoom
function reOpenRentRoom(uint256 roomUid, uint256 rentAmountPerMonth, uint256 depositAmount) public
extendRentalRoom
function extendRentalRoom(uint256 roomUid, string contractHash) public
invoicesHistory
function invoicesHistory(uint256 roomUid) public view returns (string[])
inherits IRoom:

Events:
inherits RoomRental: inherits IRoom:

SetRoomForRent
event SetRoomForRent(uint256 \_roomId)
RentStarted
event RentStarted(uint256 \_roomId, address renter, string \_contractHash, uint256 \_rentAmount, uint256 \_deposit)
PayForRent
event PayForRent(uint256 \_roomId, string \_invoiceHash, uint256 invoiceFee)
RentEnded
event RentEnded(uint256 \_roomId, uint256 depositAmount)
EndRentWithPenalty
event EndRentWithPenalty(uint256 \_roomId, uint256 penaltyFee)
ReOpen
event ReOpen(uint256 \_roomId, uint256 \_rentAmountPerMonth, uint256 \_depositAmount)
ExtendRentalRoom
event ExtendRentalRoom(uint256 \_roomId, string \_contractHash)
TransferBalance
event TransferBalance(address from, address to, uint256 amount, enum TransferAction action)
