#ifndef PORTFOLIO_H
#define PORTFOLIO_H

#include "Types.h"
#include "MarketData.h"
#include <string>
#include <map>
#include <vector>

class Portfolio {
public:
    Portfolio(const std::string& userId, double initialCash = 10000.0);
    
    double getCashBalance() const;
    
    void addCash(double amount);
    bool removeCash(double amount);
    
    double getHolding(CryptoType crypto) const;
    
    void addHolding(CryptoType crypto, double amount);
    
    bool removeHolding(CryptoType crypto, double amount);
    
    // Additional methods for modular version
    double getTotalValue(const MarketData& marketData) const;
    std::vector<Transaction> getTransactionHistory() const;
    const std::map<CryptoType, double>& getHoldings() const { return holdings; }
    
private:
    std::string userId;
    double cashBalance;
    std::map<CryptoType, double> holdings;
    std::vector<Transaction> transactions; // track transaction history
    
    void recordTransaction(CryptoType crypto, OrderType orderType, double amount, double price);
};

#endif // PORTFOLIO_H

