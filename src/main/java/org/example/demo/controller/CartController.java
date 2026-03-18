package org.example.demo.controller;

import jakarta.servlet.http.HttpSession;
import org.example.demo.Model.CartItem;
import org.example.demo.entity.Product;
import org.example.demo.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Iterator;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/cart")
@SessionAttributes("cart")
public class CartController {

    private final ProductService productService;

    public CartController(ProductService productService) {
        this.productService = productService;
    }

    // ✅ KHỞI TẠO CART TRONG SESSION
    @ModelAttribute("cart")
    public List<CartItem> initCart() {
        return new ArrayList<>();
    }

    // ===== VIEW CART =====
    @GetMapping
    public String viewCart(@ModelAttribute("cart") List<CartItem> cart,
                           Model model) {

        long total = cart.stream()
                .mapToLong(i -> i.getProduct().getPrice() * i.getQuantity())
                .sum();

        model.addAttribute("total", total);
        return "cart";
    }

    // ===== ADD TO CART =====
    @GetMapping("/add/{id}")
    public String addToCart(@PathVariable Integer id,
                            @ModelAttribute("cart") List<CartItem> cart) {

        Product product = productService.findById(id);

        for (CartItem item : cart) {
            if (item.getProduct().getId().equals(id)) {
                item.setQuantity(item.getQuantity() + 1);
                return "redirect:/cart";
            }
        }

        cart.add(new CartItem(product, 1));
        return "redirect:/cart";
    }

    // ===== REMOVE =====
    @GetMapping("/remove/{id}")
    public String remove(@PathVariable Integer id,
                         @ModelAttribute("cart") List<CartItem> cart) {

        cart.removeIf(i -> i.getProduct().getId().equals(id));
        return "redirect:/cart";
    }


    // ===== INCREASE =====
    @GetMapping("/increase/{id}")
    public String increaseQuantity(@PathVariable Integer id,
                                   @ModelAttribute("cart") List<CartItem> cart) {

        for (CartItem item : cart) {
            if (item.getProduct().getId().equals(id)) {
                item.setQuantity(item.getQuantity() + 1);
                break;
            }
        }
        return "redirect:/cart";
    }

    // ===== DECREASE =====
    @GetMapping("/decrease/{id}")
    public String decreaseQuantity(@PathVariable Integer id,
                                   @ModelAttribute("cart") List<CartItem> cart) {

        Iterator<CartItem> iterator = cart.iterator();
        while (iterator.hasNext()) {
            CartItem item = iterator.next();
            if (item.getProduct().getId().equals(id)) {
                if (item.getQuantity() > 1) {
                    item.setQuantity(item.getQuantity() - 1);
                } else {
                    iterator.remove();
                }
                break;
            }
        }
        return "redirect:/cart";
    }


}
