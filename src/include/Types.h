#ifndef TYPES_H
#define TYPES_H

#include <string>
#include <ctime>

// Basic types for crypto trading simulator

enum class CryptoType {
    BITCOIN,
    ETHEREUM,
    LITECOIN,
    RIPPLE,
    CARDANO
};

enum class OrderType {
    BUY,
    SELL
};

struct Transaction {
    std::string id;
    CryptoType cryptoType;
    OrderType orderType;
    double amount;
    double price;
    std::time_t timestamp;
    bool success;
    
    Transaction() : cryptoType(CryptoType::BITCOIN), orderType(OrderType::BUY), 
                   amount(0.0), price(0.0), timestamp(0), success(false) {}
    
    Transaction(const std::string& id, CryptoType crypto, OrderType order, 
               double amt, double pr, std::time_t ts, bool succ = true)
        : id(id), cryptoType(crypto), orderType(order), amount(amt), 
          price(pr), timestamp(ts), success(succ) {}
};

#endif // TYPES_H

