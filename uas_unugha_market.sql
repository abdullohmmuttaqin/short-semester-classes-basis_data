-- ==========================================================
-- ABDULLAH MUHAMMAD MUTTAQIM
-- INFORMATIKA 8 B 
-- SEMESTER PENDEK BASIS DATA
-- TRI ANGGORO, M.Kom.
-- ==========================================================
-- UJIAN AKHIR SEMESTER (UAS) BASIS DATA
-- STUDI KASUS: UNUGHA Market System
-- FILE: uas_unugha_market.sql
-- ==========================================================

-- ----------------------------------------------------------
-- 1. PERSIAPAN BASIS DATA (DEFENSIVE SETUP)
-- ----------------------------------------------------------
DROP DATABASE IF EXISTS unugha_market_db;
CREATE DATABASE unugha_market_db;
USE unugha_market_db;

-- ----------------------------------------------------------
-- 2. MEMBUAT STRUKTUR TABEL (DDL)
-- ----------------------------------------------------------

-- Tabel Kategori
CREATE TABLE kategori (
    id_kategori INT PRIMARY KEY AUTO_INCREMENT,
    nama_kategori VARCHAR(50) NOT NULL
);

-- Tabel Pelanggan
CREATE TABLE pelanggan (
    id_pelanggan INT PRIMARY KEY AUTO_INCREMENT,
    nama_lengkap VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    no_telepon VARCHAR(15)
);

-- Tabel Produk (Relasi ke Kategori)
CREATE TABLE produk (
    id_produk INT PRIMARY KEY AUTO_INCREMENT,
    id_kategori INT,
    nama_produk VARCHAR(100) NOT NULL,
    harga DECIMAL(12, 2) NOT NULL,
    stok INT DEFAULT 0,
    FOREIGN KEY (id_kategori) REFERENCES kategori(id_kategori) ON DELETE SET NULL
);

-- Tabel Transaksi (Relasi ke Pelanggan)
CREATE TABLE transaksi (
    id_transaksi INT PRIMARY KEY AUTO_INCREMENT,
    id_pelanggan INT,
    tanggal_transaksi DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_bayar DECIMAL(12, 2) DEFAULT 0,
    FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan) ON DELETE CASCADE
);

-- Tabel Detail Transaksi (Jembatan Transaksi & Produk)
CREATE TABLE detail_transaksi (
    id_detail INT PRIMARY KEY AUTO_INCREMENT,
    id_transaksi INT,
    id_produk INT,
    jumlah INT NOT NULL,
    subtotal DECIMAL(12, 2) NOT NULL,
    FOREIGN KEY (id_transaksi) REFERENCES transaksi(id_transaksi) ON DELETE CASCADE,
    FOREIGN KEY (id_produk) REFERENCES produk(id_produk) ON DELETE CASCADE
);

-- ----------------------------------------------------------
-- 3. MENGISI DATA AWAL / SEEDING DATA (DML - INSERT)
-- ----------------------------------------------------------

-- Seed Data Kategori
INSERT INTO kategori (nama_kategori) VALUES 
('Elektronik'),
('Pakaian'),
('Makanan & Minuman');

-- Seed Data Pelanggan
INSERT INTO pelanggan (nama_lengkap, email, no_telepon) VALUES 
('Abdullah Muttaqim', 'abdullah@unugha.ac.id', '081234567890'),
('Siti Rahmawati', 'siti.rahma@gmail.com', '085712345678'),
('Budi Pratama', 'budi.p@yahoo.com', '089987654321');

-- Seed Data Produk
INSERT INTO produk (id_kategori, nama_produk, harga, stok) VALUES 
(1, 'Laptop Asus Vivobook', 8500000.00, 10),
(1, 'Mouse Wireless Logitech', 150000.00, 25),
(2, 'Kaos Polos Cotton Combed', 75000.00, 50),
(3, 'Kopi Susu Gula Aren', 18000.00, 100);

-- Seed Data Transaksi
INSERT INTO transaksi (id_pelanggan, tanggal_transaksi, total_bayar) VALUES 
(1, '2026-08-01 10:30:00', 8650000.00),
(2, '2026-08-02 14:15:00', 150000.00),
(1, '2026-08-05 16:45:00', 36000.00);

-- Seed Data Detail Transaksi
INSERT INTO detail_transaksi (id_transaksi, id_produk, jumlah, subtotal) VALUES 
(1, 1, 1, 8500000.00),
(1, 2, 1, 150000.00),
(2, 3, 2, 150000.00),
(3, 4, 2, 36000.00);

-- ----------------------------------------------------------
-- 4. ADVANCED SELECTION & BUSINESS INTELLIGENCE (UAS QUERIES)
-- ----------------------------------------------------------

-- Kueri 1: Menampilkan seluruh transaksi lengkap dengan Nama Pelanggan dan Total Bayar
SELECT 
    t.id_transaksi,
    p.nama_lengkap AS nama_pelanggan,
    t.tanggal_transaksi,
    t.total_bayar
FROM transaksi t
INNER JOIN pelanggan p ON t.id_pelanggan = p.id_pelanggan
ORDER BY t.tanggal_transaksi DESC;

-- Kueri 2: Rincian item per transaksi (Multi-Table JOIN: 4 Tabel)
SELECT 
    t.id_transaksi,
    p.nama_lengkap AS pelanggan,
    pr.nama_produk,
    k.nama_kategori,
    dt.jumlah,
    dt.subtotal
FROM detail_transaksi dt
INNER JOIN transaksi t ON dt.id_transaksi = t.id_transaksi
INNER JOIN pelanggan p ON t.id_pelanggan = p.id_pelanggan
INNER JOIN produk pr ON dt.id_produk = pr.id_produk
LEFT JOIN kategori k ON pr.id_kategori = k.id_kategori;

-- Kueri 3: Laporan Rekapitulasi Total Belanja per Pelanggan (Aggregation & GROUP BY)
SELECT 
    p.nama_lengkap AS pelanggan,
    COUNT(t.id_transaksi) AS jumlah_transaksi,
    SUM(t.total_bayar) AS total_pengeluaran
FROM pelanggan p
LEFT JOIN transaksi t ON p.id_pelanggan = t.id_pelanggan
GROUP BY p.id_pelanggan, p.nama_lengkap
HAVING total_pengeluaran > 0
ORDER BY total_pengeluaran DESC;