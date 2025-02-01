CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Kullanıcı ID'si, otomatik artan
    username VARCHAR(50) NOT NULL UNIQUE, -- Kullanıcı adı, benzersiz ve boş olamaz
    password VARCHAR(255) NOT NULL, -- Şifre, güvenlik için hash'lenmiş depolanmalı
    email VARCHAR(100) NOT NULL UNIQUE, -- Email adresi, benzersiz ve boş olamaz
    invite VARCHAR(50) NOT NULL, -- Kullanıcının davet kodu
    fcmToken VARCHAR(512) NOT NULL, -- Şifre, güvenlik için hash'lenmiş depolanmalı
    status ENUM('normal', 'banned') DEFAULT 'normal', -- Hesap durumu, varsayılan olarak 'normal'
    role ENUM('owner', 'moderator', 'member') DEFAULT NULL, -- Kullanıcı rolü, başlangıçta boş
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Hesap oluşturulma tarihi
);