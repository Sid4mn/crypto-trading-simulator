#pragma once
#include <iostream>
#include <fstream>
#include <string>
#include <mutex>
#include <chrono>
#include <ctime>

class Logger {
private:
    std::ofstream logFile;
    std::mutex logMutex;
    
    // singleton stuff
    Logger() {
        logFile.open("trading_simulator.log", std::ios::app);
    }
    
public:
    static Logger& getInstance() {
        static Logger instance;
        return instance;
    }
    
    // delete copy/move constructors for singleton
    Logger(const Logger&) = delete;
    Logger& operator=(const Logger&) = delete;
    
    void log(const std::string& message) {
        std::lock_guard<std::mutex> lock(logMutex);
        
        auto now = std::chrono::system_clock::now();
        auto time_t = std::chrono::system_clock::to_time_t(now);
        
        // both console and file
        std::cout << "[" << std::put_time(std::localtime(&time_t), "%Y-%m-%d %H:%M:%S") 
                  << "] " << message << std::endl;
        
        if (logFile.is_open()) {
            logFile << "[" << std::put_time(std::localtime(&time_t), "%Y-%m-%d %H:%M:%S") 
                    << "] " << message << std::endl;
            logFile.flush();
        }
    }
    
    // keep backwards compatibility
    void info(const std::string& message) { log("[INFO] " + message); }
    void debug(const std::string& message) { log("[DEBUG] " + message); }
    void warning(const std::string& message) { log("[WARN] " + message); }
    void error(const std::string& message) { log("[ERROR] " + message); }
    
    ~Logger() {
        if (logFile.is_open()) {
            logFile.close();
        }
    }
};
