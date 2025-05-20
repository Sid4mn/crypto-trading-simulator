#include "../include/MarketData.h"
#include <map>
#include <random>

MarketData::MarketData() {
    // TODO: maybe load from file later?
}

double MarketData::getPrice(CryptoType crypto) {
    // hardcoded prices for now
    std::map<CryptoType, double> prices;
    prices[CryptoType::BITCOIN] = 45000.0;  // updated price
    prices[CryptoType::ETHEREUM] = 2800.0;
    prices[CryptoType::LITECOIN] = 95.0;
    prices[CryptoType::RIPPLE] = 0.48;
    prices[CryptoType::CARDANO] = 0.95;
    
    // add some randomness to make it more realistic
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<> dis(0.95, 1.05);
    
    double basePrice = prices[crypto];
    double randomFactor = dis(gen);
    
    return basePrice * randomFactor;
}
