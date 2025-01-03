# Crypto Trading Simulator API Documentation

## Overview
The Crypto Trading Simulator provides a comprehensive API for simulating cryptocurrency trading operations.

## Core Classes

### MarketData
Manages cryptocurrency market prices and historical data.

#### Methods
- `getPrice(CryptoType crypto)` - Get current price for a cryptocurrency
- `updatePrice(CryptoType crypto, double newPrice)` - Update price for a cryptocurrency
- `simulateMarketMovement()` - Simulate random market price movements
- `getVolatility(CryptoType crypto)` - Get volatility for a cryptocurrency
- `getPriceHistory(CryptoType crypto)` - Get historical price data
- `calculateMovingAverage(CryptoType crypto, int days)` - Calculate moving average

### Portfolio
Manages user's cryptocurrency holdings and cash balance.

#### Methods
- `getCashBalance()` - Get current cash balance
- `getHolding(CryptoType crypto)` - Get holdings for a specific cryptocurrency
- `addHolding(CryptoType crypto, double amount)` - Add to cryptocurrency holdings
- `removeHolding(CryptoType crypto, double amount)` - Remove from cryptocurrency holdings
- `getTotalValue(const MarketData& market)` - Calculate total portfolio value
- `getTransactionHistory()` - Get all transaction history

### TradeEngine
Handles trade execution and order management.

#### Methods
- `executeTrade(Portfolio& portfolio, CryptoType crypto, OrderType type, double amount)` - Execute a trade
- `placeOrder(userId, crypto, type, amount, targetPrice)` - Place a trading order
- `cancelOrder(orderId)` - Cancel an existing order
- `getExecutedOrders()` - Get all executed orders

### User
Represents a user in the trading system.

#### Methods
- `getUserId()` - Get user ID
- `getUsername()` - Get username
- `getPortfolio()` - Get user's portfolio
- `getStats()` - Get user trading statistics
- `updateStats(transaction)` - Update user statistics

### UserManager
Manages user accounts and authentication.

#### Methods
- `createUser(username, email)` - Create a new user account
- `loginUser(userId)` - Authenticate user login
- `getCurrentUser()` - Get currently logged in user
- `getAllUsers()` - Get all registered users

## Data Types

### CryptoType Enum
- `BITCOIN` - Bitcoin (BTC)
- `ETHEREUM` - Ethereum (ETH)
- `LITECOIN` - Litecoin (LTC)
- `RIPPLE` - Ripple (XRP)
- `CARDANO` - Cardano (ADA)

### OrderType Enum
- `BUY` - Buy order
- `SELL` - Sell order

### OrderStatus Enum
- `PENDING` - Order waiting to be executed
- `EXECUTED` - Order has been executed
- `CANCELLED` - Order was cancelled

## Usage Examples

### Basic Trading
```cpp
MarketData market;
Portfolio portfolio("user1");
TradeEngine engine(std::make_shared<MarketData>(market));

// Buy Bitcoin
TradeResult result = engine.executeTrade(portfolio, 
    CryptoType::BITCOIN, OrderType::BUY, 0.1);

if (result.success) {
    std::cout << "Trade executed at $" << result.executedPrice << std::endl;
}
```

### Portfolio Management
```cpp
Portfolio portfolio("user1", 50000.0);

// Check balances
double cash = portfolio.getCashBalance();
double btcHolding = portfolio.getHolding(CryptoType::BITCOIN);

// Calculate total value
MarketData market;
double totalValue = portfolio.getTotalValue(market);
```

### Market Analysis
```cpp
MarketData market;

// Get current price
double btcPrice = market.getPrice(CryptoType::BITCOIN);

// Get moving average
double avg = market.calculateMovingAverage(CryptoType::BITCOIN, 7);

// Simulate market movement
market.simulateMarketMovement();
```

