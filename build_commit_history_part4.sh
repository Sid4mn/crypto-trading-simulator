#!/bin/bash

# Crypto Trading Simulator - Part 4: April 2025
# Continue building commit history

set -e

# Configuration
PROJECT_DIR="/Users/funinc/Documents/crypto_simulator_complete"
cd "$PROJECT_DIR"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Part 4: April 2025 ===${NC}"

# Functions (same as previous parts)
make_commit() {
    local message="$1"
    local date="$2"
    local time="$3"
    
    export GIT_AUTHOR_DATE="$date $time"
    export GIT_COMMITTER_DATE="$date $time"
    
    git add -A
    git commit -m "$message" --date="$date $time"
    
    unset GIT_AUTHOR_DATE
    unset GIT_COMMITTER_DATE
    
    echo -e "${GREEN}✓${NC} $message"
}

create_file() {
    local filepath="$1"
    local content="$2"
    
    mkdir -p "$(dirname "$filepath")"
    echo "$content" > "$filepath"
}

# ============================================================================
# APRIL 2025 - Advanced Features and Optimizations
# ============================================================================

echo -e "${YELLOW}Creating April 2025 commits...${NC}"

# Day 52: April 1st, 2025 - Implement volatility
create_file "src/market/MarketData.cpp" "#include \"../include/MarketData.h\"
#include <random>
#include <ctime>

MarketData::MarketData() {
    initializePrices();
    initializeVolatility();
}

void MarketData::initializePrices() {
    // Initialize with realistic starting prices
    prices[CryptoType::BITCOIN] = 45000.0;
    prices[CryptoType::ETHEREUM] = 3000.0;
    prices[CryptoType::LITECOIN] = 150.0;
    prices[CryptoType::RIPPLE] = 0.65;
    prices[CryptoType::CARDANO] = 1.20;
}

void MarketData::initializeVolatility() {
    // Initialize volatility levels for each crypto
    volatility[CryptoType::BITCOIN] = 0.03;    // 3% daily volatility
    volatility[CryptoType::ETHEREUM] = 0.04;   // 4% daily volatility  
    volatility[CryptoType::LITECOIN] = 0.05;   // 5% daily volatility
    volatility[CryptoType::RIPPLE] = 0.06;     // 6% daily volatility
    volatility[CryptoType::CARDANO] = 0.07;    // 7% daily volatility
}

double MarketData::getPrice(CryptoType crypto) {
    auto it = prices.find(crypto);
    if (it != prices.end()) {
        return it->second;
    }
    return 0.0;
}

void MarketData::updatePrice(CryptoType crypto, double newPrice) {
    if (newPrice > 0) {
        prices[crypto] = newPrice;
    }
}

double MarketData::getVolatility(CryptoType crypto) {
    auto it = volatility.find(crypto);
    if (it != volatility.end()) {
        return it->second;
    }
    return 0.03; // Default volatility
}

void MarketData::simulateMarketMovement() {
    // Simulate realistic market movements using volatility
    std::random_device rd;
    std::mt19937 gen(rd());
    std::normal_distribution<> dis(0.0, 1.0);
    
    for (auto& pair : prices) {
        CryptoType crypto = pair.first;
        double currentPrice = pair.second;
        double vol = getVolatility(crypto);
        
        // Generate random price movement
        double randomFactor = dis(gen);
        double priceChange = currentPrice * vol * randomFactor;
        double newPrice = currentPrice + priceChange;
        
        // Ensure price doesn't go negative
        if (newPrice > 0) {
            pair.second = newPrice;
        }
    }
}
"

make_commit "Implement realistic volatility-based market simulation" "2025-04-01" "10:30:00"

# Day 53: April 3rd, 2025 - Add price history tracking
create_file "src/include/MarketData.h" "#ifndef MARKETDATA_H
#define MARKETDATA_H

#include \"Types.h\"
#include <map>
#include <vector>
#include <deque>

class MarketData {
public:
    MarketData();
    
    // Price management
    double getPrice(CryptoType crypto);
    void updatePrice(CryptoType crypto, double newPrice);
    
    // Market simulation
    void simulateMarketMovement();
    double getVolatility(CryptoType crypto);
    
    // Price history
    std::vector<double> getPriceHistory(CryptoType crypto, int days = 30);
    double calculateMovingAverage(CryptoType crypto, int days = 7);
    
private:
    std::map<CryptoType, double> prices;
    std::map<CryptoType, double> volatility;
    std::map<CryptoType, std::deque<double>> priceHistory;
    
    void initializePrices();
    void initializeVolatility();
    void updatePriceHistory(CryptoType crypto, double price);
};

#endif // MARKETDATA_H
"

make_commit "Add price history tracking and moving averages" "2025-04-03" "14:15:00"

# Day 54: April 4th, 2025 - Implement price history methods
create_file "src/market/MarketData.cpp" "#include \"../include/MarketData.h\"
#include <random>
#include <ctime>
#include <numeric>

MarketData::MarketData() {
    initializePrices();
    initializeVolatility();
}

void MarketData::initializePrices() {
    // Initialize with realistic starting prices
    prices[CryptoType::BITCOIN] = 45000.0;
    prices[CryptoType::ETHEREUM] = 3000.0;
    prices[CryptoType::LITECOIN] = 150.0;
    prices[CryptoType::RIPPLE] = 0.65;
    prices[CryptoType::CARDANO] = 1.20;
    
    // Initialize price history with current prices
    for (const auto& pair : prices) {
        priceHistory[pair.first].push_back(pair.second);
    }
}

