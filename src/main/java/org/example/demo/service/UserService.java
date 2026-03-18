package org.example.demo.service;

import org.example.demo.entity.User;
import org.example.demo.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    private static final Logger log =
            LoggerFactory.getLogger(UserService.class);

    private final UserRepository userRepository;
    private final BCryptPasswordEncoder encoder;

    public UserService(UserRepository userRepository,
                       BCryptPasswordEncoder encoder) {
        this.userRepository = userRepository;
        this.encoder = encoder;
    }

    // =====================
    // AUTH - REGISTER
    // =====================
    public void register(User user) {
        log.info("REGISTER user email={}", user.getEmail());
        user.setPassword(encoder.encode(user.getPassword()));
        userRepository.save(user);
    }

    // =====================
    // AUTH - LOGIN
    // =====================
    public User login(String email, String rawPassword, String ip) {

        log.info("LOGIN_ATTEMPT email={} ip={}", email, ip);

        // ✅ LẤY Optional
        var optUser = userRepository.findByEmail(email);

        if (optUser.isEmpty()) {
            log.warn("LOGIN_FAIL email_not_found email={} ip={}", email, ip);
            return null;
        }

        User user = optUser.get();

        if (!encoder.matches(rawPassword, user.getPassword())) {
            log.warn("LOGIN_FAIL wrong_password email={} ip={}", email, ip);
            return null;
        }

        log.info("LOGIN_SUCCESS userId={} email={} ip={}",
                user.getId(), email, ip);

        return user;
    }

    // =====================
    // ADMIN - CRUD
    // =====================
    public List<User> findAll() {
        return userRepository.findAll();
    }

    public User findById(Long id) {
        return userRepository.findById(id).orElse(null);
    }

    // ⚠️ Admin save (KHÔNG mã hóa password)
    public void save(User user) {
        userRepository.save(user);
    }

    public void delete(Long id) {
        userRepository.deleteById(id);
    }
}
