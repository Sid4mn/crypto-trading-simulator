#ifndef USER_H
#define USER_H

#include <string>
#include "Portfolio.h"

class User {
public:
    User(const std::string& userId, const std::string& username);
    
    // Getters
    std::string getUserId() const;
    std::string getUsername() const;
    Portfolio& getPortfolio();
    
private:
    std::string userId;
    std::string username;
    Portfolio portfolio;
};

#endif // USER_H

