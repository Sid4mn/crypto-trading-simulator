#include "../include/Config.h"
#include <fstream>
#include <sstream>
#include <iostream>
#include <algorithm>

Config::Config() {
    setDefaults();
}

bool Config::loadFromFile(const std::string& filePath) {
    std::ifstream file(filePath);
    if (!file.is_open()) {
        return false;
    }
    
    std::string line;
    while (std::getline(file, line)) {
        line = trim(line);
        if (line.empty() || line[0] == '#') continue; // Skip comments and empty lines
        
        size_t pos = line.find('=');
        if (pos != std::string::npos) {
            std::string key = trim(line.substr(0, pos));
            std::string value = trim(line.substr(pos + 1));
            
            // Parse trading config
            if (key == "default_cash_balance") {
                tradingConfig.defaultCashBalance = std::stod(value);
            } else if (key == "max_trade_amount") {
                tradingConfig.maxTradeAmount = std::stod(value);
            } else if (key == "min_trade_amount") {
                tradingConfig.minTradeAmount = std::stod(value);
            } else if (key == "enable_risk_warnings") {
                tradingConfig.enableRiskWarnings = (value == "true");
            } else if (key == "enable_price_alerts") {
                tradingConfig.enablePriceAlerts = (value == "true");
            } else if (key == "max_active_orders") {
                tradingConfig.maxActiveOrders = std::stoi(value);
            } else if (key == "volatility_multiplier") {
                tradingConfig.volatilityMultiplier = std::stod(value);
            }
            // Parse display config
            else if (key == "show_colors") {
                displayConfig.showColors = (value == "true");
            } else if (key == "decimal_places") {
                displayConfig.decimalPlaces = std::stoi(value);
            } else if (key == "date_format") {
                displayConfig.dateFormat = value;
            } else if (key == "show_percentages") {
                displayConfig.showPercentages = (value == "true");
            } else if (key == "compact_mode") {
                displayConfig.compactMode = (value == "true");
            }
            // Custom settings
            else {
                customSettings[key] = value;
            }
        }
    }
    
    configFilePath = filePath;
    return true;
}

bool Config::saveToFile(const std::string& filePath) {
    std::ofstream file(filePath);
    if (!file.is_open()) {
        return false;
    }
    
    file << "# Crypto Trading Simulator Configuration\n";
    file << "# Trading Settings\n";
    file << "default_cash_balance=" << tradingConfig.defaultCashBalance << "\n";
    file << "max_trade_amount=" << tradingConfig.maxTradeAmount << "\n";
    file << "min_trade_amount=" << tradingConfig.minTradeAmount << "\n";
    file << "enable_risk_warnings=" << (tradingConfig.enableRiskWarnings ? "true" : "false") << "\n";
    file << "enable_price_alerts=" << (tradingConfig.enablePriceAlerts ? "true" : "false") << "\n";
    file << "max_active_orders=" << tradingConfig.maxActiveOrders << "\n";
    file << "volatility_multiplier=" << tradingConfig.volatilityMultiplier << "\n";
    
    file << "\n# Display Settings\n";
    file << "show_colors=" << (displayConfig.showColors ? "true" : "false") << "\n";
    file << "decimal_places=" << displayConfig.decimalPlaces << "\n";
    file << "date_format=" << displayConfig.dateFormat << "\n";
    file << "show_percentages=" << (displayConfig.showPercentages ? "true" : "false") << "\n";
    file << "compact_mode=" << (displayConfig.compactMode ? "true" : "false") << "\n";
    
    file << "\n# Custom Settings\n";
    for (const auto& setting : customSettings) {
        file << setting.first << "=" << setting.second << "\n";
    }
    
    return true;
}

const Config::TradingConfig& Config::getTradingConfig() const {
    return tradingConfig;
}

const Config::DisplayConfig& Config::getDisplayConfig() const {
    return displayConfig;
}

void Config::setTradingConfig(const TradingConfig& config) {
    tradingConfig = config;
}

void Config::setDisplayConfig(const DisplayConfig& config) {
    displayConfig = config;
}

void Config::setSetting(const std::string& key, const std::string& value) {
    customSettings[key] = value;
}

std::string Config::getSetting(const std::string& key, const std::string& defaultValue) const {
    auto it = customSettings.find(key);
    return (it != customSettings.end()) ? it->second : defaultValue;
}

void Config::resetToDefaults() {
    setDefaults();
    customSettings.clear();
}

std::string Config::getConfigSummary() const {
    std::stringstream ss;
    ss << "=== Configuration Summary ===\n";
    ss << "Trading Settings:\n";
    ss << "  Default Cash Balance: $" << tradingConfig.defaultCashBalance << "\n";
    ss << "  Max Trade Amount: $" << tradingConfig.maxTradeAmount << "\n";
    ss << "  Min Trade Amount: $" << tradingConfig.minTradeAmount << "\n";
    ss << "  Risk Warnings: " << (tradingConfig.enableRiskWarnings ? "Enabled" : "Disabled") << "\n";
    ss << "  Price Alerts: " << (tradingConfig.enablePriceAlerts ? "Enabled" : "Disabled") << "\n";
    ss << "  Max Active Orders: " << tradingConfig.maxActiveOrders << "\n";
    ss << "  Volatility Multiplier: " << tradingConfig.volatilityMultiplier << "\n";
    
    ss << "\nDisplay Settings:\n";
    ss << "  Show Colors: " << (displayConfig.showColors ? "Yes" : "No") << "\n";
    ss << "  Decimal Places: " << displayConfig.decimalPlaces << "\n";
    ss << "  Date Format: " << displayConfig.dateFormat << "\n";
    ss << "  Show Percentages: " << (displayConfig.showPercentages ? "Yes" : "No") << "\n";
    ss << "  Compact Mode: " << (displayConfig.compactMode ? "Yes" : "No") << "\n";
    
    if (!customSettings.empty()) {
        ss << "\nCustom Settings:\n";
        for (const auto& setting : customSettings) {
            ss << "  " << setting.first << ": " << setting.second << "\n";
        }
    }
    
    return ss.str();
}

void Config::setDefaults() {
    // Trading defaults
    tradingConfig.defaultCashBalance = 10000.0;
    tradingConfig.maxTradeAmount = 5000.0;
    tradingConfig.minTradeAmount = 10.0;
    tradingConfig.enableRiskWarnings = true;
    tradingConfig.enablePriceAlerts = true;
    tradingConfig.maxActiveOrders = 10;
    tradingConfig.volatilityMultiplier = 1.0;
    
    // Display defaults
    displayConfig.showColors = true;
    displayConfig.decimalPlaces = 2;
    displayConfig.dateFormat = "%Y-%m-%d %H:%M:%S";
    displayConfig.showPercentages = true;
    displayConfig.compactMode = false;
}

std::vector<std::string> Config::split(const std::string& str, char delimiter) const {
    std::vector<std::string> tokens;
    std::stringstream ss(str);
    std::string token;
    
    while (std::getline(ss, token, delimiter)) {
        tokens.push_back(trim(token));
    }
    
    return tokens;
}

std::string Config::trim(const std::string& str) const {
    const std::string whitespace = " \t\n\r";
    size_t start = str.find_first_not_of(whitespace);
    if (start == std::string::npos) return "";
    
    size_t end = str.find_last_not_of(whitespace);
    return str.substr(start, end - start + 1);
}
