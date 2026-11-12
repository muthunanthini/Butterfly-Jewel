
-- =======================================================
-- Butterfly Jewel - MySQL Database Setup Script
-- Database: butterfly_jewel_db
-- Secure Database Structure and Product Seed Data
-- =======================================================

CREATE DATABASE IF NOT EXISTS butterfly_jewel_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE butterfly_jewel_db;


-- =======================================================
-- 1. USERS TABLE
-- =======================================================

CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'CUSTOMER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;


-- =======================================================
-- 2. PRODUCTS TABLE
-- =======================================================

CREATE TABLE IF NOT EXISTS products (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category ENUM('CLASSICAL', 'WESTERN') NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    offer_price DECIMAL(10,2) NOT NULL,
    discount_percent INT DEFAULT 0,
    rating DECIMAL(3,1) DEFAULT 4.5,
    review_count INT DEFAULT 0,
    description TEXT,
    material VARCHAR(100) DEFAULT 'Premium Gold-Plated Brass',
    size VARCHAR(100) DEFAULT 'Adjustable',
    image_url VARCHAR(500),
    page_url VARCHAR(100),
    stock INT DEFAULT 20,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;


-- =======================================================
-- 3. ORDERS TABLE
-- =======================================================

CREATE TABLE IF NOT EXISTS orders (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    product_id BIGINT,
    product_name VARCHAR(255) NOT NULL,
    quantity INT DEFAULT 1,
    unit_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    customer_phone VARCHAR(20),
    shipping_address TEXT NOT NULL,
    status VARCHAR(50) DEFAULT 'CONFIRMED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
        REFERENCES users(id) ON DELETE CASCADE,

    FOREIGN KEY (product_id)
        REFERENCES products(id) ON DELETE SET NULL
) ENGINE=InnoDB;


-- =======================================================
-- 4. FAVOURITES TABLE
-- =======================================================

CREATE TABLE IF NOT EXISTS favourites (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    UNIQUE KEY uq_user_product (user_id, product_id),

    FOREIGN KEY (user_id)
        REFERENCES users(id) ON DELETE CASCADE,

    FOREIGN KEY (product_id)
        REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB;


-- =======================================================
-- 5. REVIEWS TABLE
-- =======================================================

CREATE TABLE IF NOT EXISTS reviews (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    user_name VARCHAR(100) NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
        REFERENCES users(id) ON DELETE CASCADE,

    FOREIGN KEY (product_id)
        REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB;


-- =======================================================
-- PRODUCT SEED DATA
-- 7 Classical + 6 Western Products
-- No personal user information included
-- =======================================================

INSERT INTO products (
    id, name, category, price, offer_price,
    discount_percent, rating, review_count,
    description, material, size,
    image_url, page_url, stock
)
VALUES

-- -------------------------------------------------------
-- CLASSICAL NECKLACES
-- -------------------------------------------------------

(
    1,
    'Golden Temple Necklace',
    'CLASSICAL',
    1000.00, 800.00, 20, 4.5, 1200,
    'A beautiful handcrafted royal gold necklace with an elegant finish, inspired by traditional temple jewelry. Perfect for weddings and festivities.',
    'Premium Gold-Plated Brass',
    'Adjustable (16 - 18 inches)',
    'https://m.media-amazon.com/images/I/71GQ0Vhv53L._SY695_.jpg',
    'product.html',
    15
),

(
    2,
    'Princess Chic Jewellery Sets',
    'CLASSICAL',
    500.00, 300.00, 20, 4.3, 1000,
    'Elegant chic jewelry set with delicate golden contours, designed for royal charm and cultural elegance.',
    'Premium Gold-Plated Brass',
    'Adjustable (15 - 18 inches)',
    'https://m.media-amazon.com/images/I/71GQ0Vhv53L._SY695_.jpg',
    'product2.html',
    25
),

(
    3,
    'Ratnavali Jewels Brass Gold-plated Red Jewellery Set',
    'CLASSICAL',
    1000.00, 600.00, 40, 4.5, 1000,
    'Traditional red ruby accent necklace set with premium brass gold plating, handcrafted to perfection.',
    'Gold-Plated Brass & Ruby Accents',
    'Adjustable (14 - 18 inches)',
    'https://m.media-amazon.com/images/I/71GQ0Vhv53L._SY695_.jpg',
    'product3.html',
    10
),

(
    4,
    'Brado Jewellery Rose Gold-Plated Artificial Stone Studded Necklace',
    'CLASSICAL',
    1000.00, 300.00, 70, 4.1, 1800,
    'Dazzling rose gold finish studded with sparkling Austrian stones, offering great grandeur for special occasions.',
    'Rose Gold-Plated Brass',
    'Adjustable (16 - 19 inches)',
    'https://m.media-amazon.com/images/I/71GQ0Vhv53L._SY695_.jpg',
    'product4.html',
    18
),

(
    5,
    'Zeneme Rose Gold-Plated CZ & AD Stone-Studded Jewellery Set',
    'CLASSICAL',
    1500.00, 750.00, 50, 4.8, 2500,
    'Exquisite cubic zirconia stones set in radiant rose gold plating, delivering a luxurious modern-classical aesthetic.',
    'Rose Gold & American Diamond CZ',
    'Adjustable (16 - 18 inches)',
    'https://m.media-amazon.com/images/I/71GQ0Vhv53L._SY695_.jpg',
    'product1.html',
    12
),

(
    6,
    'Shining Diva Fashion Fancy Pearl Choker Traditional Temple Necklace',
    'CLASSICAL',
    1000.00, 800.00, 20, 4.6, 2000,
    'Fancy layered pearl choker necklace with intricate temple motifs, celebrated by brides and festive connoisseurs.',
    'Gold-Plated Brass & Fresh Pearls',
    'Adjustable (16 - 18 inches)',
    'https://m.media-amazon.com/images/I/71GQ0Vhv53L._SY695_.jpg',
    'product5.html',
    20
),

(
    7,
    'Sasitrends Gold Plated Traditional Neck Choker with Earrings',
    'CLASSICAL',
    1000.00, 500.00, 50, 4.1, 700,
    'Intricate traditional South Indian choker set complete with matching royal dangling earrings.',
    'Antique Gold-Plated Brass',
    'Adjustable (16 - 19 inches)',
    'https://m.media-amazon.com/images/I/71GQ0Vhv53L._SY695_.jpg',
    'product6.html',
    14
),


-- -------------------------------------------------------
-- WESTERN NECKLACES
-- -------------------------------------------------------

(
    8,
    'Golden Stylish Multi-Layered Butterfly Necklace',
    'WESTERN',
    400.00, 340.00, 15, 4.5, 1000,
    'Trendy layered necklace featuring delicate butterfly charms, perfect for modern casuals and party outfits.',
    'Gold-Plated Stainless Steel',
    'Adjustable (16 - 19 inches)',
    'https://m.media-amazon.com/images/I/71GQ0Vhv53L._SY695_.jpg',
    'p2.html',
    30
),

(
    9,
    'SilverGold Stylish Maple Leaf Necklace',
    'WESTERN',
    200.00, 150.00, 25, 4.2, 1500,
    'A graceful dual-tone maple leaf pendant necklace that blends minimalist simplicity with radiant beauty.',
    'Silver & Gold-Plated Alloy',
    'Adjustable (16 - 21 inches)',
    'https://m.media-amazon.com/images/I/71GQ0Vhv53L._SY695_.jpg',
    'p1.html',
    40
),

(
    10,
    'Golden Stylish Butterfly Drop Necklace',
    'WESTERN',
    400.00, 200.00, 50, 4.0, 800,
    'Minimalist dangling butterfly drop pendant on a lightweight golden chain for effortless everyday style.',
    'Premium Gold-Plated Brass',
    'Adjustable (16 - 19 inches)',
    'https://m.media-amazon.com/images/I/71GQ0Vhv53L._SY695_.jpg',
    'p3.html',
    25
),

(
    11,
    'Golden Stylish Multi-Layered Moon Necklace',
    'WESTERN',
    300.00, 210.00, 30, 4.5, 1500,
    'Celestial-inspired crescent moon multi-chain necklace crafted to bring a mystical and stylish glow.',
    'Gold-Plated Alloy',
    'Adjustable (16 - 18 inches)',
    'https://m.media-amazon.com/images/I/71GQ0Vhv53L._SY695_.jpg',
    'p4.html',
    22
),

(
    12,
    'Golden Stylish Swarovski Lifelong Bow Necklace',
    'WESTERN',
    500.00, 325.00, 35, 4.8, 2000,
    'Iconic knot bow silhouette embellished with shimmering micro-crystals, ideal for gifts and celebrations.',
    'Gold-Plated Brass & Crystal',
    'Adjustable (16 - 17 inches)',
    'https://m.media-amazon.com/images/I/71GQ0Vhv53L._SY695_.jpg',
    'p5.html',
    16
),

(
    13,
    'Golden Stylish Crystal Butterfly Pendant Necklace',
    'WESTERN',
    200.00, 110.00, 45, 3.5, 1000,
    'Subtle crystal butterfly on fine gold cable link chain, versatile for daily wear and formal layering.',
    'Gold-Plated Brass & Clear Crystal',
    'Adjustable (16 - 18 inches)',
    'https://m.media-amazon.com/images/I/71GQ0Vhv53L._SY695_.jpg',
    'p6.html',
    35
)

ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    category = VALUES(category),
    price = VALUES(price),
    offer_price = VALUES(offer_price),
    discount_percent = VALUES(discount_percent),
    rating = VALUES(rating),
    review_count = VALUES(review_count),
    description = VALUES(description),
    material = VALUES(material),
    size = VALUES(size),
    image_url = VALUES(image_url),
    page_url = VALUES(page_url),
    stock = VALUES(stock);


-- =======================================================
-- END OF DATABASE SETUP SCRIPT
-- =======================================================
