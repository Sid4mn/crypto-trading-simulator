#ifndef TRADING_STATS_H
#define TRADING_STATS_H

#include "Types.h"
#include <vector>
#include <map>
#include <string>

/**
 * @brief Trading Statistics and Analytics
 * 
 * Provides comprehensive trading performance metrics and analytics
 */
class TradingStats {
public:
    struct PerformanceMetrics {
        double totalProfit;
        double totalLoss;
        double netProfit;
        double winRate;
        int totalTrades;
        int winningTrades;
        int losingTrades;
        double averageTradeSize;
        double largestWin;
        double largestLoss;
        double profitFactor;
        std::string bestPerformingCrypto;
        std::string worstPerformingCrypto;
    };

    struct CryptoPerformance {
        CryptoType crypto;
        double totalProfit;
        int trades;
        double averageReturn;
        double volume;
    };

private:
    std::vector<Transaction> transactions;
    std::map<CryptoType, CryptoPerformance> cryptoStats;
    PerformanceMetrics cachedMetrics;
    bool metricsNeedUpdate;

public:
    TradingStats();
    
    /**
     * @brief Add a transaction to the statistics
     * @param transaction Transaction to analyze
     */
    void addTransaction(const Transaction& transaction);
    
    /**
     * @brief Calculate comprehensive performance metrics
     * @return Performance metrics structure
     */
    PerformanceMetrics calculateMetrics();
    
    /**
     * @brief Get performance for specific cryptocurrency
     * @param crypto Cryptocurrency type
     * @return Crypto-specific performance metrics
     */
    CryptoPerformance getCryptoPerformance(CryptoType crypto) const;
    
    /**
     * @brief Get all cryptocurrency performances
     * @return Map of all crypto performances
     */
    std::map<CryptoType, CryptoPerformance> getAllCryptoPerformances() const;
    
    /**
     * @brief Get recent transaction history
     * @param count Number of recent transactions to return
     * @return Vector of recent transactions
     */
    std::vector<Transaction> getRecentTransactions(int count = 10) const;
    
    /**
     * @brief Calculate monthly profit/loss
     * @param year Year (e.g., 2025)
     * @param month Month (1-12)
     * @return Monthly profit/loss
     */
    double getMonthlyProfitLoss(int year, int month) const;
    
    /**
     * @brief Get trading activity summary
     * @return String summary of trading activity
     */
    std::string getActivitySummary() const;
    
    /**
     * @brief Reset all statistics
     */
    void reset();

private:
    void updateCryptoStats(const Transaction& transaction);
    std::string cryptoTypeToString(CryptoType crypto) const;
    void markMetricsForUpdate();
};

#endif // TRADING_STATS_H
