package org.example.demo.controller;

import jakarta.servlet.http.HttpSession;
import org.example.demo.Model.CartItem;
import org.example.demo.entity.Order;
import org.example.demo.entity.User;
import org.example.demo.service.OrderService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;

import java.util.List;

@Controller
@RequestMapping("/checkout")
@SessionAttributes("cart")
public class CheckoutController {

    private final OrderService orderService;

    public CheckoutController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping
    public String checkoutPage(@ModelAttribute("cart") List<CartItem> cart,
                               HttpSession session,
                               Model model) {
        if (cart == null || cart.isEmpty()) return "redirect:/cart";

        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        long total = cart.stream().mapToLong(i -> i.getProduct().getPrice() * i.getQuantity()).sum();
        model.addAttribute("user", user);
        model.addAttribute("total", total);
        return "checkout";
    }

    @PostMapping("/submit")
    public String submitOrder(@ModelAttribute("cart") List<CartItem> cart,
                              @RequestParam String fullName,
                              @RequestParam String phone,
                              @RequestParam String address,
                              HttpSession session, // 👉 Thêm HttpSession để lấy user
                              SessionStatus status,
                              Model model) {

        if (cart == null || cart.isEmpty()) return "redirect:/cart";

        // 👉 LẤY USER TỪ SESSION ĐỂ TRUYỀN VÀO SERVICE
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        // 👉 TRUYỀN THÊM user VÀO ĐÂY
        Order order = orderService.createOrder(fullName, phone, address, cart, user);

        model.addAttribute("order", order);
        status.setComplete();
        return "invoice";
    }
}