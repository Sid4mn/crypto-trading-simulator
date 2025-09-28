#pragma once
#include <unordered_map>
#include <string>
#include <fstream>
#include <sstream>

class Config {
private:
    std::unordered_map<std::string, std::string> settings;
    
    Config() {
        loadDefaults();
        // try to load from file, ignore if doesnt exist
        loadFromFile("config.txt");
    }
    
    void loadDefaults() {
        settings["initial_cash"] = "10000.0";
        settings["max_trade_size"] = "1000.0";
        settings["commission_rate"] = "0.001";
        settings["volatility_factor"] = "0.02";
        settings["max_price_history"] = "100";
        // might add more later as we expand features
    }
    
    void loadFromFile(const std::string& filename) {
        std::ifstream file(filename);
        if (!file.is_open()) return; // no config file, use defaults
        
        std::string line;
        while (std::getline(file, line)) {
            if (line.empty() || line[0] == '#') continue;
            
            size_t pos = line.find('=');
            if (pos != std::string::npos) {
                std::string key = line.substr(0, pos);
                std::string value = line.substr(pos + 1);
                // basic trim
                key.erase(0, key.find_first_not_of(" \t"));
                key.erase(key.find_last_not_of(" \t") + 1);
                value.erase(0, value.find_first_not_of(" \t"));
                value.erase(value.find_last_not_of(" \t") + 1);
                
                settings[key] = value;
            }
        }
    }
    
public:
    static Config& getInstance() {
        static Config instance;
        return instance;
    }
    
    Config(const Config&) = delete;
    Config& operator=(const Config&) = delete;
    
    double getDouble(const std::string& key, double defaultValue = 0.0) const {
        auto it = settings.find(key);
        if (it != settings.end()) {
            try {
                return std::stod(it->second);
            } catch (...) {
                // bad conversion, return default
            }
        }
        return defaultValue;
    }
    
    int getInt(const std::string& key, int defaultValue = 0) const {
        auto it = settings.find(key);
        if (it != settings.end()) {
            try {
                return std::stoi(it->second);
            } catch (...) {
                // bad conversion, return default
            }
        }
        return defaultValue;
    }
    
    std::string getString(const std::string& key, const std::string& defaultValue = "") const {
        auto it = settings.find(key);
        return (it != settings.end()) ? it->second : defaultValue;
    }
    
    void setSetting(const std::string& key, const std::string& value) {
        settings[key] = value;
    }
};
