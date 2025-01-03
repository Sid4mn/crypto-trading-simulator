#ifndef USERMANAGER_H
#define USERMANAGER_H

#include "User.h"
#include <vector>
#include <memory>

class UserManager {
public:
    UserManager();
    
    // Create a new user
    std::shared_ptr<User> createUser(const std::string& username);
    
    // Get user by ID
    std::shared_ptr<User> getUser(const std::string& userId);
    
    // Get all users
    std::vector<std::shared_ptr<User>> getAllUsers();
    
private:
    std::vector<std::shared_ptr<User>> users;
    int nextUserId;
};

#endif // USERMANAGER_H

