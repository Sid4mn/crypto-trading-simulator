#ifndef LOGGER_H
#define LOGGER_H

#include <string>
#include <fstream>
#include <memory>

/**
 * @brief Simple logging system for the crypto trading simulator
 */
class Logger {
public:
    enum class LogLevel {
        DEBUG,
        INFO,
        WARNING,
        ERROR
    };

private:
    std::unique_ptr<std::ofstream> logFile;
    LogLevel currentLevel;
    bool consoleOutput;

public:
    Logger(const std::string& filename = "crypto_simulator.log");
    ~Logger();
    
    void setLogLevel(LogLevel level);
    void enableConsoleOutput(bool enable);
    
    void debug(const std::string& message);
    void info(const std::string& message);
    void warning(const std::string& message);
    void error(const std::string& message);
    
    void log(LogLevel level, const std::string& message);

private:
    std::string getCurrentTimestamp() const;
    std::string levelToString(LogLevel level) const;
    void writeLog(LogLevel level, const std::string& message);
};

// Global logger instance
extern Logger* g_logger;

// Convenience macros
#define LOG_DEBUG(msg) if(g_logger) g_logger->debug(msg)
#define LOG_INFO(msg) if(g_logger) g_logger->info(msg)
#define LOG_WARNING(msg) if(g_logger) g_logger->warning(msg)
#define LOG_ERROR(msg) if(g_logger) g_logger->error(msg)

#endif // LOGGER_H
