package org.example.demo.controller.admin;

import jakarta.servlet.http.HttpServletRequest;
import org.example.demo.entity.Product;
import org.example.demo.repository.ProductRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;

@Controller
@RequestMapping("/admin/products")
public class AdminProductController {

    private final ProductRepository productRepo;

    public AdminProductController(ProductRepository productRepo) {
        this.productRepo = productRepo;
    }

    // ===== LIST =====
    @GetMapping
    public String list(Model model) {
        List<Product> products = productRepo.findAll();
        model.addAttribute("products", products);
        return "admin/product-list"; // product-list.jsp
    }

    // ===== FORM ADD / EDIT =====
    @GetMapping(params = "action")
    public String form(@RequestParam String action,
                       @RequestParam(required = false) Integer id,
                       Model model) {

        if ("edit".equals(action) && id != null) {
            Product product = productRepo.findById(id).orElse(null);
            model.addAttribute("product", product);
        }

        return "admin/product-form"; // product-form.jsp
    }

    // ===== SAVE (ADD + EDIT) =====
    @PostMapping
    public String save(@RequestParam(required = false) Integer id,
                       @RequestParam String name,
                       @RequestParam long price,
                       @RequestParam int quantity, // 👈 THÊM
                       @RequestParam String description, // 👈 THÊM
                       @RequestParam MultipartFile image,
                       HttpServletRequest request) throws Exception {

        if (quantity < 0) {
            throw new RuntimeException("Số lượng không hợp lệ");
        }

        Product product = (id != null)
                ? productRepo.findById(id).orElse(new Product())
                : new Product();

        product.setName(name);
        product.setPrice(price);
        product.setQuantity(quantity); // 👈 SET
        product.setDescription(description); // 👈 SET

        if (!image.isEmpty()) {
            String uploadDir = request.getServletContext().getRealPath("/images");
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            String fileName = image.getOriginalFilename();
            image.transferTo(new File(dir, fileName));

            product.setImage(fileName);
        }

        productRepo.save(product);
        return "redirect:/admin/products";
    }

    // ===== DELETE =====
    @GetMapping(params = "action=delete")
    public String delete(@RequestParam Integer id) {
        productRepo.deleteById(id);
        return "redirect:/admin/products";
    }
}
