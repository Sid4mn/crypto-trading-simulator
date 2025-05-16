#include "../include/TradeEngine.h"
#include <iostream>

TradeEngine::TradeEngine() {
}

bool TradeEngine::executeTrade(Portfolio& portfolio, CryptoType crypto, OrderType type, double amount) {
    if (type == OrderType::BUY) {
        MarketData market;
        double price = market.getPrice(crypto);
        double totalCost = amount * price;
        
        if (portfolio.getCashBalance() >= totalCost) {
            portfolio.removeCash(totalCost);
            portfolio.addHolding(crypto, amount);
            std::cout << "Executing buy order for " << amount << " units at $" << price << std::endl;
            return true;
        } else {
            std::cout << "Insufficient funds for buy order" << std::endl;
            return false;
        }
    } else {
        // sell order
        double holding = portfolio.getHolding(crypto);
        if (holding >= amount) {
            portfolio.removeHolding(crypto, amount);
            MarketData market;
            double price = market.getPrice(crypto);
            portfolio.addCash(amount * price);
            std::cout << "Executing sell order for " << amount << " units" << std::endl;
            return true;
        } else {
            std::cout << "Insufficient holdings for sell order" << std::endl;
            return false;
        }
    }
}
