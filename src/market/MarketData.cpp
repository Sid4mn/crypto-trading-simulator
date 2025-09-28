#include "../include/MarketData.h"
#include <algorithm>

MarketData::MarketData() : rng(std::random_device{}()), volatilityDist(0.0, 0.02) {
    initializePrices();
}

void MarketData::initializePrices() {
    // setup symbol mapping  
    symbolToIndex["BTC"] = 0;
    symbolToIndex["ETH"] = 1;  
    symbolToIndex["LTC"] = 2;
    symbolToIndex["XRP"] = 3;
    symbolToIndex["ADA"] = 4;
    
    // backwards compatibility mapping
    cryptoToIndex[CryptoType::BITCOIN] = 0;
    cryptoToIndex[CryptoType::ETHEREUM] = 1;
    cryptoToIndex[CryptoType::LITECOIN] = 2;
    cryptoToIndex[CryptoType::RIPPLE] = 3;
    cryptoToIndex[CryptoType::CARDANO] = 4;
    
    numSymbols = symbolToIndex.size();
    
    // contiguous arrays - realistic starting prices after market correction
    prices = {42000.0, 2700.0, 95.0, 0.48, 0.95};
    priceHistory.reserve(numSymbols * historyDepth);
    
    // TODO: maybe load initial prices from config file later
}

double MarketData::getPrice(const std::string& symbol) const {
    auto it = symbolToIndex.find(symbol);
    if (it == symbolToIndex.end()) return -1.0;
    return prices[it->second]; // direct array access
}

double MarketData::getPrice(CryptoType crypto) const {
    auto it = cryptoToIndex.find(crypto);
    if (it == cryptoToIndex.end()) return -1.0;
    return prices[it->second];
}

void MarketData::updatePrices() {
    // store current prices in history (circular buffer style)
    if (currentHistorySize < historyDepth) {
        priceHistory.insert(priceHistory.end(), prices.begin(), prices.end());
        currentHistorySize++;
    } else {
        // overwrite oldest
        size_t offset = ((currentHistorySize % historyDepth) * numSymbols);
        std::copy(prices.begin(), prices.end(), priceHistory.begin() + offset);
        currentHistorySize++;
    }
    
    // update prices with some volatility
    for (size_t i = 0; i < prices.size(); ++i) {
        double change = 1.0 + volatilityDist(rng);
        prices[i] *= change;
        
        // keep prices reasonable - prevent crashes or moon shots
        prices[i] = std::max(prices[i], 0.01);
        if (i == 0) prices[i] = std::min(prices[i], 100000.0); // BTC cap
        if (i == 1) prices[i] = std::min(prices[i], 10000.0);  // ETH cap
    }
}

// fast moving average using contiguous history
double MarketData::getMovingAverage(const std::string& symbol, size_t periods) const {
    auto it = symbolToIndex.find(symbol);
    if (it == symbolToIndex.end()) return -1.0;
    
    size_t symbolIdx = it->second;
    size_t available = std::min(periods, currentHistorySize);
    if (available == 0) return prices[symbolIdx];
    
    double sum = 0.0;
    // walk backwards through history
    for (size_t i = 0; i < available; ++i) {
        size_t histIdx = ((currentHistorySize - 1 - i) % historyDepth) * numSymbols + symbolIdx;
        sum += priceHistory[histIdx];
    }
    
    return sum / available;
}

double MarketData::calculateMovingAverage(CryptoType crypto, size_t periods) const {
    std::string symbol = cryptoToString(crypto);
    return getMovingAverage(symbol, periods);
}

std::string MarketData::cryptoToString(CryptoType crypto) const {
    switch (crypto) {
        case CryptoType::BITCOIN: return "BTC";
        case CryptoType::ETHEREUM: return "ETH"; 
        case CryptoType::LITECOIN: return "LTC";
        case CryptoType::RIPPLE: return "XRP";
        case CryptoType::CARDANO: return "ADA";
        default: return "";
    }
}
