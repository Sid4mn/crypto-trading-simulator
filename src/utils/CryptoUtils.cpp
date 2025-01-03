#include <string>
#include <sstream>
#include <iomanip>
#include <algorithm>
#include <cctype>

// Utility functions for crypto trading simulator

std::string formatCurrency(double amount) {
    std::stringstream ss;
    ss << "$" << std::fixed << std::setprecision(2) << amount;
    return ss.str();
}

std::string formatCryptoAmount(double amount) {
    std::stringstream ss;
    ss << std::fixed << std::setprecision(8) << amount;
    return ss.str();
}

double roundToDecimals(double value, int decimals) {
    if (decimals < 0) decimals = 0;
    if (decimals > 10) decimals = 10;  // Reasonable limit
    
    double factor = 1.0;
    for (int i = 0; i < decimals; ++i) {
        factor *= 10.0;
    }
    return std::round(value * factor) / factor;
}

std::string cryptoTypeToString(int cryptoType) {
    switch (cryptoType) {
        case 0: return "Bitcoin";
        case 1: return "Ethereum";
        case 2: return "Litecoin";
        case 3: return "Ripple";
        case 4: return "Cardano";
        default: return "Unknown";
    }
}

std::string orderTypeToString(int orderType) {
    switch (orderType) {
        case 0: return "BUY";
        case 1: return "SELL";
        default: return "UNKNOWN";
    }
}

std::string toUpperCase(const std::string& str) {
    std::string result = str;
    std::transform(result.begin(), result.end(), result.begin(), ::toupper);
    return result;
}

std::string toLowerCase(const std::string& str) {
    std::string result = str;
    std::transform(result.begin(), result.end(), result.begin(), ::tolower);
    return result;
}

bool isValidAmount(double amount) {
    return amount > 0.0 && amount < 1e10;  // Reasonable bounds
}

bool isValidPrice(double price) {
    return price > 0.0 && price < 1e10;  // Reasonable bounds
}

double calculatePercentageChange(double oldValue, double newValue) {
    if (oldValue == 0.0) return 0.0;
    return ((newValue - oldValue) / oldValue) * 100.0;
}

