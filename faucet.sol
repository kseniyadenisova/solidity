pragma solidity ^0.5.0;

contract faucet {

	address public owner_address;
	
	uint public maximum_amount = 0.1 ether;

    mapping (address => bool) public address_list;
	
    event ether_transfer(address to_address, uint amount);
    
    constructor () public {
        owner_address = msg.sender;
    }

    function () payable external {
    }

    function get_balance() public view returns (uint) {
        return address(this).balance;
    }

    function ether_transfer_reqs(uint ether_amount) public {
        require(ether_amount > 0, "Amount must be positive");
		require(address(this).balance >= ether_amount, "Not enough ether to transfer");
        if (msg.sender != owner_address) {
            require(ether_amount <= maximum_amount, "Transfer amount is higher than maximum_amount");
            require(address_list[msg.sender] == false, "Only one transfer is possible");
            address_list[msg.sender] = true;
        }
        msg.sender.transfer(ether_amount);
        emit ether_transfer(msg.sender, ether_amount);
    }
}