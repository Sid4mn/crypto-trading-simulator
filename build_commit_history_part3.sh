#!/bin/bash

# Crypto Trading Simulator - Part 3: March 2025
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

echo -e "${BLUE}=== Part 3: March 2025 ===${NC}"

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
# MARCH 2025 - Adding Advanced Features and Testing
# ============================================================================

echo -e "${YELLOW}Creating March 2025 commits...${NC}"

# Day 33: March 2nd, 2025 - Add UserManager class
create_file "src/include/UserManager.h" "#ifndef USERMANAGER_H
#define USERMANAGER_H

#include \"User.h\"
#include <vector>
#include <memory>

class UserManager {
public:
    UserManager();
    
    // Create a new user
    std::shared_ptr<User> createUser(const std::string& username);
    
    // Get user by ID
    std::shared_ptr<User> getUser(const std::string& userId);
    
    // Get all users
    std::vector<std::shared_ptr<User>> getAllUsers();
    
private:
    std::vector<std::shared_ptr<User>> users;
    int nextUserId;
};

#endif // USERMANAGER_H
"

make_commit "Add UserManager class header" "2025-03-02" "09:45:00"

# Day 34: March 3rd, 2025 - Implement UserManager
create_file "src/user/UserManager.cpp" "#include \"../include/UserManager.h\"
#include <sstream>

UserManager::UserManager() : nextUserId(1) {
    // Initialize user manager
}

std::shared_ptr<User> UserManager::createUser(const std::string& username) {
    // Generate user ID
    std::stringstream ss;
    ss << \"user\" << nextUserId++;
    std::string userId = ss.str();
    
    // Create new user
    auto user = std::make_shared<User>(userId, username);
    users.push_back(user);
    
    return user;
}

std::shared_ptr<User> UserManager::getUser(const std::string& userId) {
    for (auto& user : users) {
        if (user->getUserId() == userId) {
            return user;
        }
    }
    return nullptr;
}

std::vector<std::shared_ptr<User>> UserManager::getAllUsers() {
    return users;
}
"

make_commit "Implement UserManager class" "2025-03-03" "11:30:00"

# Day 35: March 5th, 2025 - Add market simulation
create_file "src/include/MarketData.h" "#ifndef MARKETDATA_H
#define MARKETDATA_H

#include \"Types.h\"
#include <map>

class MarketData {
public:
    MarketData();
    
    // Get current price for a cryptocurrency
    double getPrice(CryptoType crypto);
    
    // Update price for a cryptocurrency
    void updatePrice(CryptoType crypto, double newPrice);
    
    // Simulate market price movements
    void simulateMarketMovement();
    
private:
    std::map<CryptoType, double> prices;
    void initializePrices();
};

#endif // MARKETDATA_H
"

make_commit "Add price simulation methods to MarketData" "2025-03-05" "14:20:00"

# Day 36: March 6th, 2025 - Implement market simulation
create_file "src/market/MarketData.cpp" "#include \"../include/MarketData.h\"
#include <random>
#include <ctime>

MarketData::MarketData() {
    initializePrices();
}

void MarketData::initializePrices() {
    // Initialize with realistic starting prices
    prices[CryptoType::BITCOIN] = 45000.0;
    prices[CryptoType::ETHEREUM] = 3000.0;
    prices[CryptoType::LITECOIN] = 150.0;
    prices[CryptoType::RIPPLE] = 0.65;
    prices[CryptoType::CARDANO] = 1.20;
}

double MarketData::getPrice(CryptoType crypto) {
    auto it = prices.find(crypto);
    if (it != prices.end()) {
        return it->second;
    }
    return 0.0;
}

void MarketData::updatePrice(CryptoType crypto, double newPrice) {
    prices[crypto] = newPrice;
}

