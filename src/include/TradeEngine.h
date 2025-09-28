#pragma once
#include "Types.h"
#include "Portfolio.h"
#include "MarketData.h"
#include <memory>

// Thin facade - just delegates to specialized components
class TradeEngine {
private:
    std::shared_ptr<MarketData> marketData;
    
    // cache for avoiding recalculations
    mutable double cachedTotalValue = 0.0;
    mutable bool cacheValid = false;
    
public:
    TradeEngine() : marketData(std::make_shared<MarketData>()) {}
    TradeEngine(std::shared_ptr<MarketData> md) : marketData(md) {}
    
    // stateless execution functions - just coordinate between components
    bool executeBuyOrder(Portfolio& portfolio, CryptoType crypto, double quantity);
    bool executeSellOrder(Portfolio& portfolio, CryptoType crypto, double quantity);
    
    // backwards compatibility
    bool executeTrade(Portfolio& portfolio, CryptoType crypto, OrderType type, double amount);
    
    // cached calculation - avoids expensive recalculation
    double getTotalPortfolioValue(const Portfolio& portfolio) const;
    
    void updatePrices() {
        marketData->updatePrices();
        invalidateCache();
    }
    
    // expose market data for other components
    std::shared_ptr<MarketData> getMarketData() { return marketData; }
    
private:
    void invalidateCache() const {
        cacheValid = false;
    }
};

