package org.example.demo.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.example.demo.entity.User;
import org.example.demo.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class AuthController {

    private final UserService userService;

    public AuthController(UserService userService) {
        this.userService = userService;
    }

    // ===== DEFAULT =====
    @GetMapping("/")
    public String index() {
        return "redirect:/register";
    }

    // ===== REGISTER =====
    @GetMapping("/register")
    public String registerForm(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute User user) {
        userService.register(user);
        return "redirect:/login";
    }

    // ===== LOGIN =====
    @GetMapping("/login")
    public String loginForm() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        HttpServletRequest request,
                        HttpSession session,
                        Model model) {

        String ip = request.getRemoteAddr();

        User user = userService.login(email, password, ip);

        if (user != null) {
            session.setAttribute("user", user);
            return "redirect:/products";
        }

        model.addAttribute("error", "Email hoặc mật khẩu không đúng");
        return "login";
    }

    // ===== LOGOUT =====
    @GetMapping("/logout")
    public String logout(HttpSession session, HttpServletRequest request) {

        User user = (User) session.getAttribute("user");
        String ip = request.getRemoteAddr();

        if (user != null) {
            // optional: log logout
            System.out.println("LOGOUT user=" + user.getEmail() + " ip=" + ip);
        }

        session.invalidate();
        return "redirect:/login";
    }
}
