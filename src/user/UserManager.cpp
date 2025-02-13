#include "../include/UserManager.h"
#include <sstream>

UserManager::UserManager() : nextUserId(1) {
    // Initialize user manager
}

std::shared_ptr<User> UserManager::createUser(const std::string& username) {
    // Generate user ID
    std::stringstream ss;
    ss << "user" << nextUserId++;
    std::string userId = ss.str();
    
    // Create new user
    auto user = std::make_shared<User>(userId, username);
    users.push_back(user);
    
    return user;
}

std::shared_ptr<User> UserManager::getUser(const std::string& userId) {
    for (auto& user : users) {
        if (user->getUserId() == userId) {
            return user;
        }
    }
    return nullptr;
}

std::vector<std::shared_ptr<User>> UserManager::getAllUsers() {
    return users;
}

// User management system added