void MarketData::simulateMarketMovement() {
    // Simple random price movement simulation
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<> dis(-0.05, 0.05);  // -5% to +5% change
    
    for (auto& pair : prices) {
        double change = dis(gen);
        double newPrice = pair.second * (1.0 + change);
        if (newPrice > 0) {  // Ensure price doesn't go negative
            pair.second = newPrice;
        }
    }
}
"

make_commit "Implement market price simulation" "2025-03-06" "16:15:00"

# Day 37: March 8th, 2025 - Add portfolio value calculation
create_file "src/include/Portfolio.h" "#ifndef PORTFOLIO_H
#define PORTFOLIO_H

#include \"Types.h\"
#include <string>
#include <map>

// Forward declaration
class MarketData;

class Portfolio {
public:
    Portfolio(const std::string& userId, double initialCash = 10000.0);
    
    // Cash management
    double getCashBalance() const;
    void addCash(double amount);
    bool removeCash(double amount);
    
    // Holdings management
    double getHolding(CryptoType crypto) const;
    void addHolding(CryptoType crypto, double amount);
    bool removeHolding(CryptoType crypto, double amount);
    
    // Portfolio value calculation
    double getTotalValue(const MarketData& market) const;
    
private:
    std::string userId;
    double cashBalance;
    std::map<CryptoType, double> holdings;
};

#endif // PORTFOLIO_H
"

make_commit "Add portfolio value calculation method" "2025-03-08" "10:00:00"

# Day 38: March 9th, 2025 - Implement portfolio value calculation
create_file "src/portfolio/Portfolio.cpp" "#include \"../include/Portfolio.h\"
#include \"../include/MarketData.h\"

Portfolio::Portfolio(const std::string& userId, double initialCash) : userId(userId), cashBalance(initialCash) {
    // Initialize with specified cash amount
}

double Portfolio::getCashBalance() const {
    return cashBalance;
}

void Portfolio::addCash(double amount) {
    cashBalance += amount;
}

bool Portfolio::removeCash(double amount) {
    if (cashBalance >= amount) {
        cashBalance -= amount;
        return true;
    }
    return false;
}

double Portfolio::getHolding(CryptoType crypto) const {
    auto it = holdings.find(crypto);
    if (it != holdings.end()) {
        return it->second;
    }
    return 0.0;
}

void Portfolio::addHolding(CryptoType crypto, double amount) {
    holdings[crypto] += amount;
}

bool Portfolio::removeHolding(CryptoType crypto, double amount) {
    auto it = holdings.find(crypto);
    if (it != holdings.end() && it->second >= amount) {
        it->second -= amount;
        return true;
    }
    return false;
}

double Portfolio::getTotalValue(const MarketData& market) const {
    double totalValue = cashBalance;
    
    // Add value of all crypto holdings
    for (const auto& holding : holdings) {
        double cryptoValue = holding.second * market.getPrice(holding.first);
        totalValue += cryptoValue;
    }
    
    return totalValue;
}
"

make_commit "Implement portfolio total value calculation" "2025-03-09" "12:45:00"

# Day 39: March 11th, 2025 - Start working on tests
create_file "src/tests/test_portfolio.cpp" "#include <iostream>
#include <cassert>
#include \"../include/Portfolio.h\"
#include \"../include/MarketData.h\"

