package org.example.demo.service;

import org.example.demo.entity.Product;
import org.example.demo.repository.ProductRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ProductService {

    private final ProductRepository repo;

    public ProductService(ProductRepository repo) {
        this.repo = repo;
    }

    public List<Product> findAll() {
        return repo.findAll();
    }

    public Product findById(Integer id) {
        return repo.findById(id).orElse(null);
    }

    // ✅ SAVE: không cho quantity âm
    public void save(Product product) {
        if (product.getQuantity() < 0) {
            product.setQuantity(0);
        }
        repo.save(product);
    }

    public void delete(Integer id) {
        repo.deleteById(id);
    }

    // 🔥 QUAN TRỌNG: TRỪ KHO AN TOÀN
    @Transactional
    public boolean decreaseStock(Integer productId, int qty) {

        Product product = findById(productId);
        if (product == null) return false;

        // không đủ hàng
        if (product.getQuantity() < qty) {
            return false;
        }

        // trừ kho
        product.setQuantity(product.getQuantity() - qty);

        repo.save(product);
        return true;
    }

    // CHECK còn hàng
    public boolean isInStock(Integer productId, int qty) {
        Product product = findById(productId);
        return product != null && product.getQuantity() >= qty;
    }
}