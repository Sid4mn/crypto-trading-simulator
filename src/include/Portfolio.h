#ifndef PORTFOLIO_H
#define PORTFOLIO_H

#include "Types.h"
#include <string>
#include <map>

class Portfolio {
public:
    Portfolio(const std::string& userId, double initialCash = 10000.0);
    
    double getCashBalance() const;
    
    void addCash(double amount);
    bool removeCash(double amount);
    
    double getHolding(CryptoType crypto) const;
    
    void addHolding(CryptoType crypto, double amount);
    
    bool removeHolding(CryptoType crypto, double amount);
    
private:
    std::string userId;
    double cashBalance;
    std::map<CryptoType, double> holdings;
};

#endif // PORTFOLIO_H