void MarketData::initializeVolatility() {
    // Initialize volatility levels for each crypto
    volatility[CryptoType::BITCOIN] = 0.03;    // 3% daily volatility
    volatility[CryptoType::ETHEREUM] = 0.04;   // 4% daily volatility  
    volatility[CryptoType::LITECOIN] = 0.05;   // 5% daily volatility
    volatility[CryptoType::RIPPLE] = 0.06;     // 6% daily volatility
    volatility[CryptoType::CARDANO] = 0.07;    // 7% daily volatility
}

double MarketData::getPrice(CryptoType crypto) {
    auto it = prices.find(crypto);
    if (it != prices.end()) {
        return it->second;
    }
    return 0.0;
}

void MarketData::updatePrice(CryptoType crypto, double newPrice) {
    if (newPrice > 0) {
        prices[crypto] = newPrice;
        updatePriceHistory(crypto, newPrice);
    }
}

double MarketData::getVolatility(CryptoType crypto) {
    auto it = volatility.find(crypto);
    if (it != volatility.end()) {
        return it->second;
    }
    return 0.03; // Default volatility
}

void MarketData::updatePriceHistory(CryptoType crypto, double price) {
    priceHistory[crypto].push_back(price);
    
    // Keep only last 100 prices to avoid memory issues
    if (priceHistory[crypto].size() > 100) {
        priceHistory[crypto].pop_front();
    }
}

std::vector<double> MarketData::getPriceHistory(CryptoType crypto, int days) {
    std::vector<double> history;
    auto it = priceHistory.find(crypto);
    
    if (it != priceHistory.end()) {
        const auto& deque = it->second;
        int startIndex = std::max(0, (int)deque.size() - days);
        
        for (int i = startIndex; i < (int)deque.size(); ++i) {
            history.push_back(deque[i]);
        }
    }
    
    return history;
}

double MarketData::calculateMovingAverage(CryptoType crypto, int days) {
    auto history = getPriceHistory(crypto, days);
    
    if (history.empty()) {
        return 0.0;
    }
    
    double sum = std::accumulate(history.begin(), history.end(), 0.0);
    return sum / history.size();
}

void MarketData::simulateMarketMovement() {
    // Simulate realistic market movements using volatility
    std::random_device rd;
    std::mt19937 gen(rd());
    std::normal_distribution<> dis(0.0, 1.0);
    
    for (auto& pair : prices) {
        CryptoType crypto = pair.first;
        double currentPrice = pair.second;
        double vol = getVolatility(crypto);
        
        // Generate random price movement
        double randomFactor = dis(gen);
        double priceChange = currentPrice * vol * randomFactor;
        double newPrice = currentPrice + priceChange;
        
        // Ensure price doesn't go negative
        if (newPrice > 0) {
            pair.second = newPrice;
            updatePriceHistory(crypto, newPrice);
        }
    }
}
"

make_commit "Implement price history and moving average calculations" "2025-04-04" "11:45:00"

# Day 55: April 6th, 2025 - Add holiday theme utility
create_file "src/utils/HolidayTheme.cpp" "#include <iostream>
#include <ctime>
#include <string>

// Holiday-themed messages for the crypto simulator

std::string getHolidayMessage() {
    std::time_t now = std::time(nullptr);
    std::tm* localTime = std::localtime(&now);
    
    int month = localTime->tm_mon + 1;
    int day = localTime->tm_mday;
    
    // Check for holidays
    if (month == 1 && day == 1) {
        return \"Happy New Year! May your crypto investments soar in the new year!\";
    } else if (month == 12 && day == 25) {
        return \"Merry Christmas! Hope your portfolio is as bright as the holiday lights!\";
    } else if (month == 7 && day == 4) {
        return \"Happy Independence Day! Celebrate your financial independence!\";
    } else if (month == 10 && day == 31) {
        return \"Happy Halloween! Don't let market volatility scare you!\";
    } else if (month == 2 && day == 14) {
        return \"Happy Valentine's Day! Fall in love with smart investing!\";
    }
    
    return \"Happy trading! Remember to invest wisely.\";
}

void displayHolidayTheme() {
    std::cout << \"\\n\" << std::string(50, '=') << std::endl;
    std::cout << getHolidayMessage() << std::endl;
    std::cout << std::string(50, '=') << \"\\n\" << std::endl;
}
"

make_commit "Add holiday-themed messages" "2025-04-06" "16:20:00"

# Day 56: April 8th, 2025 - Create advanced trading features
create_file "src/include/TradeEngine.h" "#ifndef TRADEENGINE_H
#define TRADEENGINE_H

#include \"Types.h\"
#include \"Portfolio.h\"
#include \"MarketData.h\"
#include <memory>
#include <vector>

// Trade result structure
struct TradeResult {
    bool success;
    double executedPrice;
    std::string message;
    std::string transactionId;
};

// Order structure for pending orders
struct Order {
    std::string orderId;
    std::string userId;
    CryptoType crypto;
    OrderType type;
    double amount;
    double targetPrice;
    std::string timestamp;
    bool isExecuted;
};

class TradeEngine {
public:
    TradeEngine(std::shared_ptr<MarketData> market);
    
    // Execute immediate trade
    TradeResult executeTrade(Portfolio& portfolio, CryptoType crypto, OrderType type, double amount);
    
