#include "../include/TradeEngine.h"
#include <iostream>

TradeEngine::TradeEngine() {
    // Initialize trade engine
}

bool TradeEngine::executeTrade(Portfolio& portfolio, CryptoType crypto, OrderType type, double amount) {
    // Basic trade execution logic
    if (type == OrderType::BUY) {
        // Check if user has enough cash
        MarketData market;
        double price = market.getPrice(crypto);
        double totalCost = amount * price;
        
        if (portfolio.getCashBalance() >= totalCost) {
            // Execute buy order (simplified)
            std::cout << "Executing buy order for " << amount << " units at $" << price << std::endl;
            return true;
        } else {
            std::cout << "Insufficient funds for buy order" << std::endl;
            return false;
        }
    } else {
        // Execute sell order
        double holding = portfolio.getHolding(crypto);
        if (holding >= amount) {
            std::cout << "Executing sell order for " << amount << " units" << std::endl;
            return true;
        } else {
            std::cout << "Insufficient holdings for sell order" << std::endl;
            return false;
        }
    }
}
