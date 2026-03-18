package org.example.demo.controller;

import jakarta.servlet.http.HttpSession;
import org.example.demo.entity.User;
import org.example.demo.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/products")
    public String products(Model model, HttpSession session) {

        // ✅ CHECK LOGIN (đúng key)
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        // ✅ LOAD DATA
        model.addAttribute("products", productService.findAll());

        return "products"; // /WEB-INF/views/products.jsp
    }
}