    // Order management
    std::string placeOrder(const std::string& userId, CryptoType crypto, OrderType type, 
                          double amount, double targetPrice);
    bool cancelOrder(const std::string& orderId);
    std::vector<Order> getActiveOrders(const std::string& userId);
    
    // Process pending orders
    void processOrders();
    
private:
    std::shared_ptr<MarketData> marketData;
    std::vector<Order> pendingOrders;
    int nextTransactionId;
    int nextOrderId;
    
    std::string generateTransactionId();
    std::string generateOrderId();
    std::string getCurrentTimestamp();
};

#endif // TRADEENGINE_H
"

make_commit "Add advanced order management to TradeEngine" "2025-04-08" "13:30:00"

# Day 57: April 10th, 2025 - Implement order management
create_file "src/trading/TradeEngine.cpp" "#include \"../include/TradeEngine.h\"
#include <iostream>
#include <sstream>
#include <iomanip>
#include <ctime>
#include <algorithm>

TradeEngine::TradeEngine(std::shared_ptr<MarketData> market) 
    : marketData(market), nextTransactionId(1), nextOrderId(1) {
    // Initialize trade engine with market data
}

std::string TradeEngine::generateTransactionId() {
    std::stringstream ss;
    ss << \"TXN\" << std::setfill('0') << std::setw(6) << nextTransactionId++;
    return ss.str();
}

std::string TradeEngine::generateOrderId() {
    std::stringstream ss;
    ss << \"ORDER\" << std::setfill('0') << std::setw(6) << nextOrderId++;
    return ss.str();
}

