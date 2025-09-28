#include <iostream>
#include <memory>
#include "include/MarketData.h"
#include "include/Portfolio.h"
#include "include/TradeEngine.h"
#include "include/Logger.h"
#include "include/Config.h"

int main() {
    // grab singletons
    auto& logger = Logger::getInstance();
    auto& config = Config::getInstance();
    
    logger.log("Starting crypto trading simulator");
    
    std::cout << "\n=== Crypto Trading Simulator v0.7 ===" << std::endl;
    
    // setup components with config
    double initialCash = config.getDouble("initial_cash", 10000.0);
    Portfolio portfolio("user1", initialCash);
    auto marketData = std::make_shared<MarketData>();
    TradeEngine engine(marketData);
    
    std::cout << "Initial cash: $" << initialCash << std::endl;
    std::cout << "Initial Portfolio:" << std::endl;
    std::cout << "Cash: $" << portfolio.getCashBalance() << std::endl;
    std::cout << "Bitcoin: " << portfolio.getHolding(CryptoType::BITCOIN) << std::endl;
    
    std::cout << "\nTesting trades..." << std::endl;
    
    // Try to buy some Bitcoin
    std::cout << "\nAttempting to buy 0.1 Bitcoin..." << std::endl;
    std::cout << "Current BTC price: $" << marketData->getPrice(CryptoType::BITCOIN) << std::endl;
    
    bool result = engine.executeTrade(portfolio, CryptoType::BITCOIN, OrderType::BUY, 0.1);
    if(result) {
        std::cout << "Trade successful!" << std::endl;
    } else {
        std::cout << "Trade failed!" << std::endl;
    }
    
    std::cout << "\nUpdated Portfolio:" << std::endl;
    std::cout << "Cash: $" << portfolio.getCashBalance() << std::endl;
    std::cout << "Bitcoin: " << portfolio.getHolding(CryptoType::BITCOIN) << std::endl;
    
    // Update prices with volatility
    std::cout << "\nSimulating market movement..." << std::endl;
    engine.updatePrices();
    std::cout << "New BTC price: $" << marketData->getPrice(CryptoType::BITCOIN) << std::endl;
    
    // Try to sell some Bitcoin
    std::cout << "\nAttempting to sell 0.05 Bitcoin..." << std::endl;
    bool sellResult = engine.executeTrade(portfolio, CryptoType::BITCOIN, OrderType::SELL, 0.05);
    if(sellResult) {
        std::cout << "Sell successful!" << std::endl;
    } else {
        std::cout << "Sell failed!" << std::endl;
    }
    
    std::cout << "\nFinal Portfolio:" << std::endl;
    std::cout << "Cash: $" << portfolio.getCashBalance() << std::endl;
    std::cout << "Bitcoin: " << portfolio.getHolding(CryptoType::BITCOIN) << std::endl;
    
    logger.log("Simulator completed successfully");
    return 0;
}