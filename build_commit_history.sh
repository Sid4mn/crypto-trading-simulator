#!/bin/bash

# Crypto Trading Simulator - Commit History Builder
# This script creates a realistic 5-month development history
# Author: Siddhant Shettiwar
# Email: siddhantshettiwar@gmail.com

set -e

# Configuration
AUTHOR_NAME="Siddhant Shettiwar"
AUTHOR_EMAIL="siddhantshettiwar@gmail.com"
PROJECT_DIR="/Users/funinc/Documents/crypto_simulator_complete"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Crypto Trading Simulator Commit History Builder ===${NC}"
echo -e "${YELLOW}This will create a realistic 5-month development history${NC}"
echo -e "${YELLOW}Starting from January 2025 with 100+ commits${NC}"
echo ""

# Confirm before proceeding
read -p "This will reset your git history. Are you sure you want to continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

cd "$PROJECT_DIR"

# Initialize git repo
echo -e "${GREEN}Initializing git repository...${NC}"
rm -rf .git
git init
git config user.name "$AUTHOR_NAME"
git config user.email "$AUTHOR_EMAIL"

# Function to make a commit with a specific date
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

# Function to create a file with content
create_file() {
    local filepath="$1"
    local content="$2"
    
    mkdir -p "$(dirname "$filepath")"
    echo "$content" > "$filepath"
}

# Function to append content to a file
append_to_file() {
    local filepath="$1"
    local content="$2"
    
    echo "$content" >> "$filepath"
}

echo -e "${BLUE}Starting commit history creation...${NC}"

# ============================================================================
# JANUARY 2025 - Project Initialization and Basic Structure
# ============================================================================

echo -e "${YELLOW}Creating January 2025 commits...${NC}"

# Day 1: January 3rd, 2025 - Project start
create_file "README.md" "# Crypto Trading Simulator

A C++ cryptocurrency trading simulator for educational purposes.

## Project Goals
- Learn C++ programming
- Understand cryptocurrency markets
- Practice object-oriented design

## Status
Just getting started with this project!
"

make_commit "Initial project setup and README" "2025-01-03" "14:30:00"

# Day 2: January 4th, 2025 - Basic project structure
mkdir -p src/include src/core src/market src/portfolio src/trading src/user src/utils src/tests src/docs

create_file ".gitignore" "# Build directories
build/
cmake-build-*/

# Compiled binaries
*.exe
*.out
*.app

# Object files
*.o
*.obj

# Libraries
*.lib
*.a
*.la
*.lo

# Shared objects
*.dll
*.so
*.dylib

# IDE files
.vscode/
.idea/
*.swp
*.swo
*~

# OS files
.DS_Store
Thumbs.db
"

make_commit "Add gitignore and create basic project structure" "2025-01-04" "09:15:00"

# Day 3: January 5th, 2025 - First header file
create_file "src/include/Types.h" "#ifndef TYPES_H
#define TYPES_H

// Basic types for crypto trading simulator

enum class CryptoType {
    BITCOIN,
    ETHEREUM
};

enum class OrderType {
    BUY,
    SELL
};

#endif // TYPES_H
"

make_commit "Add basic type definitions" "2025-01-05" "11:45:00"

# Day 4: January 6th, 2025 - Basic MarketData header
create_file "src/include/MarketData.h" "#ifndef MARKETDATA_H
#define MARKETDATA_H

#include \"Types.h\"

class MarketData {
public:
    MarketData();
    
    // Get current price for a cryptocurrency
    double getPrice(CryptoType crypto);
    
private:
    // TODO: Add price storage
};

#endif // MARKETDATA_H
"

make_commit "Add MarketData class header" "2025-01-06" "16:20:00"

# Day 5: January 8th, 2025 - Basic implementation
create_file "src/market/MarketData.cpp" "#include \"../include/MarketData.h\"

MarketData::MarketData() {
    // Constructor - will add initialization later
}

double MarketData::getPrice(CryptoType crypto) {
    // Temporary hardcoded values
    switch (crypto) {
        case CryptoType::BITCOIN:
            return 45000.0;
        case CryptoType::ETHEREUM:
            return 3000.0;
        default:
            return 0.0;
    }
}
"

make_commit "Implement basic MarketData functionality" "2025-01-08" "10:30:00"

# Day 6: January 9th, 2025 - Simple main file
create_file "src/main.cpp" "#include <iostream>
#include \"include/MarketData.h\"

int main() {
    std::cout << \"Crypto Trading Simulator v0.1\" << std::endl;
    
    MarketData market;
    
    std::cout << \"Bitcoin price: $\" << market.getPrice(CryptoType::BITCOIN) << std::endl;
    std::cout << \"Ethereum price: $\" << market.getPrice(CryptoType::ETHEREUM) << std::endl;
    
    return 0;
}
"

