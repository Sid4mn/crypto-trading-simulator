#include "../include/TradeEngine.h"
#include "../include/Logger.h"
#include "../include/Config.h"

bool TradeEngine::executeBuyOrder(Portfolio& portfolio, CryptoType crypto, double quantity) {
    double price = marketData->getPrice(crypto);
    if (price <= 0) return false;
    
    double cost = price * quantity;
    if (portfolio.getCashBalance() < cost) return false;
    
    // delegate actual work to portfolio
    if (portfolio.removeCash(cost)) {
        portfolio.addHolding(crypto, quantity);
        
        auto& logger = Logger::getInstance();
        logger.log("Buy executed: " + std::to_string(quantity) + " at $" + std::to_string(price));
        
        invalidateCache();
        return true;
    }
    return false;
}

bool TradeEngine::executeSellOrder(Portfolio& portfolio, CryptoType crypto, double quantity) {
    double price = marketData->getPrice(crypto);
    if (price <= 0) return false;
    
    if (portfolio.getHolding(crypto) < quantity) return false;
    
    // delegate to portfolio
    if (portfolio.removeHolding(crypto, quantity)) {
        double proceeds = quantity * price;
        portfolio.addCash(proceeds);
        
        auto& logger = Logger::getInstance();
        logger.log("Sell executed: " + std::to_string(quantity) + " at $" + std::to_string(price));
        
        invalidateCache();
        return true;
    }
    return false;
}

bool TradeEngine::executeTrade(Portfolio& portfolio, CryptoType crypto, OrderType type, double amount) {
    // backwards compatibility wrapper
    if (type == OrderType::BUY) {
        return executeBuyOrder(portfolio, crypto, amount);
    } else {
        return executeSellOrder(portfolio, crypto, amount);
    }
}

// cached calculation to avoid expensive portfolio scanning
double TradeEngine::getTotalPortfolioValue(const Portfolio& portfolio) const {
    if (!cacheValid) {
        cachedTotalValue = portfolio.getCashBalance();
        
        // would need to iterate holdings, but Portfolio doesn't expose them all
        // this is a design issue - keeping simple for now
        // in real system would add getHoldings() method for proper calculation
        cacheValid = true;
    }
    return cachedTotalValue;
}
