package org.example.demo.controller.admin;

import org.example.demo.entity.User;
import org.example.demo.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/users")
public class AdminUserController {

    private final UserService userService;

    public AdminUserController(UserService userService) {
        this.userService = userService;
    }

    // ======================
    // GET: LIST + EDIT FORM
    // ======================
    @GetMapping
    public String handleGet(
            @RequestParam(required = false) String action,
            @RequestParam(required = false) Long id,
            Model model
    ) {

        // 👉 EDIT
        if ("edit".equals(action) && id != null) {
            User user = userService.findById(id);
            model.addAttribute("user", user);
            return "admin/edit-user"; // JSP sửa user
        }

        // 👉 DEFAULT: LIST USERS
        model.addAttribute("users", userService.findAll());
        return "admin/users"; // JSP danh sách
    }

    // ======================
    // POST: UPDATE + DELETE
    // ======================
    @PostMapping
    public String handlePost(
            @RequestParam String action,
            @RequestParam(required = false) Long id,
            @ModelAttribute User formUser
    ) {

        // 👉 UPDATE
        if ("update".equals(action)) {
            User user = userService.findById(id);

            user.setFullname(formUser.getFullname());
            user.setPhone(formUser.getPhone());
            user.setAddress(formUser.getAddress());

            // ❌ KHÔNG sửa email & password
            userService.save(user);
        }

        // 👉 DELETE
        if ("delete".equals(action)) {
            userService.delete(id);
        }

        return "redirect:/admin/users";
    }
}
