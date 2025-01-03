#include <iostream>
#include <iomanip>
#include <memory>
#include "include/MarketData.h"
#include "include/Portfolio.h"
#include "include/TradeEngine.h"
#include "include/User.h"
#include "include/UserManager.h"

class CryptoSimulator {
private:
    std::shared_ptr<MarketData> marketData;
    std::unique_ptr<UserManager> userManager;
    std::unique_ptr<TradeEngine> tradeEngine;
    
public:
    CryptoSimulator() {
        marketData = std::make_shared<MarketData>();
        userManager = std::make_unique<UserManager>();
        tradeEngine = std::make_unique<TradeEngine>(marketData);
    }
    
    void displayWelcome() {
        std::cout << "\n" << std::string(60, '=') << std::endl;
        std::cout << "    CRYPTO TRADING SIMULATOR v1.0" << std::endl;
        std::cout << "    Advanced Cryptocurrency Trading Platform" << std::endl;
        std::cout << std::string(60, '=') << "\n" << std::endl;
    }
    
    void displayMarketData() {
        std::cout << "Current Market Prices:" << std::endl;
        std::cout << std::string(40, '-') << std::endl;
        
        auto cryptos = {CryptoType::BITCOIN, CryptoType::ETHEREUM, CryptoType::LITECOIN, 
                       CryptoType::RIPPLE, CryptoType::CARDANO};
        
        for (auto crypto : cryptos) {
            double price = marketData->getPrice(crypto);
            double ma7 = marketData->calculateMovingAverage(crypto, 7);
            double volatility = marketData->getVolatility(crypto);
            
            std::cout << std::left << std::setw(10);
            switch(crypto) {
                case CryptoType::BITCOIN: std::cout << "Bitcoin"; break;
                case CryptoType::ETHEREUM: std::cout << "Ethereum"; break;
                case CryptoType::LITECOIN: std::cout << "Litecoin"; break;
                case CryptoType::RIPPLE: std::cout << "Ripple"; break;
                case CryptoType::CARDANO: std::cout << "Cardano"; break;
            }
            
            std::cout << ": $" << std::setw(10) << std::fixed << std::setprecision(2) << price
                      << " | MA7: $" << std::setw(10) << ma7 
                      << " | Vol: " << std::setw(5) << std::setprecision(1) << (volatility * 100) << "%" << std::endl;
        }
        std::cout << std::endl;
    }
    
    void runSimulation() {
        displayWelcome();
        
        // Create sample users
        auto user1 = userManager->createUser("Alice Johnson");
        auto user2 = userManager->createUser("Bob Smith");
        
        std::cout << "Created users:" << std::endl;
        std::cout << "- " << user1->getUsername() << " (ID: " << user1->getUserId() << ")" << std::endl;
        std::cout << "- " << user2->getUsername() << " (ID: " << user2->getUserId() << ")" << std::endl;
        std::cout << std::endl;
        
        displayMarketData();
        
        // Simulate market movement
        std::cout << "Simulating market movement..." << std::endl;
        marketData->simulateMarketMovement();
        std::cout << "Market prices updated!\n" << std::endl;
        
        displayMarketData();
        
        // Execute some trades
        auto& alicePortfolio = user1->getPortfolio();
        
        std::cout << "Alice's Trading Activity:" << std::endl;
        std::cout << "Initial cash: $" << alicePortfolio.getCashBalance() << std::endl;
        
        auto result1 = tradeEngine->executeTrade(alicePortfolio, CryptoType::BITCOIN, OrderType::BUY, 0.1);
        auto result2 = tradeEngine->executeTrade(alicePortfolio, CryptoType::ETHEREUM, OrderType::BUY, 1.0);
        
        std::cout << "\nAlice's Final Portfolio:" << std::endl;
        std::cout << "Cash: $" << std::fixed << std::setprecision(2) << alicePortfolio.getCashBalance() << std::endl;
        std::cout << "Bitcoin: " << std::setprecision(8) << alicePortfolio.getHolding(CryptoType::BITCOIN) << std::endl;
        std::cout << "Ethereum: " << alicePortfolio.getHolding(CryptoType::ETHEREUM) << std::endl;
        std::cout << "Total Value: $" << std::setprecision(2) << alicePortfolio.getTotalValue(*marketData) << std::endl;
        
        // Display transaction history
        std::cout << "\nTransaction History:" << std::endl;
        auto transactions = alicePortfolio.getTransactionHistory();
        for (const auto& tx : transactions) {
            std::cout << tx.transactionId << ": " << (tx.type == OrderType::BUY ? "BUY" : "SELL") 
                      << " " << tx.amount << " at $" << tx.price << " (" << tx.timestamp << ")" << std::endl;
        }
        
        std::cout << "\nSimulation completed successfully!" << std::endl;
    }
};

int main() {
    try {
        CryptoSimulator simulator;
        simulator.runSimulation();
    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << std::endl;
        return 1;
    }
    
    return 0;
}

