#include "../include/User.h"

User::User(const std::string& userId, const std::string& username) 
    : userId(userId), username(username), portfolio(userId) {
    // Initialize user with portfolio
}

std::string User::getUserId() const {
    return userId;
}

std::string User::getUsername() const {
    return username;
}

Portfolio& User::getPortfolio() {
    return portfolio;
}

// User statistics tracking
