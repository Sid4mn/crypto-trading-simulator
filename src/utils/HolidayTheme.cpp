#include <iostream>
#include <ctime>
#include <string>

// Holiday-themed messages for the crypto simulator

std::string getHolidayMessage() {
    std::time_t now = std::time(nullptr);
    std::tm* localTime = std::localtime(&now);
    
    int month = localTime->tm_mon + 1;
    int day = localTime->tm_mday;
    
    // Check for holidays
    if (month == 1 && day == 1) {
        return "Happy New Year! May your crypto investments soar in the new year!";
    } else if (month == 12 && day == 25) {
        return "Merry Christmas! Hope your portfolio is as bright as the holiday lights!";
    } else if (month == 7 && day == 4) {
        return "Happy Independence Day! Celebrate your financial independence!";
    } else if (month == 10 && day == 31) {
        return "Happy Halloween! Don't let market volatility scare you!";
    } else if (month == 2 && day == 14) {
        return "Happy Valentine's Day! Fall in love with smart investing!";
    }
    
    return "Happy trading! Remember to invest wisely.";
}

void displayHolidayTheme() {
    std::cout << "\n" << std::string(50, '=') << std::endl;
    std::cout << getHolidayMessage() << std::endl;
    std::cout << std::string(50, '=') << "\n" << std::endl;
}

// Fun holiday theme easter egg
