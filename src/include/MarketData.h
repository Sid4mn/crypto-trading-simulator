#ifndef MARKETDATA_H
#define MARKETDATA_H

#include "Types.h"

class MarketData {
public:
    MarketData();
    
    // Get current price for a cryptocurrency
    double getPrice(CryptoType crypto);
    
private:
    // TODO: Add price storage
};

#endif // MARKETDATA_H

