package com.butterflyjewel.service;

import com.butterflyjewel.dto.LoginRequest;
import com.butterflyjewel.dto.RegisterRequest;
import com.butterflyjewel.model.User;
import com.butterflyjewel.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public User register(RegisterRequest req) {
        if (userRepository.existsByEmail(req.getEmail())) {
            throw new RuntimeException("Email is already registered. Please login.");
        }

        User user = new User(
            req.getName(),
            req.getEmail(),
            req.getPhone(),
            req.getPassword(),
            "CUSTOMER"
        );
        return userRepository.save(user);
    }

    public User login(LoginRequest req) {
        String identifier = req.getUsernameEmail();
        Optional<User> userOpt = userRepository.findByEmail(identifier);
        if (userOpt.isEmpty()) {
            userOpt = userRepository.findByName(identifier);
        }

        if (userOpt.isEmpty()) {
            throw new RuntimeException("User not found with provided email/username.");
        }

        User user = userOpt.get();
        if (!user.getPassword().equals(req.getPassword())) {
            throw new RuntimeException("Incorrect password.");
        }

        return user;
    }

    public Optional<User> findById(Long id) {
        return userRepository.findById(id);
    }
}
