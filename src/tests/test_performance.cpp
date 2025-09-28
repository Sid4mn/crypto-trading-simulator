#include <iostream>
#include <chrono>
#include <memory>
#include <vector>
#include "../include/MarketData.h"
#include "../include/Portfolio.h"
#include "../include/TradeEngine.h"

class PerformanceTest {
private:
    std::shared_ptr<MarketData> marketData;
    std::unique_ptr<TradeEngine> engine;
    
public:
    PerformanceTest() {
        marketData = std::make_shared<MarketData>();
        engine = std::make_unique<TradeEngine>(marketData);
    }
    
    void testMarketSimulation() {
        std::cout << "Testing market simulation performance..." << std::endl;
        
        auto start = std::chrono::high_resolution_clock::now();
        
        // Simulate 1000 market movements
        for (int i = 0; i < 1000; ++i) {
            marketData->simulateMarketMovement();
        }
        
        auto end = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
        
        std::cout << "1000 market simulations completed in " 
                  << duration.count() << " microseconds" << std::endl;
        std::cout << "Average time per simulation: " 
                  << (duration.count() / 1000.0) << " microseconds" << std::endl;
    }
    
    void testTradingPerformance() {
        std::cout << "\nTesting trading performance..." << std::endl;
        
        Portfolio portfolio("perf_test", 1000000.0); // M starting balance
        
        auto start = std::chrono::high_resolution_clock::now();
        
        // Execute 100 trades
        for (int i = 0; i < 100; ++i) {
            CryptoType crypto = static_cast<CryptoType>(i % 5);
            OrderType type = (i % 2 == 0) ? OrderType::BUY : OrderType::SELL;
            double amount = 0.01 + (i % 10) * 0.001; // Variable amounts
            
            engine->executeTrade(portfolio, crypto, type, amount);
        }
        
        auto end = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
        
        std::cout << "100 trades executed in " 
                  << duration.count() << " microseconds" << std::endl;
        std::cout << "Average time per trade: " 
                  << (duration.count() / 100.0) << " microseconds" << std::endl;
        
        // Show final portfolio stats
        std::cout << "Final cash balance: $" << portfolio.getCashBalance() << std::endl;
        std::cout << "Transaction count: " << portfolio.getTransactionHistory().size() << std::endl;
    }
    
    void testPortfolioCalculations() {
        std::cout << "\nTesting portfolio calculation performance..." << std::endl;
        
        Portfolio portfolio("calc_test", 50000.0);
        
        // Add some holdings
        portfolio.addHolding(CryptoType::BITCOIN, 1.0);
        portfolio.addHolding(CryptoType::ETHEREUM, 10.0);
        portfolio.addHolding(CryptoType::LITECOIN, 100.0);
        
        auto start = std::chrono::high_resolution_clock::now();
        
        // Calculate total value 1000 times
        double totalValue = 0.0;
        for (int i = 0; i < 1000; ++i) {
            totalValue = portfolio.getTotalValue(*marketData);
        }
        
        auto end = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
        
        std::cout << "1000 portfolio valuations completed in " 
                  << duration.count() << " microseconds" << std::endl;
        std::cout << "Average time per calculation: " 
                  << (duration.count() / 1000.0) << " microseconds" << std::endl;
        std::cout << "Final portfolio value: $" << totalValue << std::endl;
    }
    
    void runAllTests() {
        std::cout << "=== CRYPTO TRADING SIMULATOR PERFORMANCE TESTS ===" << std::endl;
        
        testMarketSimulation();
        testTradingPerformance();
        testPortfolioCalculations();
        
        std::cout << "\n=== PERFORMANCE TESTS COMPLETED ===" << std::endl;
    }
};

int main() {
    try {
        PerformanceTest test;
        test.runAllTests();
    } catch (const std::exception& e) {
        std::cerr << "Error during performance testing: " << e.what() << std::endl;
        return 1;
    }
    
    return 0;
}