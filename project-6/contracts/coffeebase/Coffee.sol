// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

enum State {
    Harvested, // 0
    Processed, // 1
    Packed, // 2
    ForSale, // 3
    Sold, // 4
    Shipped, // 5
    Received, // 6
    Purchased // 7
}

// Define a struct 'Item' with the following fields:
struct Item {
    uint256 sku; // Stock Keeping Unit (SKU)
    uint256 upc; // Universal Product Code (UPC), generated by the Farmer, goes on the package, can be verified by the Consumer
    address ownerID; // Metamask-Ethereum address of the current owner as the product moves through 8 stages
    address originFarmerID; // Metamask-Ethereum address of the Farmer
    string originFarmName; // Farmer Name
    string originFarmInformation; // Farmer Information
    string originFarmLatitude; // Farm Latitude
    string originFarmLongitude; // Farm Longitude
    uint256 productID; // Product ID potentially a combination of upc + sku
    string productNotes; // Product Notes
    uint256 productPrice; // Product Price
    State itemState; // Product State as represented in the enum above
    address distributorID; // Metamask-Ethereum address of the Distributor
    address retailerID; // Metamask-Ethereum address of the Retailer
    address consumerID; // Metamask-Ethereum address of the Consumer
}

struct Data {
    mapping(uint256 => Item) items;
}

library Coffee {
    function harvested(Data storage self, uint256 _upc)
        public
        view
        returns (bool)
    {
        return self.items[_upc].itemState == State.Harvested;
    }

    function processed(Data storage self, uint256 _upc)
        public
        view
        returns (bool)
    {
        return self.items[_upc].itemState == State.Processed;
    }

    function packed(Data storage self, uint256 _upc)
        public
        view
        returns (bool)
    {
        return self.items[_upc].itemState == State.Packed;
    }

    function forSale(Data storage self, uint256 _upc)
        public
        view
        returns (bool)
    {
        return self.items[_upc].itemState == State.ForSale;
    }

    function sold(Data storage self, uint256 _upc) public view returns (bool) {
        return self.items[_upc].itemState == State.Sold;
    }

    function shipped(Data storage self, uint256 _upc)
        public
        view
        returns (bool)
    {
        return self.items[_upc].itemState == State.Shipped;
    }

    function received(Data storage self, uint256 _upc)
        public
        view
        returns (bool)
    {
        return self.items[_upc].itemState == State.Received;
    }

    function purchased(Data storage self, uint256 _upc)
        public
        view
        returns (bool)
    {
        return self.items[_upc].itemState == State.Purchased;
    }

    function getItem(Data storage self, uint256 _upc)
        public
        view
        returns (Item memory item)
    {
        return self.items[_upc];
    }

    function getItemOwnerId(Data storage self, uint256 _upc)
        public
        view
        returns (address)
    {
        return self.items[_upc].ownerID;
    }
}
