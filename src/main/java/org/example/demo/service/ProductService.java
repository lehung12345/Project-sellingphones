package org.example.demo.service;

import org.example.demo.entity.Product;
import org.example.demo.repository.ProductRepository;
import org.springframework.stereotype.Service;

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

    public void save(Product product) {
        repo.save(product);
    }

    public void delete(Integer id) {
        repo.deleteById(id);
    }
}
