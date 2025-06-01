cmake_minimum_required(VERSION 3.10)
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
    src/user/UserManager.cpp
    src/utils/CryptoUtils.cpp
    src/utils/PriceAlert.cpp
    src/utils/TradingStats.cpp
    src/utils/Config.cpp
    src/utils/Logger.cpp
    src/utils/HolidayTheme.cpp
)

# Create executable
add_executable(crypto_simulator ${SOURCES})

