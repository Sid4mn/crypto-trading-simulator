#include <iostream>
#include <cassert>
#include "../include/Portfolio.h"
#include "../include/MarketData.h"

void testPortfolioBasics() {
    std::cout << "Testing Portfolio basics..." << std::endl;
    
    Portfolio portfolio("test_user", 1000.0);
    
    // Test initial values
    assert(portfolio.getCashBalance() == 1000.0);
    assert(portfolio.getHolding(CryptoType::BITCOIN) == 0.0);
    
    // Test adding holdings
    portfolio.addHolding(CryptoType::BITCOIN, 0.5);
    assert(portfolio.getHolding(CryptoType::BITCOIN) == 0.5);
    
    // Test removing holdings
    bool success = portfolio.removeHolding(CryptoType::BITCOIN, 0.2);
    assert(success);
    assert(portfolio.getHolding(CryptoType::BITCOIN) == 0.3);
    
    std::cout << "Portfolio tests passed!" << std::endl;
}

int main() {
    testPortfolioBasics();
    return 0;
}

// Portfolio tests implemented
