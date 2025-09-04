// SPDX-License-Identifier: MIT  
pragma solidity ^0.8.20;  

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";  
import "@openzeppelin/contracts/access/Ownable.sol";  
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";  

contract MyToken is ERC20, Ownable, ERC20Burnable {  
    uint8 private constant _DECIMALS = 18;  
    uint256 private constant _TOTAL_SUPPLY = 1000000 * (10 ** _DECIMALS);  
    uint256 public taxRate; // Example advanced feature  
    address public treasury;  

    event TokensMinted(address indexed to, uint256 amount);  
    event TokensBurned(address indexed from, uint256 amount);  
    event TaxRateUpdated(uint256 newTaxRate);  

    constructor(  
        string memory name,  
        string memory symbol,  
        address initialOwner,  
        uint256 _taxRate,  
        address _treasury  
    ) ERC20(name, symbol) Ownable(initialOwner) {  
        taxRate = _taxRate;  
        treasury = _treasury;  
        _mint(initialOwner, _TOTAL_SUPPLY);  
    }  

    function mint(address to, uint256 amount) external onlyOwner {  
        _mint(to, amount);  
        emit TokensMinted(to, amount);  
    }  

    function updateTaxRate(uint256 newTaxRate) external onlyOwner {  
        require(newTaxRate <= 100, "Tax rate cannot exceed 100%");  
        taxRate = newTaxRate;  
        emit TaxRateUpdated(newTaxRate);  
    }  

    // Override transfer to implement tax mechanism  
    function _update(address from, address to, uint256 amount) internal override {  
        if (taxRate > 0 && from != address(0) && to != address(0)) {  
            uint256 taxAmount = (amount * taxRate) / 100;  
            uint256 netAmount = amount - taxAmount;  
            
            super._update(from, treasury, taxAmount);  
            super._update(from, to, netAmount);  
        } else {  
            super._update(from, to, amount);  
        }  
    }  
}  