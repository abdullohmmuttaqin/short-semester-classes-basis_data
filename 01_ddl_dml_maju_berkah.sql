-- ==========================================================
-- ABDULLAH MUHAMMAD MUTTAQIM
-- INFORMATIKA 8 B 
-- SEMESTER PENDEK BASIS DATA
-- TRI ANGGORO, M.Kom.
-- ==========================================================
-- STUDI KASUS: Toko Online "Maju dan Berkah"
-- FILE: 01_ddl_dml_maju_berkah.sql
-- BAGIAN 1: Data Definition Language (DDL)
-- ==========================================================
-- Link Github: https://github.com/abdullohmmuttaqin/short-semester-classes-basis_data

-- 1. Persiapan Basis Data
-- Menghapus database lama jika ada (untuk pengujian ulang)
DROP DATABASE IF EXISTS maju_jaya_db;

-- Membuat database baru
CREATE DATABASE maju_jaya_db;

-- Mengaktifkan database agar siap digunakan
USE maju_jaya_db;


-- 2. Membuat Tabel Utama (CREATE)
-- Tabel 1: pelanggan
CREATE TABLE pelanggan (
    id_pelanggan INT PRIMARY KEY AUTO_INCREMENT,
    nama_lengkap VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    tanggal_daftar DATE DEFAULT CURRENT_DATE
);

-- Tabel 2: produk
CREATE TABLE produk (
    id_produk INT PRIMARY KEY AUTO_INCREMENT,
    nama_produk VARCHAR(100) NOT NULL,
    harga DECIMAL(10, 2) NOT NULL,
    stok INT DEFAULT 0
);


-- 3. Memodifikasi Struktur Tabel (ALTER)
-- A. Menambahkan kolom nomor_telepon pada tabel pelanggan (posisi setelah email)
ALTER TABLE pelanggan ADD nomor_telepon VARCHAR(15) AFTER email;

-- B. Mengubah tipe data kolom stok pada tabel produk menjadi SMALLINT
ALTER TABLE produk MODIFY COLUMN stok SMALLINT DEFAULT 0;

-- C. Menghapus kolom tanggal_daftar dari tabel pelanggan
ALTER TABLE pelanggan DROP COLUMN tanggal_daftar;