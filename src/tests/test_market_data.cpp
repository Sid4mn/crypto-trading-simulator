#include <iostream>
#include <cassert>
#include "../include/MarketData.h"

void testMarketDataBasics() {
    std::cout << "Testing MarketData basics..." << std::endl;
    
    MarketData market;
    
    // Test initial prices
    double btcPrice = market.getPrice(CryptoType::BITCOIN);
    assert(btcPrice > 0);
    
    double ethPrice = market.getPrice(CryptoType::ETHEREUM);
    assert(ethPrice > 0);
    
    std::cout << "Initial BTC price: $" << btcPrice << std::endl;
    std::cout << "Initial ETH price: $" << ethPrice << std::endl;
    
    // Test price updates
    market.updatePrice(CryptoType::BITCOIN, 50000.0);
    assert(market.getPrice(CryptoType::BITCOIN) == 50000.0);
    
    std::cout << "MarketData tests passed!" << std::endl;
}

int main() {
    testMarketDataBasics();
    return 0;
}

// Market data tests added
