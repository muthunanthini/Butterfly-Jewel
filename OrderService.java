package com.butterflyjewel.service;

import com.butterflyjewel.dto.OrderRequest;
import com.butterflyjewel.model.Order;
import com.butterflyjewel.model.Product;
import com.butterflyjewel.model.User;
import com.butterflyjewel.repository.OrderRepository;
import com.butterflyjewel.repository.ProductRepository;
import com.butterflyjewel.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private UserRepository userRepository;

    public Order createOrder(OrderRequest req) {
        User user = userRepository.findById(req.getUserId())
            .orElseThrow(() -> new RuntimeException("User not found with ID: " + req.getUserId()));

        Product product = null;
        BigDecimal unitPrice;
        String productName;

        if (req.getProductId() != null) {
            product = productRepository.findById(req.getProductId()).orElse(null);
        }

        if (product != null) {
            productName = product.getName();
            unitPrice = product.getOfferPrice() != null ? product.getOfferPrice() : product.getPrice();
        } else {
            productName = "Butterfly Jewel Designer Necklace";
            unitPrice = BigDecimal.valueOf(500.00);
        }

        int qty = (req.getQuantity() != null && req.getQuantity() > 0) ? req.getQuantity() : 1;
        BigDecimal totalPrice = unitPrice.multiply(BigDecimal.valueOf(qty));

        Order order = new Order();
        order.setUserId(user.getId());
        order.setProductId(product != null ? product.getId() : null);
        order.setProductName(productName);
        order.setQuantity(qty);
        order.setUnitPrice(unitPrice);
        order.setTotalPrice(totalPrice);
        order.setCustomerName((req.getCustomerName() != null && !req.getCustomerName().isEmpty()) ? req.getCustomerName() : user.getName());
        order.setCustomerPhone((req.getCustomerPhone() != null && !req.getCustomerPhone().isEmpty()) ? req.getCustomerPhone() : user.getPhone());
        order.setShippingAddress((req.getShippingAddress() != null && !req.getShippingAddress().isEmpty()) ? req.getShippingAddress() : "Standard Delivery Address");
        order.setStatus("CONFIRMED");

        return orderRepository.save(order);
    }

    public List<Order> getOrdersByUser(Long userId) {
        return orderRepository.findByUserIdOrderByCreatedAtDesc(userId);
    }

    public List<Order> getAllOrders() {
        return orderRepository.findAllByOrderByCreatedAtDesc();
    }
}
