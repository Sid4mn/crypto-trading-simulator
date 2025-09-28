#pragma once
#include "Types.h"
#include <vector>
#include <unordered_map>
#include <random>
#include <string>

class MarketData {
private:
    // contiguous storage for hot path
    std::vector<double> prices;
    std::vector<double> priceHistory; // flat array: [sym0_t0, sym0_t1, ..., sym1_t0, sym1_t1, ...]
    std::unordered_map<std::string, size_t> symbolToIndex; // O(1) lookup to vector index
    std::unordered_map<CryptoType, size_t> cryptoToIndex;  // for backwards compatibility
    
    size_t historyDepth = 100;
    size_t numSymbols;
    size_t currentHistorySize = 0;
    
    std::mt19937 rng;
    std::normal_distribution<> volatilityDist;
    
public:
    MarketData();
    
    // string-based interface (better for contiguous storage)
    double getPrice(const std::string& symbol) const;
    void updatePrices();
    double getMovingAverage(const std::string& symbol, size_t periods) const;
    
    // backwards compatibility 
    double getPrice(CryptoType crypto) const;
    double getVolatility(CryptoType crypto) const { return 0.02; }  // stub
    double calculateMovingAverage(CryptoType crypto, size_t periods) const;
    void simulateMarketMovement() { updatePrices(); }
    
private:
    void initializePrices();
    std::string cryptoToString(CryptoType crypto) const;
};

