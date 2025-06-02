# Crypto Trading Simulator

A C++ cryptocurrency trading simulator for educational purposes.

## Project Goals
- Learn C++ programming
- Understand cryptocurrency markets
- Practice object-oriented design

## Features

### Core Functionality
- **Multi-Cryptocurrency Support**: Trade Bitcoin, Ethereum, Litecoin, Ripple, and Cardano
- **Real-time Market Simulation**: Realistic price movements with volatility modeling
- **Portfolio Management**: Track cash balances and cryptocurrency holdings
- **Transaction History**: Complete audit trail of all trading activities
- **User Management**: Support for multiple user accounts

### Advanced Features
- **Order Management**: Place, track, and cancel pending orders
- **Technical Analysis**: Moving averages and price history tracking
- **Risk Management**: Built-in validation and error handling
- **Performance Optimization**: Efficient algorithms for high-frequency operations
- **Price Alerts**: Set custom alerts for price thresholds
- **Trading Statistics**: Comprehensive performance analytics and metrics
- **Configuration System**: Customizable application settings
- **Logging System**: Detailed logging for debugging and monitoring

## 🛠️ Technical Stack

- **Language**: C++17
- **Build System**: CMake 3.10+
- **Architecture**: Object-oriented design with clean separation of concerns
- **Memory Management**: Smart pointers and RAII principles
- **Testing**: Unit tests for core functionality

## 🔧 Installation

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

## 🚀 Usage

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

## 📁 Project Structure

```
crypto_simulator/
├── src/
│   ├── include/          # Header files
│   ├── market/           # Market data implementation
│   ├── portfolio/        # Portfolio management
│   ├── trading/          # Trading engine
│   ├── user/             # User management
│   ├── utils/            # Utility functions
│   ├── tests/            # Unit tests
│   └── docs/             # Documentation
├── CMakeLists.txt        # Build configuration
└── README.md            # Project documentation
```

## 📚 Documentation

- [Feature Specifications](src/docs/Feature_Specifications.md)
- [API Documentation](src/docs/API_Documentation.md)

---