# Crypto Trading Simulator

Basic crypto trading simulator I built to learn C++.

## What is this

Made this to practice C++ and understand how trading systems work. Started with simple buy/sell stuff and kept adding features. Turned out to be good practice for design patterns.

## What it does

- Trade Bitcoin, Ethereum, Litecoin, Ripple, Cardano
- Track your portfolio and see total value
- Keep history of all trades
- Simulate market price changes
- Multiple user accounts (in the advanced version)
- Basic price alerts
- Some trading stats

## How it's built

Clean split across `market/`, `portfolio/`, `trading/`, `user/` modules with a thin TradeEngine facade. Config and Logger are simple singletons. Mostly value semantics and RAII throughout.

The hot functions are stateless and side-effect light so it's easy to add threads later. Caches avoid re-computing expensive summaries. Stuck to contiguous storage (vectors) and O(1) lookups for predictable performance.

**Architecture details:**
- **TradeEngine**: Thin facade that just coordinates between Portfolio and MarketData
- **MarketData**: Uses contiguous storage (vectors) with unordered_map for O(1) symbol lookups  
- **Portfolio**: Value semantics, transaction history in vectors
- **Config/Logger**: Thread-safe singletons with RAII file handling
- **Stateless design**: Most functions don't modify global state, easier to parallelize later

## Building

Compile with g++:

```bash
# Basic version
g++ -std=c++17 -I src/include src/main.cpp src/market/MarketData.cpp src/portfolio/Portfolio.cpp src/trading/TradeEngine.cpp src/utils/Logger.cpp src/utils/Config.cpp -o crypto_simulator

# Version with user management  
g++ -std=c++17 -I src/include src/main_modular.cpp src/market/MarketData.cpp src/portfolio/Portfolio.cpp src/trading/TradeEngine.cpp src/user/User.cpp src/user/UserManager.cpp src/utils/Logger.cpp src/utils/Config.cpp -o crypto_sim_modular
```

CMake also works if you have it:
```bash
mkdir build && cd build
cmake .. && make
```

## Running it

```bash
./crypto_simulator # basic version
./crypto_sim_modular # fancier version with users
```

## Config

Optional config file `config.txt`:
```
initial_cash=10000.0
volatility_factor=0.02
```

Logs go to console and `trading_simulator.log`.

## Notes

This was mainly for learning C++. The market simulation is pretty basic - just random price movements. Not meant for real trading obviously.

Good practice for design patterns, memory management, and organizing larger C++ projects.