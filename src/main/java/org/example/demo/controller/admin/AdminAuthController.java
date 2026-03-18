package org.example.demo.controller.admin;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
public class AdminAuthController {

    @GetMapping("/admin")
    public String adminRoot() {
        return "redirect:/admin/login";
    }

    @GetMapping("/admin/login")
    public String loginPage() {
        return "admin/admin-login";
    }

    // ===== LOGIN PROCESS =====
    @PostMapping("/admin/login")
    public String login(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session
    ) {

        // tài khoản admin cố định
        if(email.equals("admin@gmail.com") && password.equals("A1234567890")){

            session.setAttribute("admin", email);

            return "redirect:/admin/users";
        }

        return "redirect:/admin/login?error";
    }

    // ===== LOGOUT =====
    @GetMapping("/admin/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/admin/login";
    }
}