-- DATABASE STRUCTURE
CREATE TABLE  tahun_ajaran (
    id INT NOT NULL AUTO_INCREMENT,
    periode YEAR,
    tgl_mulai DATE,
    tgl_akhir DATE,
    kurikulum VARCHAR(255),
    PRIMARY KEY(id)
);

CREATE TABLE  mahasiswa(
    id INT NOT NULL AUTO_INCREMENT,
    id_ta INT,
    nim CHAR(12),
    nama_lengkap VARCHAR(255),
    tanggal_lahir DATE,
    alamat VARCHAR(255),
    nama_ortu VARCHAR(255),
    telp CHAR(15),
    foto VARCHAR(255),
    status ENUM("AKTIF", "TIDAK AKTIF"),
    PRIMARY KEY(id),
    CONSTRAINT FK_MAHASISWA_KE_TAHUN_AJARAN FOREIGN KEY(id_ta) REFERENCES tahun_ajaran(id)
);

CREATE TABLE  komponen(
    id INT NOT NULL AUTO_INCREMENT,
    kode_komponen CHAR(4),
    nama_komponen VARCHAR(255),
    id_ta INT,
    biaya INT,
    kode_kelas INT,
    tgl_dibuat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    CONSTRAINT FK_KOMPONEN_KE_TAHUN_AJARAN FOREIGN KEY(id_ta) REFERENCES tahun_ajaran(id)
);

CREATE TABLE  pembayaran(
    id INT NOT NULL AUTO_INCREMENT,
    id_ta INT,
    id_mahasiswa INT,
    tgl_pembayaran DATE,
    jumlah_bayar INT,
    metode_bayar VARCHAR(255),
    PRIMARY KEY(id),
    CONSTRAINT FK_PEMBAYARAN_KE_TAHUN_AJARAN FOREIGN KEY(id_ta) REFERENCES tahun_ajaran(id),
    CONSTRAINT FK_PEMBAYARAN_KE_MAHASISWA FOREIGN KEY(id_mahasiswa) REFERENCES mahasiswa(id)
);  

CREATE TABLE  transaksi(
    id INT NOT NULL AUTO_INCREMENT,
    kode_transaksi CHAR(6),
    id_ta INT,
    id_mahasiswa INT,
    id_pembayaran INT,
    tgl_pembayaran DATE,
    status ENUM("berhasil", "pending", "gagal"),
    PRIMARY KEY(id),
    CONSTRAINT FK_TRANSAKSI_KE_TAHUN_AJARAN FOREIGN KEY(id_ta) REFERENCES tahun_ajaran(id),
    CONSTRAINT FK_TRANSAKSI_KE_MAHASISWA FOREIGN KEY(id_mahasiswa) REFERENCES mahasiswa(id),
    CONSTRAINT FK_TRANSAKSI_KE_PEMBAYARAN FOREIGN KEY(id_pembayaran) REFERENCES pembayaran(id)
);

CREATE TABLE  tagihan_spp(
    id INT NOT NULL AUTO_INCREMENT,
    id_transaksi INT,
    id_mahasiswa INT,
    id_ta INT,
    bulan VARCHAR(255),
    jumlah_bayar FLOAT,
    tgl_bayar DATE,
    status BOOLEAN,
    PRIMARY KEY(id),
    CONSTRAINT FK_TAGIHAN_SPP_KE_TRANSAKSI FOREIGN KEY(id_transaksi) REFERENCES transaksi(id),
    CONSTRAINT FK_TAGIHAN_SPP_KE_MAHASISWA FOREIGN KEY(id_mahasiswa) REFERENCES mahasiswa(id),
    CONSTRAINT FK_TAGIHAN_SPP_KE_TAHUN_AJARAN FOREIGN KEY(id_ta) REFERENCES tahun_ajaran(id)
);

