#include "../include/PriceAlert.h"
#include <chrono>
#include <iomanip>
#include <sstream>
#include <algorithm>

PriceAlert::PriceAlert() {
}

std::string PriceAlert::createAlert(const std::string& userId, CryptoType crypto, 
                                   AlertType type, double targetValue, 
                                   const std::string& message) {
    Alert alert;
    alert.id = generateAlertId();
    alert.userId = userId;
    alert.crypto = crypto;
    alert.type = type;
    alert.targetValue = targetValue;
    alert.isActive = true;
    alert.createdAt = getCurrentTimestamp();
    
    if(message.empty()) {
        alert.message = "Price alert triggered!";
    } else {
        alert.message = message;
    }
    
    alerts.push_back(alert);
    return alert.id;
}

bool PriceAlert::removeAlert(const std::string& alertId) {
    auto it = std::find_if(alerts.begin(), alerts.end(),
        [&alertId](const Alert& alert) { return alert.id == alertId; });
    
    if (it != alerts.end()) {
        alerts.erase(it);
        return true;
    }
    return false;
}

std::vector<PriceAlert::Alert> PriceAlert::checkAlerts(const std::map<CryptoType, double>& currentPrices) {
    std::vector<Alert> triggeredAlerts;
    
    for (auto& alert : alerts) {
        if (!alert.isActive) continue;
        
        auto priceIt = currentPrices.find(alert.crypto);
        if (priceIt == currentPrices.end()) continue;
        
        double currentPrice = priceIt->second;
        bool triggered = false;
        
        switch (alert.type) {
            case AlertType::ABOVE:
                triggered = currentPrice >= alert.targetValue;
                break;
            case AlertType::BELOW:
                triggered = currentPrice <= alert.targetValue;
                break;
            case AlertType::CHANGE:
                // For simplicity, we'll implement this as a percentage change from target
                triggered = std::abs(currentPrice - alert.targetValue) / alert.targetValue >= 0.05; // 5% change
                break;
        }
        
        if (triggered) {
            alert.isActive = false; // Deactivate after triggering
            triggeredAlerts.push_back(alert);
            
            if (alertCallback) {
                alertCallback(alert);
            }
        }
    }
    
    return triggeredAlerts;
}

std::vector<PriceAlert::Alert> PriceAlert::getUserAlerts(const std::string& userId) const {
    std::vector<Alert> userAlerts;
    
    for (const auto& alert : alerts) {
        if (alert.userId == userId) {
            userAlerts.push_back(alert);
        }
    }
    
    return userAlerts;
}

void PriceAlert::setAlertCallback(std::function<void(const Alert&)> callback) {
    alertCallback = callback;
}

size_t PriceAlert::getActiveAlertCount() const {
    return std::count_if(alerts.begin(), alerts.end(),
        [](const Alert& alert) { return alert.isActive; });
}

std::string PriceAlert::generateAlertId() const {
    static int counter = 1000;
    return "ALERT_" + std::to_string(++counter);
}

std::string PriceAlert::getCurrentTimestamp() const {
    auto now = std::chrono::system_clock::now();
    auto time_t = std::chrono::system_clock::to_time_t(now);
    
    std::stringstream ss;
    ss << std::put_time(std::localtime(&time_t), "%Y-%m-%d %H:%M:%S");
    return ss.str();
}
