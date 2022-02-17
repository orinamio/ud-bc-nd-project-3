// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../coffeeaccesscontrol/FarmerRole.sol";
import "../coffeeaccesscontrol/DistributorRole.sol";
import "../coffeeaccesscontrol/RetailerRole.sol";
import "../coffeeaccesscontrol/ConsumerRole.sol";
import "../coffeecore/Ownable.sol";
import "./Coffee.sol";

// Define a contract 'Supplychain'
contract SupplyChain is
    FarmerRole,
    DistributorRole,
    RetailerRole,
    ConsumerRole,
    Ownable
{
    using Coffee for Data;
    Data private coffee;

    // Define 'owner'
    address owner;

    // Define a variable called 'sku' for Stock Keeping Unit (SKU)
    uint256 sku;

    // Define 8 events with the same 8 state values and accept 'upc' as input argument
    event Harvested(uint256 upc);
    event Processed(uint256 upc);
    event Packed(uint256 upc);
    event ForSale(uint256 upc);
    event Sold(uint256 upc);
    event Shipped(uint256 upc);
    event Received(uint256 upc);
    event Purchased(uint256 upc);

    // Define a modifer that checks to see if msg.sender == owner of the contract
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    // Define a modifer that verifies the Caller
    modifier verifyCaller(address _address) {
        require(msg.sender == _address);
        _;
    }

    // In the constructor set 'owner' to the address that instantiated the contract
    // and set 'sku' to 1
    constructor() payable {
        owner = msg.sender;
        sku = 1;
    }

    // Define a function 'kill' if required
    function kill() public {
        if (msg.sender == owner) {
            selfdestruct(payable(owner));
        }
    }

    // Define a function 'harvestItem' that allows a farmer to mark an item 'Harvested'
    function harvestItem(
        uint256 _upc,
        address _originFarmerID,
        string memory _originFarmName,
        string memory _originFarmInformation,
        string memory _originFarmLatitude,
        string memory _originFarmLongitude,
        string memory _productNotes
    ) public onlyFarmer {
        // Add the new item as part of Harvest
        Item memory item;
        item.sku = sku;
        item.upc = _upc;
        item.ownerID = _originFarmerID;
        item.originFarmerID = _originFarmerID;
        item.originFarmName = _originFarmName;
        item.originFarmInformation = _originFarmInformation;
        item.originFarmLatitude = _originFarmLatitude;
        item.originFarmLongitude = _originFarmLongitude;
        item.itemState = State.Harvested;
        item.productID = sku + _upc;
        item.productNotes = _productNotes;
        coffee.items[_upc] = item;
        // Increment sku
        sku = sku + 1;
        // Emit the appropriate event
        emit Harvested(_upc);
    }

    // Define a function 'processtItem' that allows a farmer to mark an item 'Processed'
    function processItem(uint256 _upc)
        public
        verifyCaller(coffee.getItemOwnerId(_upc))
    {
        require(coffee.harvested(_upc));
        // Update the appropriate fields]
        Item memory item = coffee.getItem(_upc);
        item.itemState = State.Processed;
        coffee.items[_upc] = item;
        // Emit the appropriate event
        emit Processed(_upc);
    }

    // Define a function 'packItem' that allows a farmer to mark an item 'Packed'
    function packItem(uint256 _upc)
        public
        verifyCaller(coffee.getItemOwnerId(_upc))
    {
        require(coffee.processed(_upc));
        // Update the appropriate fields]
        Item memory item = coffee.getItem(_upc);
        item.itemState = State.Packed;
        coffee.items[_upc] = item;
        // Emit the appropriate event
        emit Packed(_upc);
    }

    // Define a function 'sellItem' that allows a farmer to mark an item 'ForSale'
    function sellItem(uint256 _upc, uint256 _price)
        public
        verifyCaller(coffee.getItemOwnerId(_upc))
    {
        require(coffee.packed(_upc));
        // Update the appropriate fields]
        Item memory item = coffee.getItem(_upc);
        item.itemState = State.ForSale;
        item.productPrice = _price;
        coffee.items[_upc] = item;
        // Emit the appropriate event
        emit ForSale(_upc);
    }

    // Define a function 'buyItem' that allows the disributor to mark an item 'Sold'
    // Use the above defined modifiers to check if the item is available for sale, if the buyer has paid enough,
    // and any excess ether sent is refunded back to the buyer
    function buyItem(uint256 _upc) public payable onlyDistributor {
        require(coffee.forSale(_upc)); // is for sale
        require(msg.value >= coffee.items[_upc].productPrice); // checks if the paid amount is sufficient to cover the price
        payable(msg.sender).transfer(
            msg.value - coffee.items[_upc].productPrice
        ); // refund the remaining balance

        // Update the appropriate fields - ownerID, distributorID, itemState
        Item memory item = coffee.getItem(_upc);
        address payable farmerID = payable(item.ownerID);
        item.ownerID = msg.sender;
        item.distributorID = msg.sender;
        item.itemState = State.Sold;

        // Transfer money to farmer
        farmerID.transfer(item.productPrice);

        coffee.items[_upc] = item;
        // emit the appropriate event
        emit Sold(_upc);
    }

    // Define a function 'shipItem' that allows the distributor to mark an item 'Shipped'
    // Use the above modifers to check if the item is sold
    function shipItem(uint256 _upc)
        public
        verifyCaller(coffee.getItemOwnerId(_upc))
        onlyDistributor
    {
        require(coffee.sold(_upc));
        // Update the appropriate fields
        Item memory item = coffee.getItem(_upc);
        item.itemState = State.Shipped;
        coffee.items[_upc] = item;
        // Emit the appropriate event
        emit Shipped(_upc);
    }

    // Define a function 'receiveItem' that allows the retailer to mark an item 'Received'
    // Use the above modifiers to check if the item is shipped
    function receiveItem(uint256 _upc) public onlyRetailer {
        require(coffee.shipped(_upc));
        // Update the appropriate fields - ownerID, retailerID, itemState
        Item memory item = coffee.getItem(_upc);
        item.ownerID = msg.sender;
        item.retailerID = msg.sender;
        item.itemState = State.Received;
        coffee.items[_upc] = item;
        // Emit the appropriate event
        emit Received(_upc);
    }

    // Define a function 'purchaseItem' that allows the consumer to mark an item 'Purchased'
    // Use the above modifiers to check if the item is received
    function purchaseItem(uint256 _upc) public onlyConsumer {
        require(coffee.received(_upc));
        // Update the appropriate fields - ownerID, consumerID, itemState
        Item memory item = coffee.getItem(_upc);
        item.ownerID = msg.sender;
        item.consumerID = msg.sender;
        item.itemState = State.Purchased;
        coffee.items[_upc] = item;
        // Emit the appropriate event
        emit Purchased(_upc);
    }

    // Define a function 'fetchItemBufferOne' that fetches the data
    function fetchItemBufferOne(uint256 _upc)
        public
        view
        returns (
            uint256 itemSKU,
            uint256 itemUPC,
            address ownerID,
            address originFarmerID,
            string memory originFarmName,
            string memory originFarmInformation,
            string memory originFarmLatitude,
            string memory originFarmLongitude
        )
    {
        // Assign values to the 8 parameters
        Item memory item = coffee.getItem(_upc);
        itemSKU = item.sku;
        itemUPC = item.upc;
        ownerID = item.ownerID;
        originFarmerID = item.originFarmerID;
        originFarmName = item.originFarmName;
        originFarmInformation = item.originFarmInformation;
        originFarmLatitude = item.originFarmLatitude;
        originFarmLongitude = item.originFarmLongitude;

        return (
            itemSKU,
            itemUPC,
            ownerID,
            originFarmerID,
            originFarmName,
            originFarmInformation,
            originFarmLatitude,
            originFarmLongitude
        );
    }

    // Define a function 'fetchItemBufferTwo' that fetches the data
    function fetchItemBufferTwo(uint256 _upc)
        public
        view
        returns (
            uint256 itemSKU,
            uint256 itemUPC,
            uint256 productID,
            string memory productNotes,
            uint256 productPrice,
            uint256 itemState,
            address distributorID,
            address retailerID,
            address consumerID
        )
    {
        // Assign values to the 9 parameters
        Item memory item = coffee.getItem(_upc);
        itemSKU = item.sku;
        itemUPC = item.upc;
        productID = item.productID;
        productNotes = item.productNotes;
        productPrice = item.productPrice;
        itemState = uint256(item.itemState);
        distributorID = item.distributorID;
        retailerID = item.retailerID;
        consumerID = item.consumerID;

        return (
            itemSKU,
            itemUPC,
            productID,
            productNotes,
            productPrice,
            itemState,
            distributorID,
            retailerID,
            consumerID
        );
    }
}
