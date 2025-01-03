#ifndef TRADEENGINE_H
#define TRADEENGINE_H

#include "Types.h"
#include "Portfolio.h"
#include "MarketData.h"

class TradeEngine {
public:
    TradeEngine();
    
    // Execute a simple trade
    bool executeTrade(Portfolio& portfolio, CryptoType crypto, OrderType type, double amount);
    
private:
    // TODO: Add trade execution logic
};

#endif // TRADEENGINE_H