void testPortfolioBasics() {
    std::cout << \"Testing Portfolio basics...\" << std::endl;
    
    Portfolio portfolio(\"test_user\", 1000.0);
    
    // Test initial values
    assert(portfolio.getCashBalance() == 1000.0);
    assert(portfolio.getHolding(CryptoType::BITCOIN) == 0.0);
    
    // Test adding holdings
    portfolio.addHolding(CryptoType::BITCOIN, 0.5);
    assert(portfolio.getHolding(CryptoType::BITCOIN) == 0.5);
    
    // Test removing holdings
    bool success = portfolio.removeHolding(CryptoType::BITCOIN, 0.2);
    assert(success);
    assert(portfolio.getHolding(CryptoType::BITCOIN) == 0.3);
    
    std::cout << \"Portfolio tests passed!\" << std::endl;
}

int main() {
    testPortfolioBasics();
    return 0;
}
"

make_commit "Add basic Portfolio unit tests" "2025-03-11" "15:30:00"

# Day 40: March 12th, 2025 - Add MarketData tests
create_file "src/tests/test_market_data.cpp" "#include <iostream>
#include <cassert>
#include \"../include/MarketData.h\"

void testMarketDataBasics() {
    std::cout << \"Testing MarketData basics...\" << std::endl;
    
    MarketData market;
    
    // Test initial prices
    double btcPrice = market.getPrice(CryptoType::BITCOIN);
    assert(btcPrice > 0);
    
    double ethPrice = market.getPrice(CryptoType::ETHEREUM);
    assert(ethPrice > 0);
    
    std::cout << \"Initial BTC price: $\" << btcPrice << std::endl;
    std::cout << \"Initial ETH price: $\" << ethPrice << std::endl;
    
    // Test price updates
    market.updatePrice(CryptoType::BITCOIN, 50000.0);
    assert(market.getPrice(CryptoType::BITCOIN) == 50000.0);
    
    std::cout << \"MarketData tests passed!\" << std::endl;
}

int main() {
    testMarketDataBasics();
    return 0;
}
"

make_commit "Add MarketData unit tests" "2025-03-12" "13:15:00"

# Day 41: March 14th, 2025 - Update CMakeLists for tests
create_file "CMakeLists.txt" "cmake_minimum_required(VERSION 3.10)
project(CryptoTradingSimulator)

set(CMAKE_CXX_STANDARD 17)

# Include directories
include_directories(src/include)

# Main executable source files
set(MAIN_SOURCES
    src/main.cpp
    src/market/MarketData.cpp
    src/portfolio/Portfolio.cpp
    src/trading/TradeEngine.cpp
    src/user/User.cpp
    src/user/UserManager.cpp
)

# Create main executable
add_executable(crypto_simulator \${MAIN_SOURCES})

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
"

make_commit "Update CMakeLists to build test executables" "2025-03-14" "11:00:00"

# Day 42: March 15th, 2025 - Add transaction history
create_file "src/include/Types.h" "#ifndef TYPES_H
#define TYPES_H

#include <string>

// Types for crypto trading simulator

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

// Transaction record
struct Transaction {
    std::string transactionId;
    CryptoType crypto;
    OrderType type;
    double amount;
    double price;
    double totalValue;
    std::string timestamp;
};

#endif // TYPES_H
"

make_commit "Add Transaction struct for history tracking" "2025-03-15" "14:30:00"

# Day 43: March 17th, 2025 - Add transaction history to Portfolio
create_file "src/include/Portfolio.h" "#ifndef PORTFOLIO_H
#define PORTFOLIO_H

#include \"Types.h\"
#include <string>
#include <map>
#include <vector>

// Forward declaration
class MarketData;

class Portfolio {
public:
    Portfolio(const std::string& userId, double initialCash = 10000.0);
    
    // Cash management
    double getCashBalance() const;
    void addCash(double amount);
    bool removeCash(double amount);
    
    // Holdings management
    double getHolding(CryptoType crypto) const;
    void addHolding(CryptoType crypto, double amount);
    bool removeHolding(CryptoType crypto, double amount);
    
    // Portfolio value calculation
    double getTotalValue(const MarketData& market) const;
    
    // Transaction history
    void addTransaction(const Transaction& transaction);
    std::vector<Transaction> getTransactionHistory() const;
    
private:
    std::string userId;
    double cashBalance;
    std::map<CryptoType, double> holdings;
    std::vector<Transaction> transactionHistory;
};

#endif // PORTFOLIO_H
"

make_commit "Add transaction history to Portfolio" "2025-03-17" "10:45:00"

# Day 44: March 18th, 2025 - Implement transaction history
create_file "src/portfolio/Portfolio.cpp" "#include \"../include/Portfolio.h\"
#include \"../include/MarketData.h\"

Portfolio::Portfolio(const std::string& userId, double initialCash) : userId(userId), cashBalance(initialCash) {
    // Initialize with specified cash amount
}

double Portfolio::getCashBalance() const {
    return cashBalance;
}

void Portfolio::addCash(double amount) {
    cashBalance += amount;
}

bool Portfolio::removeCash(double amount) {
    if (cashBalance >= amount) {
        cashBalance -= amount;
        return true;
    }
    return false;
}

double Portfolio::getHolding(CryptoType crypto) const {
    auto it = holdings.find(crypto);
    if (it != holdings.end()) {
        return it->second;
    }
    return 0.0;
}

void Portfolio::addHolding(CryptoType crypto, double amount) {
    holdings[crypto] += amount;
}

bool Portfolio::removeHolding(CryptoType crypto, double amount) {
    auto it = holdings.find(crypto);
    if (it != holdings.end() && it->second >= amount) {
        it->second -= amount;
        return true;
    }
    return false;
}

double Portfolio::getTotalValue(const MarketData& market) const {
    double totalValue = cashBalance;
    
    // Add value of all crypto holdings
    for (const auto& holding : holdings) {
        double cryptoValue = holding.second * market.getPrice(holding.first);
        totalValue += cryptoValue;
    }
    
    return totalValue;
}

void Portfolio::addTransaction(const Transaction& transaction) {
    transactionHistory.push_back(transaction);
}

std::vector<Transaction> Portfolio::getTransactionHistory() const {
    return transactionHistory;
}
"

make_commit "Implement transaction history methods" "2025-03-18" "13:20:00"

# Day 45: March 20th, 2025 - Enhanced TradeEngine with transaction logging
create_file "src/include/TradeEngine.h" "#ifndef TRADEENGINE_H
#define TRADEENGINE_H

#include \"Types.h\"
#include \"Portfolio.h\"
#include \"MarketData.h\"
#include <memory>

// Trade result structure
struct TradeResult {
    bool success;
    double executedPrice;
    std::string message;
};

class TradeEngine {
public:
    TradeEngine(std::shared_ptr<MarketData> market);
    
    // Execute a trade and return result
    TradeResult executeTrade(Portfolio& portfolio, CryptoType crypto, OrderType type, double amount);
    
private:
    std::shared_ptr<MarketData> marketData;
    int nextTransactionId;
    
    std::string generateTransactionId();
    std::string getCurrentTimestamp();
};

#endif // TRADEENGINE_H
"

make_commit "Enhance TradeEngine with trade results and logging" "2025-03-20" "15:00:00"

# Day 46: March 21st, 2025 - Implement enhanced TradeEngine
create_file "src/trading/TradeEngine.cpp" "#include \"../include/TradeEngine.h\"
#include <iostream>
#include <sstream>
#include <iomanip>
#include <ctime>

TradeEngine::TradeEngine(std::shared_ptr<MarketData> market) : marketData(market), nextTransactionId(1) {
    // Initialize trade engine with market data
}

std::string TradeEngine::generateTransactionId() {
    std::stringstream ss;
    ss << \"TXN\" << std::setfill('0') << std::setw(6) << nextTransactionId++;
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
            
            std::cout << \"BUY: \" << amount << \" units at $\" << price << \" (Total: $\" << totalCost << \")\" << std::endl;
        } else {
            result.success = false;
            result.executedPrice = 0.0;
            result.message = \"Insufficient funds\";
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
            
            std::cout << \"SELL: \" << amount << \" units at $\" << price << \" (Total: $\" << totalCost << \")\" << std::endl;
        } else {
            result.success = false;
            result.executedPrice = 0.0;
            result.message = \"Insufficient holdings\";
        }
    }
    
    return result;
}
"

