package com.butterflyjewel;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ButterflyJewelApplication {
    public static void main(String[] args) {
        SpringApplication.run(ButterflyJewelApplication.class, args);
        System.out.println("=================================================");
        System.out.println("✨ Butterfly Jewel Backend Started on Port 8080 ✨");
        System.out.println("REST Endpoints available at http://localhost:8080/api");
        System.out.println("=================================================");
    }
}
