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
    std::string transactionId; // alias for compatibility
    CryptoType cryptoType;
    OrderType orderType;
    OrderType type; // alias for compatibility
    double amount;
    double price;
    std::time_t timestamp;
    bool success;
    
    Transaction() : cryptoType(CryptoType::BITCOIN), orderType(OrderType::BUY), type(OrderType::BUY),
                   amount(0.0), price(0.0), timestamp(0), success(false) {
        transactionId = id; // keep them synced
    }
    
    Transaction(const std::string& txId, CryptoType crypto, OrderType order, 
               double amt, double pr, std::time_t ts, bool succ = true)
        : id(txId), transactionId(txId), cryptoType(crypto), orderType(order), type(order),
          amount(amt), price(pr), timestamp(ts), success(succ) {}
};

#endif // TYPES_H

