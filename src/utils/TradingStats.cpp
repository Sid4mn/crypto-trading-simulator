#include "../include/TradingStats.h"
#include <algorithm>
#include <numeric>
#include <sstream>
#include <iomanip>

TradingStats::TradingStats() : metricsNeedUpdate(true) {
    // Initialize cached metrics
    cachedMetrics = {};
}

void TradingStats::addTransaction(const Transaction& transaction) {
    transactions.push_back(transaction);
    updateCryptoStats(transaction);
    markMetricsForUpdate();
}

TradingStats::PerformanceMetrics TradingStats::calculateMetrics() {
    if (!metricsNeedUpdate && !transactions.empty()) {
        return cachedMetrics;
    }
    
    PerformanceMetrics metrics = {};
    
    if (transactions.empty()) {
        return metrics;
    }
    
    // Calculate basic metrics
    metrics.totalTrades = static_cast<int>(transactions.size());
    
    double totalBuyValue = 0.0;
    double totalSellValue = 0.0;
    std::map<CryptoType, double> cryptoProfits;
    
    for (const auto& tx : transactions) {
        if (tx.orderType == OrderType::BUY) {
            totalBuyValue += tx.amount * tx.price;
        } else {
            totalSellValue += tx.amount * tx.price;
            
            // Simple profit calculation (sell - average buy price)
            double profit = tx.amount * tx.price * 0.02; // Simplified 2% profit assumption
            if (profit > 0) {
                metrics.totalProfit += profit;
                metrics.winningTrades++;
                metrics.largestWin = std::max(metrics.largestWin, profit);
            } else {
                metrics.totalLoss += std::abs(profit);
                metrics.losingTrades++;
                metrics.largestLoss = std::max(metrics.largestLoss, std::abs(profit));
            }
            
            cryptoProfits[tx.cryptoType] += profit;
        }
        
        metrics.averageTradeSize += tx.amount * tx.price;
    }
    
    // Calculate derived metrics
    metrics.netProfit = metrics.totalProfit - metrics.totalLoss;
    metrics.winRate = metrics.totalTrades > 0 ? 
        (static_cast<double>(metrics.winningTrades) / metrics.totalTrades) * 100.0 : 0.0;
    metrics.averageTradeSize /= metrics.totalTrades;
    
    metrics.profitFactor = metrics.totalLoss > 0 ? 
        metrics.totalProfit / metrics.totalLoss : 0.0;
    
    // Find best and worst performing crypto
    if (!cryptoProfits.empty()) {
        auto bestCrypto = std::max_element(cryptoProfits.begin(), cryptoProfits.end(),
            [](const auto& a, const auto& b) { return a.second < b.second; });
        auto worstCrypto = std::min_element(cryptoProfits.begin(), cryptoProfits.end(),
            [](const auto& a, const auto& b) { return a.second < b.second; });
        
        metrics.bestPerformingCrypto = cryptoTypeToString(bestCrypto->first);
        metrics.worstPerformingCrypto = cryptoTypeToString(worstCrypto->first);
    }
    
    cachedMetrics = metrics;
    metricsNeedUpdate = false;
    
    return metrics;
}

TradingStats::CryptoPerformance TradingStats::getCryptoPerformance(CryptoType crypto) const {
    auto it = cryptoStats.find(crypto);
    if (it != cryptoStats.end()) {
        return it->second;
    }
    
    CryptoPerformance empty = {};
    empty.crypto = crypto;
    return empty;
}

std::map<CryptoType, TradingStats::CryptoPerformance> TradingStats::getAllCryptoPerformances() const {
    return cryptoStats;
}

std::vector<Transaction> TradingStats::getRecentTransactions(int count) const {
    if (transactions.size() <= static_cast<size_t>(count)) {
        return transactions;
    }
    
    return std::vector<Transaction>(transactions.end() - count, transactions.end());
}

double TradingStats::getMonthlyProfitLoss(int year, int month) const {
    double monthlyPL = 0.0;
    
    for (const auto& tx : transactions) {
        // Simplified date parsing - in real implementation would parse timestamp
        if (tx.orderType == OrderType::SELL) {
            monthlyPL += tx.amount * tx.price * 0.02; // Simplified calculation
        }
    }
    
    return monthlyPL;
}

std::string TradingStats::getActivitySummary() const {
    auto metrics = const_cast<TradingStats*>(this)->calculateMetrics();
    
    std::stringstream ss;
    ss << std::fixed << std::setprecision(2);
    ss << "=== Trading Activity Summary ===\n";
    ss << "Total Trades: " << metrics.totalTrades << "\n";
    ss << "Win Rate: " << metrics.winRate << "%\n";
    ss << "Net Profit: $" << metrics.netProfit << "\n";
    ss << "Profit Factor: " << metrics.profitFactor << "\n";
    ss << "Average Trade Size: $" << metrics.averageTradeSize << "\n";
    ss << "Best Performing Crypto: " << metrics.bestPerformingCrypto << "\n";
    ss << "Worst Performing Crypto: " << metrics.worstPerformingCrypto << "\n";
    
    return ss.str();
}

void TradingStats::reset() {
    transactions.clear();
    cryptoStats.clear();
    cachedMetrics = {};
    markMetricsForUpdate();
}

void TradingStats::updateCryptoStats(const Transaction& transaction) {
    auto& stats = cryptoStats[transaction.cryptoType];
    stats.crypto = transaction.cryptoType;
    stats.trades++;
    stats.volume += transaction.amount * transaction.price;
    
    if (transaction.orderType == OrderType::SELL) {
        stats.totalProfit += transaction.amount * transaction.price * 0.02; // Simplified
    }
    
    stats.averageReturn = stats.trades > 0 ? stats.totalProfit / stats.trades : 0.0;
}

std::string TradingStats::cryptoTypeToString(CryptoType crypto) const {
    switch (crypto) {
        case CryptoType::BITCOIN: return "Bitcoin";
        case CryptoType::ETHEREUM: return "Ethereum";
        case CryptoType::LITECOIN: return "Litecoin";
        case CryptoType::RIPPLE: return "Ripple";
        case CryptoType::CARDANO: return "Cardano";
        default: return "Unknown";
    }
}

void TradingStats::markMetricsForUpdate() {
    metricsNeedUpdate = true;
}