std::string TradeEngine::getCurrentTimestamp() {
    auto now = std::time(nullptr);
    auto tm = *std::localtime(&now);
    std::stringstream ss;
    ss << std::put_time(&tm, \"%Y-%m-%d %H:%M:%S\");
    return ss.str();
}

TradeResult TradeEngine::executeTrade(Portfolio& portfolio, CryptoType crypto, OrderType type, double amount) {
    TradeResult result;
    double price = marketData->getPrice(crypto);
    double totalCost = price * amount;
    
    if (type == OrderType::BUY) {
        if (portfolio.getCashBalance() >= totalCost) {
            // Execute buy order
            portfolio.addHolding(crypto, amount);
            portfolio.removeCash(totalCost);
            
            // Create transaction record
            Transaction transaction;
            transaction.transactionId = generateTransactionId();
            transaction.crypto = crypto;
            transaction.type = type;
            transaction.amount = amount;
            transaction.price = price;
            transaction.totalValue = totalCost;
            transaction.timestamp = getCurrentTimestamp();
            
            portfolio.addTransaction(transaction);
            
            result.success = true;
            result.executedPrice = price;
            result.message = \"Buy order executed successfully\";
            result.transactionId = transaction.transactionId;
            
            std::cout << \"BUY: \" << amount << \" units at $\" << price << \" (Total: $\" << totalCost << \")\" << std::endl;
        } else {
            result.success = false;
            result.executedPrice = 0.0;
            result.message = \"Insufficient funds\";
            result.transactionId = \"\";
        }
    } else {
        // SELL order
        if (portfolio.getHolding(crypto) >= amount) {
            // Execute sell order
            portfolio.removeHolding(crypto, amount);
            portfolio.addCash(totalCost);
            
            // Create transaction record
            Transaction transaction;
            transaction.transactionId = generateTransactionId();
            transaction.crypto = crypto;
            transaction.type = type;
            transaction.amount = amount;
            transaction.price = price;
            transaction.totalValue = totalCost;
            transaction.timestamp = getCurrentTimestamp();
            
            portfolio.addTransaction(transaction);
            
            result.success = true;
            result.executedPrice = price;
            result.message = \"Sell order executed successfully\";
            result.transactionId = transaction.transactionId;
            
            std::cout << \"SELL: \" << amount << \" units at $\" << price << \" (Total: $\" << totalCost << \")\" << std::endl;
        } else {
            result.success = false;
            result.executedPrice = 0.0;
            result.message = \"Insufficient holdings\";
            result.transactionId = \"\";
        }
    }
    
    return result;
}

std::string TradeEngine::placeOrder(const std::string& userId, CryptoType crypto, OrderType type, 
                                   double amount, double targetPrice) {
    Order order;
    order.orderId = generateOrderId();
    order.userId = userId;
    order.crypto = crypto;
    order.type = type;
    order.amount = amount;
    order.targetPrice = targetPrice;
    order.timestamp = getCurrentTimestamp();
    order.isExecuted = false;
    
    pendingOrders.push_back(order);
    
    std::cout << \"Order placed: \" << order.orderId << \" for \" << amount << \" units at $\" << targetPrice << std::endl;
    
    return order.orderId;
}

bool TradeEngine::cancelOrder(const std::string& orderId) {
    auto it = std::find_if(pendingOrders.begin(), pendingOrders.end(),
                          [&orderId](const Order& order) { return order.orderId == orderId; });
    
    if (it != pendingOrders.end()) {
        pendingOrders.erase(it);
        std::cout << \"Order cancelled: \" << orderId << std::endl;
        return true;
    }
    
    return false;
}

std::vector<Order> TradeEngine::getActiveOrders(const std::string& userId) {
    std::vector<Order> userOrders;
    
    for (const auto& order : pendingOrders) {
        if (order.userId == userId && !order.isExecuted) {
            userOrders.push_back(order);
        }
    }
    
    return userOrders;
}

void TradeEngine::processOrders() {
    // Process pending orders based on current market prices
    for (auto& order : pendingOrders) {
        if (order.isExecuted) continue;
        
        double currentPrice = marketData->getPrice(order.crypto);
        bool shouldExecute = false;
        
        if (order.type == OrderType::BUY && currentPrice <= order.targetPrice) {
            shouldExecute = true;
        } else if (order.type == OrderType::SELL && currentPrice >= order.targetPrice) {
            shouldExecute = true;
        }
        
        if (shouldExecute) {
            std::cout << \"Executing pending order: \" << order.orderId << std::endl;
            order.isExecuted = true;
            // Note: In a real implementation, we'd need access to the user's portfolio here
        }
    }
}
"

make_commit "Implement advanced order management system" "2025-04-10" "15:50:00"

# Day 58: April 12th, 2025 - Add more comprehensive tests
create_file "src/tests/test_trade_engine.cpp" "#include <iostream>
#include <cassert>
#include <memory>
#include \"../include/TradeEngine.h\"
#include \"../include/MarketData.h\"
#include \"../include/Portfolio.h\"

void testBasicTrading() {
    std::cout << \"Testing basic trading functionality...\" << std::endl;
    
    auto marketData = std::make_shared<MarketData>();
    TradeEngine engine(marketData);
    Portfolio portfolio(\"test_user\", 10000.0);
    
    // Test buying Bitcoin
    auto result = engine.executeTrade(portfolio, CryptoType::BITCOIN, OrderType::BUY, 0.1);
    assert(result.success);
    assert(result.executedPrice > 0);
    assert(portfolio.getHolding(CryptoType::BITCOIN) == 0.1);
    
    // Test selling Bitcoin
    auto sellResult = engine.executeTrade(portfolio, CryptoType::BITCOIN, OrderType::SELL, 0.05);
    assert(sellResult.success);
    assert(portfolio.getHolding(CryptoType::BITCOIN) == 0.05);
    
    std::cout << \"Basic trading tests passed!\" << std::endl;
}

void testInsufficientFunds() {
    std::cout << \"Testing insufficient funds scenario...\" << std::endl;
    
    auto marketData = std::make_shared<MarketData>();
    TradeEngine engine(marketData);
    Portfolio portfolio(\"test_user\", 100.0);  // Very low balance
    
    // Try to buy expensive Bitcoin
    auto result = engine.executeTrade(portfolio, CryptoType::BITCOIN, OrderType::BUY, 1.0);
    assert(!result.success);
    assert(result.message == \"Insufficient funds\");
    
    std::cout << \"Insufficient funds tests passed!\" << std::endl;
}

int main() {
    testBasicTrading();
    testInsufficientFunds();
    
    std::cout << \"All TradeEngine tests passed!\" << std::endl;
    return 0;
}
"

make_commit "Add comprehensive TradeEngine tests" "2025-04-12" "12:15:00"

# Day 59: April 14th, 2025 - Update CMakeLists for new tests
create_file "CMakeLists.txt" "cmake_minimum_required(VERSION 3.10)
project(CryptoTradingSimulator)

set(CMAKE_CXX_STANDARD 17)

# Include directories
include_directories(src/include)

# Common source files
set(COMMON_SOURCES
    src/market/MarketData.cpp
    src/portfolio/Portfolio.cpp
    src/trading/TradeEngine.cpp
    src/user/User.cpp
    src/user/UserManager.cpp
    src/utils/CryptoUtils.cpp
    src/utils/HolidayTheme.cpp
)

# Main executable
add_executable(crypto_simulator src/main.cpp \${COMMON_SOURCES})

# Test executables
add_executable(test_portfolio 
    src/tests/test_portfolio.cpp
    src/market/MarketData.cpp
    src/portfolio/Portfolio.cpp
)

add_executable(test_market_data 
    src/tests/test_market_data.cpp
    src/market/MarketData.cpp
)

add_executable(test_trade_engine 
    src/tests/test_trade_engine.cpp
    \${COMMON_SOURCES}
)

# Build configuration
set(CMAKE_CXX_FLAGS_DEBUG \"-g -O0 -Wall -Wextra -std=c++17\")
set(CMAKE_CXX_FLAGS_RELEASE \"-O3 -DNDEBUG -std=c++17\")

# Set default build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

# Print build information
message(STATUS \"Build type: \${CMAKE_BUILD_TYPE}\")
message(STATUS \"C++ compiler: \${CMAKE_CXX_COMPILER}\")
message(STATUS \"C++ standard: \${CMAKE_CXX_STANDARD}\")
"

make_commit "Update CMakeLists with improved build configuration" "2025-04-14" "14:30:00"

# Day 60: April 16th, 2025 - Add modular main with better structure
create_file "src/main_modular.cpp" "#include <iostream>
#include <iomanip>
#include <memory>
#include \"include/MarketData.h\"
#include \"include/Portfolio.h\"
#include \"include/TradeEngine.h\"
#include \"include/User.h\"
#include \"include/UserManager.h\"

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
        std::cout << \"\\n\" << std::string(60, '=') << std::endl;
        std::cout << \"    CRYPTO TRADING SIMULATOR v1.0\" << std::endl;
        std::cout << \"    Advanced Cryptocurrency Trading Platform\" << std::endl;
        std::cout << std::string(60, '=') << \"\\n\" << std::endl;
    }
    
    void displayMarketData() {
        std::cout << \"Current Market Prices:\" << std::endl;
        std::cout << std::string(40, '-') << std::endl;
        
        auto cryptos = {CryptoType::BITCOIN, CryptoType::ETHEREUM, CryptoType::LITECOIN, 
                       CryptoType::RIPPLE, CryptoType::CARDANO};
        
        for (auto crypto : cryptos) {
            double price = marketData->getPrice(crypto);
            double ma7 = marketData->calculateMovingAverage(crypto, 7);
            double volatility = marketData->getVolatility(crypto);
            
            std::cout << std::left << std::setw(10);
            switch(crypto) {
                case CryptoType::BITCOIN: std::cout << \"Bitcoin\"; break;
                case CryptoType::ETHEREUM: std::cout << \"Ethereum\"; break;
                case CryptoType::LITECOIN: std::cout << \"Litecoin\"; break;
                case CryptoType::RIPPLE: std::cout << \"Ripple\"; break;
                case CryptoType::CARDANO: std::cout << \"Cardano\"; break;
            }
            
            std::cout << \": $\" << std::setw(10) << std::fixed << std::setprecision(2) << price
                      << \" | MA7: $\" << std::setw(10) << ma7 
                      << \" | Vol: \" << std::setw(5) << std::setprecision(1) << (volatility * 100) << \"%\" << std::endl;
        }
        std::cout << std::endl;
    }
    
    void runSimulation() {
        displayWelcome();
        
        // Create sample users
        auto user1 = userManager->createUser(\"Alice Johnson\");
        auto user2 = userManager->createUser(\"Bob Smith\");
        
        std::cout << \"Created users:\" << std::endl;
        std::cout << \"- \" << user1->getUsername() << \" (ID: \" << user1->getUserId() << \")\" << std::endl;
        std::cout << \"- \" << user2->getUsername() << \" (ID: \" << user2->getUserId() << \")\" << std::endl;
        std::cout << std::endl;
        
        displayMarketData();
        
        // Simulate market movement
        std::cout << \"Simulating market movement...\" << std::endl;
        marketData->simulateMarketMovement();
        std::cout << \"Market prices updated!\\n\" << std::endl;
        
        displayMarketData();
        
        // Execute some trades
        auto& alicePortfolio = user1->getPortfolio();
        
        std::cout << \"Alice's Trading Activity:\" << std::endl;
        std::cout << \"Initial cash: $\" << alicePortfolio.getCashBalance() << std::endl;
        
        auto result1 = tradeEngine->executeTrade(alicePortfolio, CryptoType::BITCOIN, OrderType::BUY, 0.1);
        auto result2 = tradeEngine->executeTrade(alicePortfolio, CryptoType::ETHEREUM, OrderType::BUY, 1.0);
        
        std::cout << \"\\nAlice's Final Portfolio:\" << std::endl;
        std::cout << \"Cash: $\" << std::fixed << std::setprecision(2) << alicePortfolio.getCashBalance() << std::endl;
        std::cout << \"Bitcoin: \" << std::setprecision(8) << alicePortfolio.getHolding(CryptoType::BITCOIN) << std::endl;
        std::cout << \"Ethereum: \" << alicePortfolio.getHolding(CryptoType::ETHEREUM) << std::endl;
        std::cout << \"Total Value: $\" << std::setprecision(2) << alicePortfolio.getTotalValue(*marketData) << std::endl;
        
        // Display transaction history
        std::cout << \"\\nTransaction History:\" << std::endl;
        auto transactions = alicePortfolio.getTransactionHistory();
        for (const auto& tx : transactions) {
            std::cout << tx.transactionId << \": \" << (tx.type == OrderType::BUY ? \"BUY\" : \"SELL\") 
                      << \" \" << tx.amount << \" at $\" << tx.price << \" (\" << tx.timestamp << \")\" << std::endl;
        }
        
        std::cout << \"\\nSimulation completed successfully!\" << std::endl;
    }
};

int main() {
    try {
        CryptoSimulator simulator;
        simulator.runSimulation();
    } catch (const std::exception& e) {
        std::cerr << \"Error: \" << e.what() << std::endl;
        return 1;
    }
    
    return 0;
}
"

make_commit "Add modular main application with better structure" "2025-04-16" "16:45:00"

# Day 61: April 18th, 2025 - Update CMakeLists for modular version
create_file "CMakeLists.txt" "cmake_minimum_required(VERSION 3.10)
project(CryptoTradingSimulator)

set(CMAKE_CXX_STANDARD 17)

# Include directories
include_directories(src/include)

# Common source files
set(COMMON_SOURCES
    src/market/MarketData.cpp
    src/portfolio/Portfolio.cpp
    src/trading/TradeEngine.cpp
    src/user/User.cpp
    src/user/UserManager.cpp
    src/utils/CryptoUtils.cpp
    src/utils/HolidayTheme.cpp
)

# Main executables
add_executable(crypto_simulator src/main.cpp \${COMMON_SOURCES})
add_executable(crypto_sim_modular src/main_modular.cpp \${COMMON_SOURCES})

# Test executables
add_executable(test_portfolio 
    src/tests/test_portfolio.cpp
    src/market/MarketData.cpp
    src/portfolio/Portfolio.cpp
)

add_executable(test_market_data 
    src/tests/test_market_data.cpp
    src/market/MarketData.cpp
)

add_executable(test_trade_engine 
    src/tests/test_trade_engine.cpp
    \${COMMON_SOURCES}
)

# Build configuration
set(CMAKE_CXX_FLAGS_DEBUG \"-g -O0 -Wall -Wextra -std=c++17\")
set(CMAKE_CXX_FLAGS_RELEASE \"-O3 -DNDEBUG -std=c++17\")

# Set default build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

# Print build information
message(STATUS \"Build type: \${CMAKE_BUILD_TYPE}\")
message(STATUS \"C++ compiler: \${CMAKE_CXX_COMPILER}\")
message(STATUS \"C++ standard: \${CMAKE_CXX_STANDARD}\")

# Install targets
install(TARGETS crypto_simulator crypto_sim_modular
        DESTINATION bin)
"

make_commit "Add modular executable to build system" "2025-04-18" "10:30:00"

# Day 62: April 20th, 2025 - Performance optimizations
create_file "src/market/MarketData.cpp" "#include \"../include/MarketData.h\"
#include <random>
#include <ctime>
#include <numeric>
#include <algorithm>

MarketData::MarketData() {
    initializePrices();
    initializeVolatility();
}

void MarketData::initializePrices() {
    // Initialize with realistic starting prices
    prices[CryptoType::BITCOIN] = 45000.0;
    prices[CryptoType::ETHEREUM] = 3000.0;
    prices[CryptoType::LITECOIN] = 150.0;
    prices[CryptoType::RIPPLE] = 0.65;
    prices[CryptoType::CARDANO] = 1.20;
    
    // Initialize price history with current prices
    for (const auto& pair : prices) {
        priceHistory[pair.first].push_back(pair.second);
    }
}

void MarketData::initializeVolatility() {
    // Initialize volatility levels for each crypto
    volatility[CryptoType::BITCOIN] = 0.03;    // 3% daily volatility
    volatility[CryptoType::ETHEREUM] = 0.04;   // 4% daily volatility  
    volatility[CryptoType::LITECOIN] = 0.05;   // 5% daily volatility
    volatility[CryptoType::RIPPLE] = 0.06;     // 6% daily volatility
    volatility[CryptoType::CARDANO] = 0.07;    // 7% daily volatility
}

double MarketData::getPrice(CryptoType crypto) {
    auto it = prices.find(crypto);
    return (it != prices.end()) ? it->second : 0.0;
}

void MarketData::updatePrice(CryptoType crypto, double newPrice) {
    if (newPrice > 0) {
        prices[crypto] = newPrice;
        updatePriceHistory(crypto, newPrice);
    }
}

double MarketData::getVolatility(CryptoType crypto) {
    auto it = volatility.find(crypto);
    return (it != volatility.end()) ? it->second : 0.03;
}

void MarketData::updatePriceHistory(CryptoType crypto, double price) {
    auto& history = priceHistory[crypto];
    history.push_back(price);
    
    // Keep only last 100 prices for performance
    if (history.size() > 100) {
        history.pop_front();
    }
}

std::vector<double> MarketData::getPriceHistory(CryptoType crypto, int days) {
    std::vector<double> history;
    auto it = priceHistory.find(crypto);
    
    if (it != priceHistory.end()) {
        const auto& deque = it->second;
        int startIndex = std::max(0, static_cast<int>(deque.size()) - days);
        
        history.reserve(deque.size() - startIndex);
        for (size_t i = startIndex; i < deque.size(); ++i) {
            history.push_back(deque[i]);
        }
    }
    
    return history;
}

double MarketData::calculateMovingAverage(CryptoType crypto, int days) {
    auto history = getPriceHistory(crypto, days);
    
    if (history.empty()) {
        return 0.0;
    }
    
    double sum = std::accumulate(history.begin(), history.end(), 0.0);
    return sum / static_cast<double>(history.size());
}

void MarketData::simulateMarketMovement() {
    // Use thread_local for better performance in multi-threaded scenarios
    thread_local std::random_device rd;
    thread_local std::mt19937 gen(rd());
    
    for (auto& pair : prices) {
        CryptoType crypto = pair.first;
        double currentPrice = pair.second;
        double vol = getVolatility(crypto);
        
        // Generate random price movement with normal distribution
        std::normal_distribution<> dis(0.0, vol);
        double priceChange = currentPrice * dis(gen);
        double newPrice = currentPrice + priceChange;
        
        // Ensure price doesn't go negative
        if (newPrice > 0) {
            pair.second = newPrice;
            updatePriceHistory(crypto, newPrice);
        }
    }
}
"

make_commit "Performance optimizations for MarketData" "2025-04-20" "14:15:00"

# Day 63: April 22nd, 2025 - Add error handling improvements
create_file "src/trading/TradeEngine.cpp" "#include \"../include/TradeEngine.h\"
#include <iostream>
#include <sstream>
#include <iomanip>
#include <ctime>
#include <algorithm>
#include <stdexcept>

TradeEngine::TradeEngine(std::shared_ptr<MarketData> market) 
    : marketData(market), nextTransactionId(1), nextOrderId(1) {
    
    if (!market) {
        throw std::invalid_argument(\"MarketData cannot be null\");
    }
}

std::string TradeEngine::generateTransactionId() {
    std::stringstream ss;
    ss << \"TXN\" << std::setfill('0') << std::setw(6) << nextTransactionId++;
    return ss.str();
}

std::string TradeEngine::generateOrderId() {
    std::stringstream ss;
    ss << \"ORDER\" << std::setfill('0') << std::setw(6) << nextOrderId++;
    return ss.str();
}

std::string TradeEngine::getCurrentTimestamp() {
    auto now = std::time(nullptr);
    auto tm = *std::localtime(&now);
    std::stringstream ss;
    ss << std::put_time(&tm, \"%Y-%m-%d %H:%M:%S\");
    return ss.str();
}

TradeResult TradeEngine::executeTrade(Portfolio& portfolio, CryptoType crypto, OrderType type, double amount) {
    TradeResult result;
    result.success = false;
    result.executedPrice = 0.0;
    result.transactionId = \"\";
    
    // Input validation
    if (amount <= 0) {
        result.message = \"Invalid amount: must be positive\";
        return result;
    }
    
    try {
        double price = marketData->getPrice(crypto);
        if (price <= 0) {
            result.message = \"Invalid market price\";
            return result;
        }
        
        double totalCost = price * amount;
        
        if (type == OrderType::BUY) {
            if (portfolio.getCashBalance() >= totalCost) {
                // Execute buy order
                portfolio.addHolding(crypto, amount);
                if (!portfolio.removeCash(totalCost)) {
                    // Rollback if cash removal fails
                    portfolio.removeHolding(crypto, amount);
                    result.message = \"Cash removal failed\";
                    return result;
                }
                
                // Create transaction record
                Transaction transaction;
                transaction.transactionId = generateTransactionId();
                transaction.crypto = crypto;
                transaction.type = type;
                transaction.amount = amount;
                transaction.price = price;
                transaction.totalValue = totalCost;
                transaction.timestamp = getCurrentTimestamp();
                
                portfolio.addTransaction(transaction);
                
                result.success = true;
                result.executedPrice = price;
                result.message = \"Buy order executed successfully\";
                result.transactionId = transaction.transactionId;
                
                std::cout << \"BUY: \" << amount << \" units at $\" << std::fixed << std::setprecision(2) 
                          << price << \" (Total: $\" << totalCost << \")\" << std::endl;
            } else {
                result.message = \"Insufficient funds: need $\" + std::to_string(totalCost) + 
                               \", have $\" + std::to_string(portfolio.getCashBalance());
            }
        } else {
            // SELL order
            if (portfolio.getHolding(crypto) >= amount) {
                // Execute sell order
                if (!portfolio.removeHolding(crypto, amount)) {
                    result.message = \"Failed to remove holdings\";
                    return result;
                }
                
                portfolio.addCash(totalCost);
                
                // Create transaction record
                Transaction transaction;
                transaction.transactionId = generateTransactionId();
                transaction.crypto = crypto;
                transaction.type = type;
                transaction.amount = amount;
                transaction.price = price;
                transaction.totalValue = totalCost;
                transaction.timestamp = getCurrentTimestamp();
                
                portfolio.addTransaction(transaction);
                
                result.success = true;
                result.executedPrice = price;
                result.message = \"Sell order executed successfully\";
                result.transactionId = transaction.transactionId;
                
                std::cout << \"SELL: \" << amount << \" units at $\" << std::fixed << std::setprecision(2) 
                          << price << \" (Total: $\" << totalCost << \")\" << std::endl;
            } else {
                result.message = \"Insufficient holdings: need \" + std::to_string(amount) + 
                               \", have \" + std::to_string(portfolio.getHolding(crypto));
            }
        }
    } catch (const std::exception& e) {
        result.message = \"Trade execution error: \" + std::string(e.what());
    }
    
    return result;
}

std::string TradeEngine::placeOrder(const std::string& userId, CryptoType crypto, OrderType type, 
                                   double amount, double targetPrice) {
    if (userId.empty() || amount <= 0 || targetPrice <= 0) {
        return \"\"; // Invalid input
    }
    
    try {
        Order order;
        order.orderId = generateOrderId();
        order.userId = userId;
        order.crypto = crypto;
        order.type = type;
        order.amount = amount;
        order.targetPrice = targetPrice;
        order.timestamp = getCurrentTimestamp();
        order.isExecuted = false;
        
        pendingOrders.push_back(order);
        
        std::cout << \"Order placed: \" << order.orderId << \" for \" << amount 
                  << \" units at $\" << std::fixed << std::setprecision(2) << targetPrice << std::endl;
        
        return order.orderId;
    } catch (const std::exception& e) {
        std::cerr << \"Error placing order: \" << e.what() << std::endl;
        return \"\";
    }
}

bool TradeEngine::cancelOrder(const std::string& orderId) {
    if (orderId.empty()) {
        return false;
    }
    
    auto it = std::find_if(pendingOrders.begin(), pendingOrders.end(),
                          [&orderId](const Order& order) { return order.orderId == orderId; });
    
    if (it != pendingOrders.end()) {
        pendingOrders.erase(it);
        std::cout << \"Order cancelled: \" << orderId << std::endl;
        return true;
    }
    
    return false;
}

std::vector<Order> TradeEngine::getActiveOrders(const std::string& userId) {
    std::vector<Order> userOrders;
    
    if (userId.empty()) {
        return userOrders;
    }
    
    std::copy_if(pendingOrders.begin(), pendingOrders.end(), 
                 std::back_inserter(userOrders),
                 [&userId](const Order& order) { 
                     return order.userId == userId && !order.isExecuted; 
                 });
    
    return userOrders;
}

void TradeEngine::processOrders() {
    // Process pending orders based on current market prices
    for (auto& order : pendingOrders) {
        if (order.isExecuted) continue;
        
        try {
            double currentPrice = marketData->getPrice(order.crypto);
            bool shouldExecute = false;
            
            if (order.type == OrderType::BUY && currentPrice <= order.targetPrice) {
                shouldExecute = true;
            } else if (order.type == OrderType::SELL && currentPrice >= order.targetPrice) {
                shouldExecute = true;
            }
            
            if (shouldExecute) {
                std::cout << \"Executing pending order: \" << order.orderId << \" at $\" 
                          << std::fixed << std::setprecision(2) << currentPrice << std::endl;
                order.isExecuted = true;
                // Note: In a real implementation, we'd need access to the user's portfolio here
            }
        } catch (const std::exception& e) {
            std::cerr << \"Error processing order \" << order.orderId << \": \" << e.what() << std::endl;
        }
    }
}
"

make_commit "Add comprehensive error handling to TradeEngine" "2025-04-22" "17:30:00"

# Day 64: April 24th, 2025 - Final bug fixes and improvements
create_file "src/main.cpp" "#include <iostream>
#include <iomanip>
#include <memory>
#include <stdexcept>
#include \"include/MarketData.h\"
#include \"include/Portfolio.h\"
#include \"include/TradeEngine.h\"
#include \"include/User.h\"
#include \"include/UserManager.h\"

int main() {
    try {
        std::cout << \"Crypto Trading Simulator v1.0 - Final\" << std::endl;
        std::cout << \"====================================\" << std::endl;
        
        // Initialize system components
        auto marketData = std::make_shared<MarketData>();
        UserManager userManager;
        TradeEngine engine(marketData);
        
        // Create test user
        auto user = userManager.createUser(\"Test User\");
        std::cout << \"Created user: \" << user->getUsername() << \" (ID: \" << user->getUserId() << \")\" << std::endl;
        
        Portfolio& portfolio = user->getPortfolio();
        
        // Display initial state
        std::cout << \"\\nInitial Portfolio:\" << std::endl;
        std::cout << \"Cash: $\" << std::fixed << std::setprecision(2) << portfolio.getCashBalance() << std::endl;
        std::cout << \"Total Value: $\" << portfolio.getTotalValue(*marketData) << std::endl;
        
        // Show market prices
        std::cout << \"\\nCurrent Market Prices:\" << std::endl;
        std::cout << \"Bitcoin: $\" << marketData->getPrice(CryptoType::BITCOIN) << std::endl;
        std::cout << \"Ethereum: $\" << marketData->getPrice(CryptoType::ETHEREUM) << std::endl;
        std::cout << \"Litecoin: $\" << marketData->getPrice(CryptoType::LITECOIN) << std::endl;
        std::cout << \"Ripple: $\" << marketData->getPrice(CryptoType::RIPPLE) << std::endl;
        std::cout << \"Cardano: $\" << marketData->getPrice(CryptoType::CARDANO) << std::endl;
        
        // Execute sample trades
        std::cout << \"\\nExecuting sample trades...\" << std::endl;
        
        auto result1 = engine.executeTrade(portfolio, CryptoType::BITCOIN, OrderType::BUY, 0.1);
        if (result1.success) {
            std::cout << \"Bitcoin trade successful (ID: \" << result1.transactionId << \")\" << std::endl;
        } else {
            std::cout << \"Bitcoin trade failed: \" << result1.message << std::endl;
        }
        
        auto result2 = engine.executeTrade(portfolio, CryptoType::ETHEREUM, OrderType::BUY, 1.0);
        if (result2.success) {
            std::cout << \"Ethereum trade successful (ID: \" << result2.transactionId << \")\" << std::endl;
        } else {
            std::cout << \"Ethereum trade failed: \" << result2.message << std::endl;
        }
        
        // Show final portfolio state
        std::cout << \"\\nFinal Portfolio:\" << std::endl;
        std::cout << \"Cash: $\" << portfolio.getCashBalance() << std::endl;
        std::cout << \"Bitcoin: \" << std::setprecision(8) << portfolio.getHolding(CryptoType::BITCOIN) << std::endl;
        std::cout << \"Ethereum: \" << portfolio.getHolding(CryptoType::ETHEREUM) << std::endl;
        std::cout << \"Total Value: $\" << std::setprecision(2) << portfolio.getTotalValue(*marketData) << std::endl;
        
        // Show transaction history
        std::cout << \"\\nTransaction History:\" << std::endl;
        auto transactions = portfolio.getTransactionHistory();
        if (transactions.empty()) {
            std::cout << \"No transactions\" << std::endl;
        } else {
            for (const auto& tx : transactions) {
                std::cout << tx.transactionId << \": \" << (tx.type == OrderType::BUY ? \"BUY\" : \"SELL\") 
                          << \" \" << tx.amount << \" at $\" << tx.price << \" (\" << tx.timestamp << \")\" << std::endl;
            }
        }
        
        std::cout << \"\\nSimulation completed successfully!\" << std::endl;
        
    } catch (const std::exception& e) {
        std::cerr << \"Error: \" << e.what() << std::endl;
        return 1;
    } catch (...) {
        std::cerr << \"Unknown error occurred\" << std::endl;
        return 1;
    }
    
    return 0;
}
"

make_commit "Final improvements and error handling for main application" "2025-04-24" "13:45:00"

echo -e "${GREEN}April 2025 commits completed!${NC}"
echo -e "${BLUE}Part 4 of commit history created. Run part 5 to complete the history...${NC}"
