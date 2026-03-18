//package org.example.demo.service;
//
//import org.example.demo.Model.CartItem;
//import org.example.demo.entity.Order;
//import org.example.demo.entity.OrderItem;
//import org.example.demo.entity.User;
//import org.example.demo.repository.OrderRepository;
//import org.springframework.stereotype.Service;
//import org.springframework.transaction.annotation.Transactional;
//
//import java.sql.Timestamp;
//import java.util.ArrayList;
//import java.util.List;
//
//@Service
//public class OrderService {
//
//    private final OrderRepository orderRepo;
//
//    public OrderService(OrderRepository orderRepo) {
//        this.orderRepo = orderRepo;
//    }
//
//    // 🔥 TRANSACTION BẮT ĐẦU TỪ ĐÂY
//    @Transactional
//    public Order createOrder(String name, String phone, String address,
//                             List<CartItem> cart, User user) {
//
//        Order order = new Order();
//        order.setFullName(name);
//        order.setPhone(phone);
//        order.setAddress(address);
//
//        order.setEmail(user.getEmail());
//        order.setUser(user);
//
//        order.setCreatedAt(new Timestamp(System.currentTimeMillis()));
//
//        List<OrderItem> items = new ArrayList<>();
//        long total = 0;
//
//        for (CartItem c : cart) {
//
//            OrderItem oi = new OrderItem();
//            oi.setOrder(order);
//            oi.setProduct(c.getProduct());
//            oi.setProductName(c.getProduct().getName());
//            oi.setPrice(c.getProduct().getPrice());
//            oi.setQuantity(c.getQuantity());
//
//            total += oi.getPrice() * oi.getQuantity();
//
//            items.add(oi);
//        }
//
//        order.setTotal(total);
//        order.setItems(items);
//
//        // lưu Order + OrderItem cùng lúc
//        return orderRepo.save(order);
//    }
//
//    public List<Order> findAll() {
//        return orderRepo.findAllByOrderByCreatedAtDesc();
//    }
//}


package org.example.demo.service;

import org.example.demo.Model.CartItem;
import org.example.demo.entity.Order;
import org.example.demo.entity.OrderItem;
import org.example.demo.entity.Product;
import org.example.demo.entity.User;
import org.example.demo.repository.OrderRepository;
import org.example.demo.repository.ProductRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@Service
public class OrderService {

    private final OrderRepository orderRepo;
    private final ProductRepository productRepo;

    public OrderService(OrderRepository orderRepo, ProductRepository productRepo) {
        this.orderRepo = orderRepo;
        this.productRepo = productRepo;
    }

    @Transactional
    public Order createOrder(String name, String phone, String address,
                             List<CartItem> cart, User user) {

        Order order = new Order();
        order.setFullName(name);
        order.setPhone(phone);
        order.setAddress(address);
        order.setEmail(user.getEmail());
        order.setUser(user);
        order.setCreatedAt(new Timestamp(System.currentTimeMillis()));

        List<OrderItem> items = new ArrayList<>();
        long total = 0;

        for (CartItem c : cart) {

            // 🔥 LẤY LẠI PRODUCT TỪ DB (QUAN TRỌNG NHẤT)
            Product product = productRepo.findById(c.getProduct().getId())
                    .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm"));

            // CHECK STOCK
            if (product.getQuantity() < c.getQuantity()) {
                throw new RuntimeException("Sản phẩm không đủ số lượng");
            }

            // TRỪ KHO
            product.setQuantity(product.getQuantity() - c.getQuantity());

            // SAVE LẠI DB (BẮT BUỘC)
            productRepo.save(product);

            OrderItem oi = new OrderItem();
            oi.setOrder(order);
            oi.setProduct(product);
            oi.setProductName(product.getName());
            oi.setPrice(product.getPrice());
            oi.setQuantity(c.getQuantity());

            total += oi.getPrice() * oi.getQuantity();
            items.add(oi);
        }

        order.setTotal(total);
        order.setItems(items);

        return orderRepo.save(order);
    }

    public List<Order> findAll() {
        return orderRepo.findAllByOrderByCreatedAtDesc();
    }
}