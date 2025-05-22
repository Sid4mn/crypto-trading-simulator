#ifndef PRICE_ALERT_H
#define PRICE_ALERT_H

#include "Types.h"
#include <string>
#include <vector>
#include <functional>
#include <map>

/**
 * @brief Price Alert System for cryptocurrency price monitoring
 * 
 * Allows users to set alerts when cryptocurrencies reach target prices
 */
class PriceAlert {
public:
    enum class AlertType {
        ABOVE,      ///< Alert when price goes above target
        BELOW,      ///< Alert when price goes below target
        CHANGE      ///< Alert when price changes by percentage
    };

    struct Alert {
        std::string id;
        std::string userId;
        CryptoType crypto;
        AlertType type;
        double targetValue;
        bool isActive;
        std::string createdAt;
        std::string message;
    };

private:
    std::vector<Alert> alerts;
    std::function<void(const Alert&)> alertCallback;

public:
    PriceAlert();
    
    /**
     * @brief Create a new price alert
     * @param userId User ID who owns the alert
     * @param crypto Cryptocurrency to monitor
     * @param type Type of alert (above/below/change)
     * @param targetValue Target price or percentage
     * @param message Custom alert message
     * @return Alert ID
     */
    std::string createAlert(const std::string& userId, CryptoType crypto, 
                          AlertType type, double targetValue, 
                          const std::string& message = "");
    
    /**
     * @brief Remove an alert
     * @param alertId Alert ID to remove
     * @return True if alert was found and removed
     */
    bool removeAlert(const std::string& alertId);
    
    /**
     * @brief Check all alerts against current prices
     * @param currentPrices Map of current cryptocurrency prices
     * @return Vector of triggered alerts
     */
    std::vector<Alert> checkAlerts(const std::map<CryptoType, double>& currentPrices);
    
    /**
     * @brief Get all alerts for a user
     * @param userId User ID
     * @return Vector of user's alerts
     */
    std::vector<Alert> getUserAlerts(const std::string& userId) const;
    
    /**
     * @brief Set callback function for when alerts are triggered
     * @param callback Function to call when alert triggers
     */
    void setAlertCallback(std::function<void(const Alert&)> callback);
    
    /**
     * @brief Get total number of active alerts
     * @return Number of active alerts
     */
    size_t getActiveAlertCount() const;

private:
    std::string generateAlertId() const;
    std::string getCurrentTimestamp() const;
};

#endif // PRICE_ALERT_H