CREATE TABLE tagihan_lain(
    id INT NOT NULL AUTO_INCREMENT,
    id_komponen INT,
    id_transaksi INT,
    id_siswa INT,
    id_ta INT,
    tgl_bayar DATE,
    status BOOLEAN,
    PRIMARY KEY(id),
    CONSTRAINT FK_TAGIHAN_LAIN_KE_KOMPONEN FOREIGN KEY(id_komponen) REFERENCES komponen(id),
    CONSTRAINT FK_TAGIHAN_LAIN_KE_TRANSAKSI FOREIGN KEY(id_transaksi) REFERENCES transaksi(id),
    CONSTRAINT FK_TAGIHAN_LAIN_KE_MAHASISWA FOREIGN KEY(id_siswa) REFERENCES mahasiswa(id),
    CONSTRAINT FK_TAGIHAN_LAIN_KE_TAHUN_AJARAN FOREIGN KEY(id_ta) REFERENCES tahun_ajaran(id)
);

-- END OF DATABASE STRUCTURE

-- INSERT DATA tahun_ajaran
INSERT INTO tahun_ajaran (periode, tgl_mulai, tgl_akhir, kurikulum)
VALUES
    ('2023', '2023-02-26', '2024-07-06', 'kurikulum merdeka'),
    ('2024', '2023-02-26', '2024-07-06', 'kurikulum merdeka'),
    ('2025', '2024-08-01', '2025-07-31', 'Kurikulum 2024'),
    ('2026', '2025-08-01', '2026-07-31', 'Kurikulum 2025'),
    ('2027', '2026-08-01', '2027-07-31', 'Kurikulum 2026'),
    ('2028', '2027-08-01', '2028-07-31', 'Kurikulum 2027'),
    ('2029', '2028-08-01', '2029-07-31', 'Kurikulum 2028'),
    ('2030', '2029-08-01', '2030-07-31', 'Kurikulum 2029'),
    ('2031', '2030-08-01', '2031-07-31', 'Kurikulum 2030'),
    ('2032', '2031-08-01', '2032-07-31', 'Kurikulum 2031');

-- INSERT DATA mahasiswa
-- INSERT INTO mahasiswa
INSERT INTO mahasiswa (id_ta, nim, nama_lengkap, tanggal_lahir, alamat, nama_ortu, telp, foto, status)
VALUES
    (1, '211011401085', 'Firlan Syah', '1998-10-14', 'Rahasia', 'rahasia','081234567898', NULL, 'AKTIF'),
    (2, '211011401086', 'Aditya Pratama', '1999-05-20', 'Jl. Merdeka No. 10', 'Ibu Adinda', '081234567899', NULL, 'AKTIF'),
    (3, '211011401087', 'Budi Santoso', '1998-12-30', 'Jl. Kenanga No. 5', 'Bapak Budi', '081234567890', NULL, 'AKTIF'),
    (4, '211011401088', 'Citra Dewi', '2000-02-15', 'Jl. Anggrek No. 3', 'Ibu Citra', '081234567891', NULL, 'AKTIF'),
    (5, '211011401089', 'Desi Permata', '1999-09-05', 'Jl. Mawar No. 8', 'Bapak Desi', '081234567892', NULL, 'AKTIF'),
    (6, '211011401090', 'Eko Satrio', '2000-07-18', 'Jl. Dahlia No. 2', 'Ibu Eko', '081234567893', NULL, 'AKTIF'),
    (7, '211011401091', 'Fajar Wisnu', '1998-03-25', 'Jl. Melati No. 1', 'Bapak Fajar', '081234567894', NULL, 'AKTIF'),
    (8, '211011401092', 'Gita Purnama', '1999-11-12', 'Jl. Puspa No. 7', 'Ibu Gita', '081234567895', NULL, 'AKTIF'),
    (1, '211011401093', 'Hadi Susanto', '2000-08-28', 'Jl. Kenari No. 12', 'Bapak Hadi', '081234567896', NULL, 'AKTIF'),
    (2, '211011401094', 'Ika Putri', '1999-04-17', 'Jl. Seroja No. 15', 'Ibu Ika', '081234567897', NULL, 'AKTIF');

-- INSERT DATA komponen
INSERT INTO komponen (kode_komponen, nama_komponen, id_ta, biaya, kode_kelas)
VALUES
    ('A001', 'SPP Bulan Juli', 1, 500000, 1),
    ('A002', 'SPP Bulan Agustus', 1, 500000, 1),
    ('A003', 'SPP Bulan September', 2, 500000, 1),
    ('A004', 'SPP Bulan Oktober', 2, 500000, 1),
    ('A005', 'SPP Bulan November', 3, 500000, 1),
    ('A006', 'SPP Bulan Desember', 3, 500000, 1),
    ('A007', 'SPP Bulan Januari', 4, 500000, 1),
    ('A008', 'SPP Bulan Februari', 4, 500000, 1),
    ('A009', 'SPP Bulan Maret', 5, 500000, 1),
    ('A010', 'SPP Bulan April', 5, 500000, 1);
