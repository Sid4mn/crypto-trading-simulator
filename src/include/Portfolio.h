#ifndef PORTFOLIO_H
#define PORTFOLIO_H

#include "Types.h"
#include <string>
#include <map>

class Portfolio {
public:
    Portfolio(const std::string& userId, double initialCash = 10000.0);
    
    // Get current cash balance
    double getCashBalance() const;
    
    // Add or remove cash
    void addCash(double amount);
    bool removeCash(double amount);
    
    // Get holdings for a specific cryptocurrency
    double getHolding(CryptoType crypto) const;
    
    // Add to cryptocurrency holdings
    void addHolding(CryptoType crypto, double amount);
    
    // Remove from cryptocurrency holdings
    bool removeHolding(CryptoType crypto, double amount);
    
private:
    std::string userId;
    double cashBalance;
    std::map<CryptoType, double> holdings;
};

#endif // PORTFOLIO_H

