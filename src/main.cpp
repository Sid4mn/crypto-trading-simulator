#include <iostream>
#include "include/MarketData.h"
#include "include/Portfolio.h"
#include "include/TradeEngine.h"

int main() {
    std::cout << "Crypto Trading Simulator v0.6" << std::endl;
    std::cout << "================================" << std::endl;
    
    MarketData market;
    Portfolio portfolio("user1", 50000.0);  // Start with 50,000
    TradeEngine engine;
    
    std::cout << "Initial Portfolio:" << std::endl;
    std::cout << "Cash: $" << portfolio.getCashBalance() << std::endl;
    std::cout << "Bitcoin: " << portfolio.getHolding(CryptoType::BITCOIN) << std::endl;
    
    std::cout << "\nTesting trades..." << std::endl;
    
    // Try to buy some Bitcoin
    std::cout << "\nAttempting to buy 0.1 Bitcoin..." << std::endl;
    bool result = engine.executeTrade(portfolio, CryptoType::BITCOIN, OrderType::BUY, 0.1);
    if(result) {
        std::cout << "Trade successful!" << std::endl;
    }
    
    std::cout << "\nUpdated Portfolio:" << std::endl;
    std::cout << "Cash: $" << portfolio.getCashBalance() << std::endl;
    std::cout << "Bitcoin: " << portfolio.getHolding(CryptoType::BITCOIN) << std::endl;
    
    // Try to sell some Bitcoin
    std::cout << "\nAttempting to sell 0.05 Bitcoin..." << std::endl;
    engine.executeTrade(portfolio, CryptoType::BITCOIN, OrderType::SELL, 0.05);
    
    std::cout << "\nFinal Portfolio:" << std::endl;
    std::cout << "Cash: $" << portfolio.getCashBalance() << std::endl;
    std::cout << "Bitcoin: " << portfolio.getHolding(CryptoType::BITCOIN) << std::endl;
    
    return 0;
}