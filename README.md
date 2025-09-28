# Crypto Trading Simulator

A C++ learning project implementing a basic cryptocurrency trading simulator.

## What This Is
Built this while learning C++ and trying to understand how trading systems work. Started simple with basic buy/sell operations and gradually added more features over a few months.

## Features

### Core Trading:
- **Multi-Cryptocurrency Support**: Trade 5 cryptocurrencies (Bitcoin, Ethereum, Litecoin, Ripple, Cardano)
- **Portfolio Management**: Basic portfolio tracking (cash + holdings)
- **Transaction History**: Complete audit trail of all trading activities
- **Market Analysis**: Market price simulation with some volatility

### Additional Stuff:
- User accounts and management
- Price alerts when coins hit target prices
- Trading statistics (profit/loss, etc.)
- Some technical indicators (moving averages)
- Configuration file support
- Basic logging

## Requirements

- **Language**: C++17
- **Build System**: CMake 3.10+
- **Architecture**: Object-oriented design with clean separation of concerns
- **Memory Management**: Smart pointers and RAII principles
- **Testing**: Unit tests for core functionality

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/crypto-trading-simulator.git
cd crypto-trading-simulator
```

2. Create build directory:
```bash
mkdir build
cd build
```

3. Generate build files:
```bash
cmake ..
```

4. Compile the project:
```bash
make
```

## Usage

### Basic Usage
Run the main simulator:
```bash
./crypto_simulator
```

### Modular Version
For advanced features:
```bash
./crypto_sim_modular
```

### Running Tests
Execute unit tests:
```bash
./test_portfolio
./test_market_data
./test_trade_engine
```

## Documentation

- [Feature Specifications](src/docs/Feature_Specifications.md)
- [API Documentation](src/docs/API_Documentation.md)

## Notes
This was mainly a learning project to get familiar with C++ design patterns, memory management, and building something more complex than simple exercises. The "market simulation" is pretty basic - just random price movements with some volatility modeling.

Performance isn't optimized for high-frequency trading or anything like that. It's more about understanding the concepts and practicing clean code organization.