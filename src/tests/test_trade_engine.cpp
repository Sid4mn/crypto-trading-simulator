#include <iostream>
#include <cassert>
#include <memory>
#include "../include/TradeEngine.h"
#include "../include/MarketData.h"
#include "../include/Portfolio.h"

void testBasicTrading() {
    std::cout << "Testing basic trading functionality..." << std::endl;
    
    auto marketData = std::make_shared<MarketData>();
    TradeEngine engine(marketData);
    Portfolio portfolio("test_user", 10000.0);
    
    // Test buying Bitcoin
    auto result = engine.executeTrade(portfolio, CryptoType::BITCOIN, OrderType::BUY, 0.1);
    assert(result.success);
    assert(result.executedPrice > 0);
    assert(portfolio.getHolding(CryptoType::BITCOIN) == 0.1);
    
    // Test selling Bitcoin
    auto sellResult = engine.executeTrade(portfolio, CryptoType::BITCOIN, OrderType::SELL, 0.05);
    assert(sellResult.success);
    assert(portfolio.getHolding(CryptoType::BITCOIN) == 0.05);
    
    std::cout << "Basic trading tests passed!" << std::endl;
}

void testInsufficientFunds() {
    std::cout << "Testing insufficient funds scenario..." << std::endl;
    
    auto marketData = std::make_shared<MarketData>();
    TradeEngine engine(marketData);
    Portfolio portfolio("test_user", 100.0);  // Very low balance
    
    // Try to buy expensive Bitcoin
    auto result = engine.executeTrade(portfolio, CryptoType::BITCOIN, OrderType::BUY, 1.0);
    assert(!result.success);
    assert(result.message == "Insufficient funds");
    
    std::cout << "Insufficient funds tests passed!" << std::endl;
}

int main() {
    testBasicTrading();
    testInsufficientFunds();
    
    std::cout << "All TradeEngine tests passed!" << std::endl;
    return 0;
}

