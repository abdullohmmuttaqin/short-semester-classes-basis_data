-- Bagian 1: Membuat Basis Data toko online "Maju dan Berkah"
CREATE DATABASE maju_jaya_db;

-- Mengaktifkan basis data agar siap digunakan
USE maju_jaya_db;

-- Membuat tabel pelanggan
CREATE TABLE pelanggan (
    id_pelanggan INT PRIMARY KEY AUTO_INCREMENT,
    nama_lengkap VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    tanggal_daftar DATE DEFAULT CURRENT_DATE
);

-- Membuat tabel produk
CREATE TABLE produk (
    id_produk INT PRIMARY KEY AUTO_INCREMENT,
    nama_produk VARCHAR(100) NOT NULL,
    harga DECIMAL(10, 2) NOT NULL,
    stok INT DEFAULT 0
);