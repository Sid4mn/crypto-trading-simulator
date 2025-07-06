#include "../include/MarketData.h"
#include <map>
#include <random>

MarketData::MarketData() {
    // Initialize with some default prices
}

double MarketData::getPrice(CryptoType crypto) {
    // Return simulated prices
    static std::map<CryptoType, double> prices = {
        {CryptoType::BITCOIN, 50000.0},
        {CryptoType::ETHEREUM, 3000.0},
        {CryptoType::LITECOIN, 100.0},
        {CryptoType::RIPPLE, 0.5},
        {CryptoType::CARDANO, 1.0}
    };
    
    // Add some randomness
    static std::random_device rd;
    static std::mt19937 gen(rd());
    static std::uniform_real_distribution<> dis(0.95, 1.05);
    
    return prices[crypto] * dis(gen);
}
