-- ==========================================================
-- LATIHAN SQL MODUL 1: DATABASE PERPUSTAKAAN
-- ==========================================================

-- Soal 1: Buat database perpustakaan
CREATE DATABASE perpustakaan;
USE perpustakaan;

-- Soal 2: Buat tabel buku dan tabel pendukung
CREATE TABLE buku (
    id_buku INT PRIMARY KEY AUTO_INCREMENT,
    judul VARCHAR(100) NOT NULL,
    pengarang VARCHAR(50),
    tahun INT
);

CREATE TABLE anggota (
    id_anggota INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(50) NOT NULL,
    alamat TEXT
);

CREATE TABLE peminjaman (
    id_pinjam INT PRIMARY KEY AUTO_INCREMENT,
    id_buku INT,
    id_anggota INT,
    tanggal_pinjam DATE,
    FOREIGN KEY (id_buku) REFERENCES buku(id_buku),
    FOREIGN KEY (id_anggota) REFERENCES anggota(id_anggota)
);

-- Soal 3: Tambahkan minimal 5 data buku
INSERT INTO buku (judul, pengarang, tahun) VALUES 
('Laskar Pelangi', 'Andrea Hirata', 2005),
('Bumi', 'Tere Liye', 2014),
('Filosofi Teras', 'Henry Manampiring', 2018),
('Atomic Habits', 'James Clear', 2018),
('Sebuah Seni untuk Bersikap Bodo Amat', 'Mark Manson', 2016);

-- Soal 4: Tampilkan semua data buku
SELECT * FROM buku;