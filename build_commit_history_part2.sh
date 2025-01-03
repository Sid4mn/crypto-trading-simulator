#!/bin/bash

# Crypto Trading Simulator - Part 2: February 2025
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

echo -e "${BLUE}=== Part 2: February 2025 ===${NC}"

# Functions (same as part 1)
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

append_to_file() {
    local filepath="$1"
    local content="$2"
    
    echo "$content" >> "$filepath"
}

# ============================================================================
# FEBRUARY 2025 - Adding Core Trading Logic
# ============================================================================

echo -e "${YELLOW}Creating February 2025 commits...${NC}"

# Day 14: February 1st, 2025 - Start working on TradeEngine
create_file "src/include/TradeEngine.h" "#ifndef TRADEENGINE_H
#define TRADEENGINE_H

#include \"Types.h\"
#include \"Portfolio.h\"
#include \"MarketData.h\"

class TradeEngine {
public:
    TradeEngine();
    
    // Execute a simple trade
    bool executeTrade(Portfolio& portfolio, CryptoType crypto, OrderType type, double amount);
    
private:
    // TODO: Add trade execution logic
};

#endif // TRADEENGINE_H
"

make_commit "Add TradeEngine class header" "2025-02-01" "09:30:00"

# Day 15: February 2nd, 2025 - Basic TradeEngine implementation
create_file "src/trading/TradeEngine.cpp" "#include \"../include/TradeEngine.h\"
#include <iostream>

TradeEngine::TradeEngine() {
    // Basic constructor
}

bool TradeEngine::executeTrade(Portfolio& portfolio, CryptoType crypto, OrderType type, double amount) {
    // Very basic trade execution
    std::cout << \"Executing trade: \" << (type == OrderType::BUY ? \"BUY\" : \"SELL\") << \" \" << amount << std::endl;
    
    // TODO: Implement actual trade logic
    return true;
}
"

make_commit "Add basic TradeEngine implementation" "2025-02-02" "11:15:00"

# Day 16: February 3rd, 2025 - Update CMakeLists for TradeEngine
create_file "CMakeLists.txt" "cmake_minimum_required(VERSION 3.10)
project(CryptoTradingSimulator)

set(CMAKE_CXX_STANDARD 17)

# Include directories
include_directories(src/include)

# Source files
set(SOURCES
    src/main.cpp
    src/market/MarketData.cpp
    src/portfolio/Portfolio.cpp
    src/trading/TradeEngine.cpp
)

# Create executable
add_executable(crypto_simulator \${SOURCES})
"

make_commit "Update CMakeLists to include TradeEngine" "2025-02-03" "13:45:00"

# Day 17: February 5th, 2025 - Add more crypto types
create_file "src/include/Types.h" "#ifndef TYPES_H
#define TYPES_H

// Basic types for crypto trading simulator

enum class CryptoType {
    BITCOIN,
    ETHEREUM,
    LITECOIN,
    RIPPLE
};

enum class OrderType {
    BUY,
    SELL
};

#endif // TYPES_H
"

make_commit "Add Ripple (XRP) to supported cryptocurrencies" "2025-02-05" "10:20:00"

# Day 18: February 6th, 2025 - Update MarketData for Ripple
create_file "src/market/MarketData.cpp" "#include \"../include/MarketData.h\"

MarketData::MarketData() {
    // Constructor - will add initialization later
}

double MarketData::getPrice(CryptoType crypto) {
    // Temporary hardcoded values - need to make this more realistic
    switch (crypto) {
        case CryptoType::BITCOIN:
            return 45000.0;
        case CryptoType::ETHEREUM:
            return 3000.0;
        case CryptoType::LITECOIN:
            return 150.0;
        case CryptoType::RIPPLE:
            return 0.65;
        default:
            return 0.0;
    }
}
"

make_commit "Add Ripple price support in MarketData" "2025-02-06" "14:30:00"

# Day 19: February 8th, 2025 - Improve Portfolio to handle holdings
create_file "src/include/Portfolio.h" "#ifndef PORTFOLIO_H
#define PORTFOLIO_H

#include \"Types.h\"
#include <string>
#include <map>

class Portfolio {
public:
    Portfolio(const std::string& userId);
    
    // Get current cash balance
    double getCashBalance() const;
    
    // Get holdings for a specific cryptocurrency
    double getHolding(CryptoType crypto) const;
    
    // Add to cryptocurrency holdings
    void addHolding(CryptoType crypto, double amount);
    
