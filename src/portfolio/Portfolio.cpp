#include "../include/Portfolio.h"
#include <chrono>

Portfolio::Portfolio(const std::string& userId, double initialCash) 
    : userId(userId), cashBalance(initialCash) {
}

double Portfolio::getCashBalance() const {
    return cashBalance;
}

void Portfolio::addCash(double amount) {
    if (amount > 0) 
        cashBalance += amount;
}

bool Portfolio::removeCash(double amount) {
    if (amount > 0 && cashBalance >= amount) {
        cashBalance -= amount;
        return true;
    }
    return false;
}

double Portfolio::getHolding(CryptoType crypto) const {
    auto it = holdings.find(crypto);
    if (it != holdings.end()) {
        return it->second;
    } else {
        return 0.0;
    }
}

void Portfolio::addHolding(CryptoType crypto, double amount) {
    if (amount > 0) {
        holdings[crypto] += amount;
        // record the transaction
        recordTransaction(crypto, OrderType::BUY, amount, 0.0);  // price will be set by TradeEngine
    }
}

bool Portfolio::removeHolding(CryptoType crypto, double amount) {
    if (amount > 0 && getHolding(crypto) >= amount) {
        holdings[crypto] -= amount;
        recordTransaction(crypto, OrderType::SELL, amount, 0.0);
        return true;
    }
    return false;
}

double Portfolio::getTotalValue(const MarketData& marketData) const {
    double totalValue = cashBalance;
    
    for (const auto& holding : holdings) {
        totalValue += holding.second * marketData.getPrice(holding.first);
    }
    
    return totalValue;
}

std::vector<Transaction> Portfolio::getTransactionHistory() const {
    return transactions;
}

void Portfolio::recordTransaction(CryptoType crypto, OrderType orderType, double amount, double price) {
    Transaction tx;
    tx.id = "TX" + std::to_string(transactions.size() + 1);
    tx.transactionId = tx.id; // keep synced
    tx.cryptoType = crypto;
    tx.orderType = orderType;
    tx.type = orderType; // keep synced
    tx.amount = amount;
    tx.price = price;
    tx.timestamp = std::time(nullptr);
    tx.success = true;
    
    transactions.push_back(tx);
}