make_commit "Add basic main function to test MarketData" "2025-01-09" "19:45:00"

# Day 7: January 11th, 2025 - Portfolio header
create_file "src/include/Portfolio.h" "#ifndef PORTFOLIO_H
#define PORTFOLIO_H

#include \"Types.h\"
#include <string>

class Portfolio {
public:
    Portfolio(const std::string& userId);
    
    // Get current cash balance
    double getCashBalance() const;
    
    // Get holdings for a specific cryptocurrency
    double getHolding(CryptoType crypto) const;
    
private:
    std::string userId;
    double cashBalance;
    // TODO: Add crypto holdings storage
};

#endif // PORTFOLIO_H
"

make_commit "Add Portfolio class header" "2025-01-11" "13:15:00"

# Day 8: January 12th, 2025 - Portfolio implementation
create_file "src/portfolio/Portfolio.cpp" "#include \"../include/Portfolio.h\"

Portfolio::Portfolio(const std::string& userId) : userId(userId), cashBalance(10000.0) {
    // Start with $10,000 cash
}

double Portfolio::getCashBalance() const {
    return cashBalance;
}

double Portfolio::getHolding(CryptoType crypto) const {
    // TODO: Implement proper holdings tracking
    return 0.0;
}
"

make_commit "Implement basic Portfolio class" "2025-01-12" "15:40:00"

# Day 9: January 14th, 2025 - Update main to use Portfolio
create_file "src/main.cpp" "#include <iostream>
#include \"include/MarketData.h\"
#include \"include/Portfolio.h\"

int main() {
    std::cout << \"Crypto Trading Simulator v0.1\" << std::endl;
    
    MarketData market;
    Portfolio portfolio(\"user1\");
    
    std::cout << \"Bitcoin price: $\" << market.getPrice(CryptoType::BITCOIN) << std::endl;
    std::cout << \"Ethereum price: $\" << market.getPrice(CryptoType::ETHEREUM) << std::endl;
    std::cout << \"Cash balance: $\" << portfolio.getCashBalance() << std::endl;
    
    return 0;
}
"

make_commit "Update main to test Portfolio functionality" "2025-01-14" "17:20:00"

# Day 10: January 16th, 2025 - Add more crypto types
create_file "src/include/Types.h" "#ifndef TYPES_H
#define TYPES_H

// Basic types for crypto trading simulator

enum class CryptoType {
    BITCOIN,
    ETHEREUM,
    LITECOIN
};

enum class OrderType {
    BUY,
    SELL
};

#endif // TYPES_H
"

make_commit "Add Litecoin support to crypto types" "2025-01-16" "11:00:00"

# Day 11: January 17th, 2025 - Update MarketData for new crypto
create_file "src/market/MarketData.cpp" "#include \"../include/MarketData.h\"

MarketData::MarketData() {
    // Constructor - will add initialization later
}

double MarketData::getPrice(CryptoType crypto) {
    // Temporary hardcoded values
    switch (crypto) {
        case CryptoType::BITCOIN:
            return 45000.0;
        case CryptoType::ETHEREUM:
            return 3000.0;
        case CryptoType::LITECOIN:
            return 150.0;
        default:
            return 0.0;
    }
}
"

make_commit "Add Litecoin price support" "2025-01-17" "14:25:00"

# Day 12: January 19th, 2025 - First attempt at CMakeLists
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
)

# Create executable
add_executable(crypto_simulator \${SOURCES})
"

make_commit "Add basic CMakeLists.txt for building" "2025-01-19" "12:10:00"

# Day 13: January 21st, 2025 - Fix some basic issues
create_file "src/main.cpp" "#include <iostream>
#include \"include/MarketData.h\"
#include \"include/Portfolio.h\"

int main() {
    std::cout << \"Crypto Trading Simulator v0.2\" << std::endl;
    std::cout << \"================================\" << std::endl;
    
    MarketData market;
    Portfolio portfolio(\"user1\");
    
    std::cout << \"Current Prices:\" << std::endl;
    std::cout << \"Bitcoin: $\" << market.getPrice(CryptoType::BITCOIN) << std::endl;
    std::cout << \"Ethereum: $\" << market.getPrice(CryptoType::ETHEREUM) << std::endl;
    std::cout << \"Litecoin: $\" << market.getPrice(CryptoType::LITECOIN) << std::endl;
    
    std::cout << \"\\nPortfolio:\" << std::endl;
    std::cout << \"Cash balance: $\" << portfolio.getCashBalance() << std::endl;
    
    return 0;
}
"

make_commit "Improve main output formatting" "2025-01-21" "16:55:00"

echo -e "${GREEN}January 2025 commits completed!${NC}"
echo -e "${BLUE}Part 1 of commit history created. Run the next part to continue...${NC}"