    // Remove from cryptocurrency holdings
    bool removeHolding(CryptoType crypto, double amount);
    
private:
    std::string userId;
    double cashBalance;
    std::map<CryptoType, double> holdings;
};

#endif // PORTFOLIO_H
"

make_commit "Add holdings management to Portfolio class" "2025-02-08" "12:10:00"

# Day 20: February 9th, 2025 - Implement new Portfolio methods
create_file "src/portfolio/Portfolio.cpp" "#include \"../include/Portfolio.h\"

Portfolio::Portfolio(const std::string& userId) : userId(userId), cashBalance(10000.0) {
    // Start with $10,000 cash and no crypto holdings
}

double Portfolio::getCashBalance() const {
    return cashBalance;
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
"

make_commit "Implement Portfolio holdings management" "2025-02-09" "15:45:00"

# Day 21: February 11th, 2025 - Test the new portfolio functionality
create_file "src/main.cpp" "#include <iostream>
#include \"include/MarketData.h\"
#include \"include/Portfolio.h\"
#include \"include/TradeEngine.h\"

int main() {
    std::cout << \"Crypto Trading Simulator v0.3\" << std::endl;
    std::cout << \"================================\" << std::endl;
    
    MarketData market;
    Portfolio portfolio(\"user1\");
    TradeEngine engine;
    
    std::cout << \"Current Prices:\" << std::endl;
    std::cout << \"Bitcoin: $\" << market.getPrice(CryptoType::BITCOIN) << std::endl;
    std::cout << \"Ethereum: $\" << market.getPrice(CryptoType::ETHEREUM) << std::endl;
    std::cout << \"Litecoin: $\" << market.getPrice(CryptoType::LITECOIN) << std::endl;
    std::cout << \"Ripple: $\" << market.getPrice(CryptoType::RIPPLE) << std::endl;
    
    std::cout << \"\\nPortfolio:\" << std::endl;
    std::cout << \"Cash balance: $\" << portfolio.getCashBalance() << std::endl;
    std::cout << \"Bitcoin holdings: \" << portfolio.getHolding(CryptoType::BITCOIN) << std::endl;
    
    // Test adding holdings
    portfolio.addHolding(CryptoType::BITCOIN, 0.5);
    std::cout << \"After adding 0.5 BTC: \" << portfolio.getHolding(CryptoType::BITCOIN) << std::endl;
    
    return 0;
}
"

make_commit "Test new Portfolio holdings functionality" "2025-02-11" "16:30:00"

# Day 22: February 12th, 2025 - Improve TradeEngine with actual logic
create_file "src/trading/TradeEngine.cpp" "#include \"../include/TradeEngine.h\"
#include \"../include/MarketData.h\"
#include <iostream>

TradeEngine::TradeEngine() {
    // Basic constructor
}

bool TradeEngine::executeTrade(Portfolio& portfolio, CryptoType crypto, OrderType type, double amount) {
    MarketData market;
    double price = market.getPrice(crypto);
    double totalCost = price * amount;
    
    if (type == OrderType::BUY) {
        // Check if user has enough cash
        if (portfolio.getCashBalance() >= totalCost) {
            std::cout << \"Buying \" << amount << \" units at $\" << price << \" each\" << std::endl;
            portfolio.addHolding(crypto, amount);
            // TODO: Deduct cash from portfolio
            return true;
        } else {
            std::cout << \"Insufficient funds for purchase\" << std::endl;
            return false;
        }
    } else {
        // SELL order
        if (portfolio.getHolding(crypto) >= amount) {
            std::cout << \"Selling \" << amount << \" units at $\" << price << \" each\" << std::endl;
            portfolio.removeHolding(crypto, amount);
            // TODO: Add cash to portfolio
            return true;
        } else {
            std::cout << \"Insufficient holdings to sell\" << std::endl;
            return false;
        }
    }
}
"

make_commit "Improve TradeEngine with basic buy/sell logic" "2025-02-12" "18:20:00"

# Day 23: February 14th, 2025 - Add cash management to Portfolio
create_file "src/include/Portfolio.h" "#ifndef PORTFOLIO_H
#define PORTFOLIO_H

#include \"Types.h\"
#include <string>
#include <map>

class Portfolio {
public:
    Portfolio(const std::string& userId, double initialCash = 10000.0);
    
    // Get current cash balance
    double getCashBalance() const;
    
    // Add or remove cash
    void addCash(double amount);
    bool removeCash(double amount);
    
    // Get holdings for a specific cryptocurrency
    double getHolding(CryptoType crypto) const;
    
    // Add to cryptocurrency holdings
    void addHolding(CryptoType crypto, double amount);
    
    // Remove from cryptocurrency holdings
    bool removeHolding(CryptoType crypto, double amount);
    
private:
    std::string userId;
    double cashBalance;
    std::map<CryptoType, double> holdings;
};

#endif // PORTFOLIO_H
"

make_commit "Add cash management methods to Portfolio" "2025-02-14" "14:45:00"

# Day 24: February 15th, 2025 - Implement cash management
create_file "src/portfolio/Portfolio.cpp" "#include \"../include/Portfolio.h\"

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
"

make_commit "Implement cash management in Portfolio" "2025-02-15" "11:00:00"

# Day 25: February 17th, 2025 - Complete TradeEngine implementation
create_file "src/trading/TradeEngine.cpp" "#include \"../include/TradeEngine.h\"
#include \"../include/MarketData.h\"
#include <iostream>

TradeEngine::TradeEngine() {
    // Basic constructor
}

bool TradeEngine::executeTrade(Portfolio& portfolio, CryptoType crypto, OrderType type, double amount) {
    MarketData market;
    double price = market.getPrice(crypto);
    double totalCost = price * amount;
    
    if (type == OrderType::BUY) {
        // Check if user has enough cash
        if (portfolio.getCashBalance() >= totalCost) {
            std::cout << \"Buying \" << amount << \" units at $\" << price << \" each (Total: $\" << totalCost << \")\" << std::endl;
            
            // Execute the trade
            portfolio.addHolding(crypto, amount);
            portfolio.removeCash(totalCost);
            
            std::cout << \"Trade executed successfully!\" << std::endl;
            return true;
        } else {
            std::cout << \"Insufficient funds for purchase. Need $\" << totalCost << \", have $\" << portfolio.getCashBalance() << std::endl;
            return false;
        }
    } else {
        // SELL order
        if (portfolio.getHolding(crypto) >= amount) {
            std::cout << \"Selling \" << amount << \" units at $\" << price << \" each (Total: $\" << totalCost << \")\" << std::endl;
            
            // Execute the trade
            portfolio.removeHolding(crypto, amount);
            portfolio.addCash(totalCost);
            
            std::cout << \"Trade executed successfully!\" << std::endl;
            return true;
        } else {
            std::cout << \"Insufficient holdings to sell. Need \" << amount << \", have \" << portfolio.getHolding(crypto) << std::endl;
            return false;
        }
    }
}
"

make_commit "Complete TradeEngine implementation with cash handling" "2025-02-17" "13:25:00"

# Day 26: February 18th, 2025 - Test complete trading system
create_file "src/main.cpp" "#include <iostream>
#include \"include/MarketData.h\"
#include \"include/Portfolio.h\"
#include \"include/TradeEngine.h\"

int main() {
    std::cout << \"Crypto Trading Simulator v0.4\" << std::endl;
    std::cout << \"================================\" << std::endl;
    
    MarketData market;
    Portfolio portfolio(\"user1\", 50000.0);  // Start with $50,000
    TradeEngine engine;
    
    std::cout << \"Initial Portfolio:\" << std::endl;
    std::cout << \"Cash: $\" << portfolio.getCashBalance() << std::endl;
    std::cout << \"Bitcoin: \" << portfolio.getHolding(CryptoType::BITCOIN) << std::endl;
    
    std::cout << \"\\nTesting trades...\" << std::endl;
    
    // Try to buy some Bitcoin
    std::cout << \"\\nAttempting to buy 0.1 Bitcoin...\" << std::endl;
    engine.executeTrade(portfolio, CryptoType::BITCOIN, OrderType::BUY, 0.1);
    
    std::cout << \"\\nUpdated Portfolio:\" << std::endl;
    std::cout << \"Cash: $\" << portfolio.getCashBalance() << std::endl;
    std::cout << \"Bitcoin: \" << portfolio.getHolding(CryptoType::BITCOIN) << std::endl;
    
    // Try to sell some Bitcoin
    std::cout << \"\\nAttempting to sell 0.05 Bitcoin...\" << std::endl;
    engine.executeTrade(portfolio, CryptoType::BITCOIN, OrderType::SELL, 0.05);
    
    std::cout << \"\\nFinal Portfolio:\" << std::endl;
    std::cout << \"Cash: $\" << portfolio.getCashBalance() << std::endl;
    std::cout << \"Bitcoin: \" << portfolio.getHolding(CryptoType::BITCOIN) << std::endl;
    
    return 0;
}
"

make_commit "Test complete trading system with buy/sell operations" "2025-02-18" "15:50:00"

# Day 27: February 20th, 2025 - Add User class
create_file "src/include/User.h" "#ifndef USER_H
#define USER_H

#include <string>
#include \"Portfolio.h\"

class User {
public:
    User(const std::string& userId, const std::string& username);
    
    // Getters
    std::string getUserId() const;
    std::string getUsername() const;
    Portfolio& getPortfolio();
    
private:
    std::string userId;
    std::string username;
    Portfolio portfolio;
};

#endif // USER_H
"

make_commit "Add User class header" "2025-02-20" "10:15:00"

# Day 28: February 21st, 2025 - Implement User class
create_file "src/user/User.cpp" "#include \"../include/User.h\"

User::User(const std::string& userId, const std::string& username) 
    : userId(userId), username(username), portfolio(userId) {
    // Initialize user with portfolio
}

std::string User::getUserId() const {
    return userId;
}

std::string User::getUsername() const {
    return username;
}

Portfolio& User::getPortfolio() {
    return portfolio;
}
"

make_commit "Implement User class" "2025-02-21" "12:30:00"

# Day 29: February 23rd, 2025 - Update CMakeLists for User
create_file "CMakeLists.txt" "cmake_minimum_required(VERSION 3.10)
project(CryptoTradingSimulator)

set(CMAKE_CXX_STANDARD 17)

# Include directories
include_directories(src/include)

# Source files
set(SOURCES
    src/main.cpp
    src/market/MarketData.cpp
    src/portfolio/Portfolio.cpp
    src/trading/TradeEngine.cpp
    src/user/User.cpp
)

# Create executable
add_executable(crypto_simulator \${SOURCES})
"

make_commit "Update CMakeLists to include User class" "2025-02-23" "14:00:00"

# Day 30: February 25th, 2025 - Small bug fix
create_file "src/main.cpp" "#include <iostream>
#include \"include/MarketData.h\"
#include \"include/Portfolio.h\"
#include \"include/TradeEngine.h\"
#include \"include/User.h\"

int main() {
    std::cout << \"Crypto Trading Simulator v0.5\" << std::endl;
    std::cout << \"================================\" << std::endl;
    
    MarketData market;
    User user(\"user123\", \"John Doe\");
    TradeEngine engine;
    
    std::cout << \"User: \" << user.getUsername() << \" (ID: \" << user.getUserId() << \")\" << std::endl;
    
    Portfolio& portfolio = user.getPortfolio();
    
    std::cout << \"\\nInitial Portfolio:\" << std::endl;
    std::cout << \"Cash: $\" << portfolio.getCashBalance() << std::endl;
    
    std::cout << \"\\nTesting trades...\" << std::endl;
    
    // Try to buy some Bitcoin
    std::cout << \"\\nAttempting to buy 0.1 Bitcoin...\" << std::endl;
    engine.executeTrade(portfolio, CryptoType::BITCOIN, OrderType::BUY, 0.1);
    
    std::cout << \"\\nUpdated Portfolio:\" << std::endl;
    std::cout << \"Cash: $\" << portfolio.getCashBalance() << std::endl;
    std::cout << \"Bitcoin: \" << portfolio.getHolding(CryptoType::BITCOIN) << std::endl;
    
    return 0;
}
"

make_commit "Update main to use User class" "2025-02-25" "16:45:00"

# Day 31: February 26th, 2025 - Add fifth cryptocurrency
create_file "src/include/Types.h" "#ifndef TYPES_H
#define TYPES_H

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

#endif // TYPES_H
"

make_commit "Add Cardano (ADA) support" "2025-02-26" "11:20:00"

# Day 32: February 28th, 2025 - Update MarketData for Cardano
create_file "src/market/MarketData.cpp" "#include \"../include/MarketData.h\"

MarketData::MarketData() {
    // Constructor - will add proper initialization later
}

double MarketData::getPrice(CryptoType crypto) {
    // Static prices for now - will make dynamic later
    switch (crypto) {
        case CryptoType::BITCOIN:
            return 45000.0;
        case CryptoType::ETHEREUM:
            return 3000.0;
        case CryptoType::LITECOIN:
            return 150.0;
        case CryptoType::RIPPLE:
            return 0.65;
        case CryptoType::CARDANO:
            return 1.20;
        default:
            return 0.0;
    }
}
"

make_commit "Add Cardano price support in MarketData" "2025-02-28" "17:10:00"

echo -e "${GREEN}February 2025 commits completed!${NC}"
echo -e "${BLUE}Part 2 of commit history created. Run part 3 to continue...${NC}"