-- INSERT DATA pembayaran
INSERT INTO pembayaran (id_ta, id_mahasiswa, tgl_pembayaran, jumlah_bayar, metode_bayar)
VALUES
    (1, 1, '2023-07-05', 500000, 'Transfer Bank'),
    (2, 2, '2023-08-10', 500000, 'Tunai'),
    (3, 3, '2023-09-15', 500000, 'Transfer Bank'),
    (4, 4, '2024-10-20', 500000, 'Tunai'),
    (5, 5, '2025-11-25', 500000, 'Transfer Bank'),
    (6, 6, '2026-12-30', 500000, 'Tunai'),
    (7, 7, '2027-01-05', 500000, 'Transfer Bank'),
    (8, 8, '2028-02-10', 500000, 'Tunai'),
    (1, 9, '2029-03-15', 500000, 'Transfer Bank'),
    (2, 10, '2030-04-20', 500000, 'Tunai');
-- INSERT DATA transaksi
INSERT INTO transaksi (kode_transaksi, id_ta, id_mahasiswa, id_pembayaran, tgl_pembayaran, status)
VALUES
    ('TRX001', 1, 1, 1, '2023-07-05', 'berhasil'),
    ('TRX002', 2, 2, 2, '2023-08-10', 'berhasil'),
    ('TRX003', 3, 3, 3, '2023-09-15', 'berhasil'),
    ('TRX004', 4, 4, 4, '2024-10-20', 'berhasil'),
    ('TRX005', 5, 5, 5, '2025-11-25', 'berhasil'),
    ('TRX006', 6, 6, 6, '2026-12-30', 'berhasil'),
    ('TRX007', 7, 7, 7, '2027-01-05', 'berhasil'),
    ('TRX008', 8, 8, 8, '2028-02-10', 'berhasil'),
    ('TRX009', 1, 9, 9, '2029-03-15', 'berhasil'),
    ('TRX010', 2, 10, 10, '2030-04-20', 'berhasil');
-- INSERT DATA tagihan spp
INSERT INTO tagihan_spp (id_transaksi, id_mahasiswa, id_ta, bulan, jumlah_bayar, tgl_bayar, status)
VALUES
    (1, 1, 1, 'Juli', 500000, '2023-07-05', 1),
    (2, 2, 2, 'Agustus', 500000, '2023-08-10', 1),
    (3, 3, 3, 'September', 500000, '2023-09-15', 1),
    (4, 4, 4, 'Oktober', 500000, '2024-10-20', 1),
    (5, 5, 5, 'November', 500000, '2025-11-25', 1),
    (6, 6, 6, 'Desember', 500000, '2026-12-30', 1),
    (7, 7, 7, 'Januari', 500000, '2027-01-05', 1),
    (8, 8, 8, 'Februari', 500000, '2028-02-10', 1),
    (9, 9, 1, 'Maret', 500000, '2029-03-15', 1),
    (10, 10, 2, 'April', 500000, '2030-04-20', 1);
-- INSERT DATA tagihan lain
INSERT INTO tagihan_lain (id_komponen, id_transaksi, id_siswa, id_ta, tgl_bayar, status)
VALUES
    (1, 1, 1, 1, '2023-07-05', 1),
    (2, 2, 2, 2, '2023-08-10', 1),
    (3, 3, 3, 3, '2023-09-15', 1),
    (4, 4, 4, 4, '2024-10-20', 1),
    (5, 5, 5, 5, '2025-11-25', 1),
    (6, 6, 6, 6, '2026-12-30', 1),
    (7, 7, 7, 7, '2027-01-05', 1),
    (8, 8, 8, 8, '2028-02-10', 1),
    (9, 9, 9, 1, '2029-03-15', 1),
    (10, 10, 10, 2, '2030-04-20', 1);
