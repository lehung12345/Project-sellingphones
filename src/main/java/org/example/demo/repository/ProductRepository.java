package org.example.demo.repository;

import jakarta.transaction.Transactional;
import org.example.demo.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface ProductRepository extends JpaRepository<Product, Integer> {
    // ✅ Trừ kho trực tiếp (optional)
    @Modifying
    @Transactional
    @Query("UPDATE Product p SET p.quantity = p.quantity - :qty WHERE p.id = :id AND p.quantity >= :qty")
    int decreaseStock(Integer id, int qty);
}
