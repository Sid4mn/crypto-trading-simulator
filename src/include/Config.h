#ifndef CONFIG_H
#define CONFIG_H

#include <string>
#include <map>
#include <vector>

/**
 * @brief Configuration Management System
 * 
 * Handles application settings and user preferences
 */
class Config {
public:
    struct TradingConfig {
        double defaultCashBalance;
        double maxTradeAmount;
        double minTradeAmount;
        bool enableRiskWarnings;
        bool enablePriceAlerts;
        int maxActiveOrders;
        double volatilityMultiplier;
    };

    struct DisplayConfig {
        bool showColors;
        int decimalPlaces;
        std::string dateFormat;
        bool showPercentages;
        bool compactMode;
    };

private:
    TradingConfig tradingConfig;
    DisplayConfig displayConfig;
    std::map<std::string, std::string> customSettings;
    std::string configFilePath;

public:
    Config();
    
    /**
     * @brief Load configuration from file
     * @param filePath Path to configuration file
     * @return True if loaded successfully
     */
    bool loadFromFile(const std::string& filePath);
    
    /**
     * @brief Save configuration to file
     * @param filePath Path to save configuration
     * @return True if saved successfully
     */
    bool saveToFile(const std::string& filePath);
    
    /**
     * @brief Get trading configuration
     * @return Trading configuration struct
     */
    const TradingConfig& getTradingConfig() const;
    
    /**
     * @brief Get display configuration
     * @return Display configuration struct
     */
    const DisplayConfig& getDisplayConfig() const;
    
    /**
     * @brief Set trading configuration
     * @param config New trading configuration
     */
    void setTradingConfig(const TradingConfig& config);
    
    /**
     * @brief Set display configuration
     * @param config New display configuration
     */
    void setDisplayConfig(const DisplayConfig& config);
    
    /**
     * @brief Set custom setting
     * @param key Setting key
     * @param value Setting value
     */
    void setSetting(const std::string& key, const std::string& value);
    
    /**
     * @brief Get custom setting
     * @param key Setting key
     * @param defaultValue Default value if key not found
     * @return Setting value
     */
    std::string getSetting(const std::string& key, const std::string& defaultValue = "") const;
    
    /**
     * @brief Reset to default configuration
     */
    void resetToDefaults();
    
    /**
     * @brief Get configuration summary
     * @return String summary of current configuration
     */
    std::string getConfigSummary() const;

private:
    void setDefaults();
    std::vector<std::string> split(const std::string& str, char delimiter) const;
    std::string trim(const std::string& str) const;
};

#endif // CONFIG_H
