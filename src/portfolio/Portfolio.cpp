#include "../include/Portfolio.h"

Portfolio::Portfolio(const std::string& userId, double initialCash) 
    : userId(userId), cashBalance(initialCash) {
    // Initialize empty holdings
}

double Portfolio::getCashBalance() const {
    return cashBalance;
}

void Portfolio::addCash(double amount) {
    if (amount > 0) {
        cashBalance += amount;
    }
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
    return (it != holdings.end()) ? it->second : 0.0;
}

void Portfolio::addHolding(CryptoType crypto, double amount) {
    if (amount > 0) {
        holdings[crypto] += amount;
    }
}

bool Portfolio::removeHolding(CryptoType crypto, double amount) {
    if (amount > 0 && getHolding(crypto) >= amount) {
        holdings[crypto] -= amount;
        return true;
    }
    return false;
}
