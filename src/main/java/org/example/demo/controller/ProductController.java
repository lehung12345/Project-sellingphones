//package org.example.demo.controller;
//
//import jakarta.servlet.http.HttpSession;
//import org.example.demo.entity.User;
//import org.example.demo.service.ProductService;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//
//@Controller
//public class ProductController {
//
//    private final ProductService productService;
//
//    public ProductController(ProductService productService) {
//        this.productService = productService;
//    }
//
//    @GetMapping("/products")
//    public String products(Model model, HttpSession session) {
//
//        // ✅ CHECK LOGIN (đúng key)
//        User user = (User) session.getAttribute("user");
//        if (user == null) {
//            return "redirect:/login";
//        }
//
//        // ✅ LOAD DATA
//        model.addAttribute("products", productService.findAll());
//
//        return "products"; // /WEB-INF/views/products.jsp
//    }
//}




package org.example.demo.controller;

import jakarta.servlet.http.HttpSession;
import org.example.demo.entity.Product;
import org.example.demo.entity.User;
import org.example.demo.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    // ✅ TRANG DANH SÁCH SẢN PHẨM (BẮT BUỘC PHẢI CÓ)
    @GetMapping("/products")
    public String products(Model model, HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        model.addAttribute("products", productService.findAll());

        return "products"; // /WEB-INF/views/products.jsp
    }

    // ✅ TRANG CHI TIẾT
    @GetMapping("/product")
    public String productDetail(@RequestParam Integer id,
                                Model model,
                                HttpSession session) {

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        Product product = productService.findById(id);

        // ❗ tránh null crash
        if (product == null) {
            return "redirect:/products";
        }

        model.addAttribute("product", product);

        return "product-detail";
    }
}