make_commit "Implement enhanced TradeEngine with transaction logging" "2025-03-21" "16:30:00"

# Day 47: March 23rd, 2025 - Update main to use enhanced features
create_file "src/main.cpp" "#include <iostream>
#include <iomanip>
#include \"include/MarketData.h\"
#include \"include/Portfolio.h\"
#include \"include/TradeEngine.h\"
#include \"include/User.h\"
#include \"include/UserManager.h\"

int main() {
    std::cout << \"Crypto Trading Simulator v0.8\" << std::endl;
    std::cout << \"================================\" << std::endl;
    
    // Initialize components
    auto marketData = std::make_shared<MarketData>();
    UserManager userManager;
    TradeEngine engine(marketData);
    
    // Create a user
    auto user = userManager.createUser(\"Alice Johnson\");
    std::cout << \"Created user: \" << user->getUsername() << \" (ID: \" << user->getUserId() << \")\" << std::endl;
    
    Portfolio& portfolio = user->getPortfolio();
    
    // Display initial portfolio
    std::cout << \"\\nInitial Portfolio:\" << std::endl;
    std::cout << \"Cash: $\" << std::fixed << std::setprecision(2) << portfolio.getCashBalance() << std::endl;
    std::cout << \"Total Value: $\" << portfolio.getTotalValue(*marketData) << std::endl;
    
    // Show current market prices
    std::cout << \"\\nCurrent Market Prices:\" << std::endl;
    std::cout << \"Bitcoin: $\" << marketData->getPrice(CryptoType::BITCOIN) << std::endl;
    std::cout << \"Ethereum: $\" << marketData->getPrice(CryptoType::ETHEREUM) << std::endl;
    
    // Execute some trades
    std::cout << \"\\nExecuting trades...\" << std::endl;
    
    auto result1 = engine.executeTrade(portfolio, CryptoType::BITCOIN, OrderType::BUY, 0.1);
    if (result1.success) {
        std::cout << \"Trade 1 successful at $\" << result1.executedPrice << std::endl;
    }
    
    auto result2 = engine.executeTrade(portfolio, CryptoType::ETHEREUM, OrderType::BUY, 1.0);
    if (result2.success) {
        std::cout << \"Trade 2 successful at $\" << result2.executedPrice << std::endl;
    }
    
    // Display final portfolio
    std::cout << \"\\nFinal Portfolio:\" << std::endl;
    std::cout << \"Cash: $\" << portfolio.getCashBalance() << std::endl;
    std::cout << \"Bitcoin: \" << portfolio.getHolding(CryptoType::BITCOIN) << std::endl;
    std::cout << \"Ethereum: \" << portfolio.getHolding(CryptoType::ETHEREUM) << std::endl;
    std::cout << \"Total Value: $\" << portfolio.getTotalValue(*marketData) << std::endl;
    
    // Show transaction history
    std::cout << \"\\nTransaction History:\" << std::endl;
    auto transactions = portfolio.getTransactionHistory();
    for (const auto& tx : transactions) {
        std::cout << tx.transactionId << \": \" << (tx.type == OrderType::BUY ? \"BUY\" : \"SELL\") 
                  << \" \" << tx.amount << \" at $\" << tx.price << std::endl;
    }
    
    return 0;
}
"

make_commit "Update main to demonstrate enhanced features" "2025-03-23" "11:15:00"

# Day 48: March 25th, 2025 - Update CMakeLists for enhanced version
create_file "CMakeLists.txt" "cmake_minimum_required(VERSION 3.10)
project(CryptoTradingSimulator)

set(CMAKE_CXX_STANDARD 17)

# Include directories
include_directories(src/include)

# Main executable source files
set(MAIN_SOURCES
    src/main.cpp
    src/market/MarketData.cpp
    src/portfolio/Portfolio.cpp
    src/trading/TradeEngine.cpp
    src/user/User.cpp
    src/user/UserManager.cpp
)

# Create main executable
add_executable(crypto_simulator \${MAIN_SOURCES})

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

# Add compile options for better debugging
set(CMAKE_CXX_FLAGS_DEBUG \"-g -O0 -Wall -Wextra\")
set(CMAKE_CXX_FLAGS_RELEASE \"-O3 -DNDEBUG\")

# Set default build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()
"

make_commit "Improve CMakeLists with debug flags and build options" "2025-03-25" "14:40:00"

# Day 49: March 27th, 2025 - Add utility functions
create_file "src/utils/CryptoUtils.cpp" "#include <string>
#include <sstream>
#include <iomanip>

// Utility functions for crypto trading simulator

std::string formatCurrency(double amount) {
    std::stringstream ss;
    ss << \"$\" << std::fixed << std::setprecision(2) << amount;
    return ss.str();
}

std::string formatCryptoAmount(double amount) {
    std::stringstream ss;
    ss << std::fixed << std::setprecision(8) << amount;
    return ss.str();
}

double roundToDecimals(double value, int decimals) {
    double factor = 1.0;
    for (int i = 0; i < decimals; ++i) {
        factor *= 10.0;
    }
    return std::round(value * factor) / factor;
}
"

make_commit "Add utility functions for formatting" "2025-03-27" "12:00:00"

# Day 50: March 28th, 2025 - Fix a small bug in portfolio
create_file "src/portfolio/Portfolio.cpp" "#include \"../include/Portfolio.h\"
#include \"../include/MarketData.h\"

Portfolio::Portfolio(const std::string& userId, double initialCash) : userId(userId), cashBalance(initialCash) {
    // Initialize with specified cash amount
}

double Portfolio::getCashBalance() const {
    return cashBalance;
}

void Portfolio::addCash(double amount) {
    if (amount > 0) {  // Only add positive amounts
        cashBalance += amount;
    }
}

bool Portfolio::removeCash(double amount) {
    if (amount > 0 && cashBalance >= amount) {
        cashBalance -= amount;
        return true;
    }
    return false;
}

double Portfolio::getHolding(CryptoType crypto) const {
    auto it = holdings.find(crypto);
    if (it != holdings.end()) {
        return it->second;
    }
    return 0.0;
}

void Portfolio::addHolding(CryptoType crypto, double amount) {
    if (amount > 0) {  // Only add positive amounts
        holdings[crypto] += amount;
    }
}

bool Portfolio::removeHolding(CryptoType crypto, double amount) {
    auto it = holdings.find(crypto);
    if (it != holdings.end() && it->second >= amount && amount > 0) {
        it->second -= amount;
        return true;
    }
    return false;
}

double Portfolio::getTotalValue(const MarketData& market) const {
    double totalValue = cashBalance;
    
    // Add value of all crypto holdings
    for (const auto& holding : holdings) {
        double cryptoValue = holding.second * market.getPrice(holding.first);
        totalValue += cryptoValue;
    }
    
    return totalValue;
}

void Portfolio::addTransaction(const Transaction& transaction) {
    transactionHistory.push_back(transaction);
}

std::vector<Transaction> Portfolio::getTransactionHistory() const {
    return transactionHistory;
}
"

make_commit "Fix portfolio validation for negative amounts" "2025-03-28" "15:20:00"

# Day 51: March 30th, 2025 - Add market volatility simulation
create_file "src/include/MarketData.h" "#ifndef MARKETDATA_H
#define MARKETDATA_H

#include \"Types.h\"
#include <map>

class MarketData {
public:
    MarketData();
    
    // Price management
    double getPrice(CryptoType crypto);
    void updatePrice(CryptoType crypto, double newPrice);
    
    // Market simulation
    void simulateMarketMovement();
    double getVolatility(CryptoType crypto);
    
private:
    std::map<CryptoType, double> prices;
    std::map<CryptoType, double> volatility;
    
    void initializePrices();
    void initializeVolatility();
};

#endif // MARKETDATA_H
"

make_commit "Add volatility tracking to MarketData" "2025-03-30" "17:45:00"

echo -e "${GREEN}March 2025 commits completed!${NC}"
echo -e "${BLUE}Part 3 of commit history created. Run part 4 to continue...${NC}"
