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
    nama_ortu VARCHAR(255),
    telp CHAR(15),
    foto BLOB,
    status ENUM("AKTIF", "TIDAK AKTIF"),
    PRIMARY KEY(id),
    CONSTRAINT FK_MAHASISWA_KE_TAHUN_AJARAN FOREIGN KEY(id_ta) REFERENCES tahun_ajaran(id)
);

CREATE TABLE  komponen(
    id INT NOT NULL AUTO_INCREMENT,
    kode_komponen CHAR,
    nama_komponen CHAR,
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
    kode_transaksi CHAR,
    id_ta INT,
    id_mahasiswa INT,
    id_pembayaran INT,
    tgl_pembayaran DATE,
    status ENUM("berhasil", "pending", "gagal"),
    PRIMARY KEY(id),
    CONSTRAINT FK_TRANSAKSI_KE_TAHUN_AJARAN FOREIGN KEY(id_ta) REFERENCES tahun_ajaran(id),
    CONSTRAINT FK_TRANSAKSI_KE_MAHASISWA FOREIGN KEY(id_mahasiswa) REFERENCES mahasiswa(id),
    CONSTRAINT FK_TRANSAKSI_KE_PEMBAYARAN FOREIGN KEY(id_pembayaran) REFERENCES pembayaran(id)
)

CREATE TABLE  tagihan_spp(
    id INT NOT NULL AUTO_INCREMENT,
    id_transaksi INT,
    id_mahasiswa INT,
    id_ta INT,
    bulan CHAR,
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
VALUES(2023/2024, "2023-2-26", "2024-7-6", "kurikulum merdeka");

-- INSERT DATA mahasiswa
INSERT INTO mahasiswa (nim, id_ta, nama_lengkap, nama_ortu, telp, foto, status)
VALUES(211011401085, 1,"Firlan Syah", "Rahasia", "081234567898", NULL, "AKTIF");

-- INSERT DATA komponen
INSERT INTO komponen(kode_komponen, nama_komponen, id_ta, biaya, kode_kelas)
VALUES();
-- INSERT DATA transaksi
INSERT INTO transaksi (kode_transaksi, id_ta, id_mahasiswa, id_pembayaran, tgl_pembayaran, status)
VALUES ();
-- INSERT DATA tagihan spp
INSERT INTO tagihan_spp(id_transaksi, id_mahasiswa, id_ta, bulan, jumlah_bayar, tgl_bayar, status)
VALUES ();
-- INSERT DATA tagihan lain
INSERT INTO tagihan_lain(id_komponen, id_transaksi, id_siswa, id_ta, tgl_bayar, status)
VALUES ();
-- INSERT DATA
INSERT INTO pembayaran(id_ta, id_mahasiswa, tgl_pembayaran, jumlah_bayar, metode_bayar)
VALUES ();


-- SELECT DATA
SELECT 
    mahasiswa.id,
    mahasiswa.nim,
    mahasiswa.nama_lengkap,
    mahasiswa.nama_ortu,
    mahasiswa.telp,
    mahasiswa.status,
    tahun_ajaran.periode,
    tahun_ajaran.tgl_mulai,
    tahun_ajaran.tgl_akhir,
    tahun_ajaran.kurikulum
FROM 
    mahasiswa
LEFT JOIN 
    tahun_ajaran ON mahasiswa.id_ta = tahun_ajaran.id
WHERE
    mahasiswa.id_ta = 1;

-- SELECT all DATA from komponen
SELECT * FROM komponen;

-- SELECT all DATA from pembayaran
SELECT * FROM pembayaran;

-- SELECT all DATA from transaksi
SELECT * FROM transaksi;

-- SELECT all DATA from tagihan_spp
SELECT * FROM tagihan_spp;

-- SELECT all DATA from tagihan_lain
SELECT * FROM tagihan_lain;

-- SELECT DATA mahasiswa dan tahun ajaran
SELECT
    mahasiswa.id,
    mahasiswa.nim,
    mahasiswa.nama_lengkap,
    mahasiswa.nama_ortu,
    mahasiswa.telp,
    mahasiswa.status,
    tahun_ajaran.periode,
    tahun_ajaran.tgl_mulai,
    tahun_ajaran.tgl_akhir,
    tahun_ajaran.kurikulum
FROM
    mahasiswa
LEFT JOIN
    tahun_ajaran ON mahasiswa.id_ta = tahun_ajaran.id
WHERE
    mahasiswa.id_ta = 1;

-- SELECT Data Mahasiswa dan Pembayaran
SELECT
    mahasiswa.id,
    mahasiswa.nim,
    mahasiswa.nama_lengkap,
    pembayaran.id AS pembayaran_id,
    pembayaran.tgl_pembayaran,
    pembayaran.jumlah_bayar,
    pembayaran.metode_bayar
FROM
    mahasiswa
INNER JOIN
    pembayaran ON mahasiswa.id = pembayaran.id_mahasiswa
WHERE
    mahasiswa.id = 1;

-- SELECT Data Mahasiswa, Pembayaran, dan Transaksi
SELECT
    mahasiswa.id,
    mahasiswa.nim,
    mahasiswa.nama_lengkap,
    pembayaran.id AS pembayaran_id,
    pembayaran.tgl_pembayaran,
    pembayaran.jumlah_bayar,
    transaksi.kode_transaksi,
    transaksi.tgl_pembayaran AS transaksi_tgl_pembayaran,
    transaksi.status AS transaksi_status
FROM
    mahasiswa
INNER JOIN
    pembayaran ON mahasiswa.id = pembayaran.id_mahasiswa
INNER JOIN
    transaksi ON pembayaran.id = transaksi.id_pembayaran
WHERE
    mahasiswa.id = 1;

-- SELECT Data Mahasiswa dan Tagihan SPP
SELECT
    mahasiswa.id,
    mahasiswa.nim,
    mahasiswa.nama_lengkap,
    tagihan_spp.bulan,
    tagihan_spp.jumlah_bayar,
    tagihan_spp.tgl_bayar,
    tagihan_spp.status AS status_tagihan
FROM
    mahasiswa
INNER JOIN
    tagihan_spp ON mahasiswa.id = tagihan_spp.id_mahasiswa
WHERE
    mahasiswa.id = 1;

-- SELECT Data Mahasiswa dan Tagihan Lain
SELECT
    mahasiswa.id,
    mahasiswa.nim,
    mahasiswa.nama_lengkap,
    komponen.nama_komponen,
    tagihan_lain.tgl_bayar,
    tagihan_lain.status AS status_tagihan
FROM
    mahasiswa
INNER JOIN
    tagihan_lain ON mahasiswa.id = tagihan_lain.id_siswa
INNER JOIN
    komponen ON tagihan_lain.id_komponen = komponen.id
WHERE
    mahasiswa.id = 1;

-- SELECT Data Komponen dan Tahun Ajaran
SELECT
    komponen.id,
    komponen.kode_komponen,
    komponen.nama_komponen,
    komponen.biaya,
    komponen.kode_kelas,
    tahun_ajaran.periode,
    tahun_ajaran.tgl_mulai,
    tahun_ajaran.tgl_akhir,
    tahun_ajaran.kurikulum
FROM
    komponen
LEFT JOIN
    tahun_ajaran ON komponen.id_ta = tahun_ajaran.id
WHERE
    komponen.id_ta = 1;

-- SELECT Data Pembayaran dan Tahun Ajaran
SELECT
    pembayaran.id,
    pembayaran.tgl_pembayaran,
    pembayaran.jumlah_bayar,
    pembayaran.metode_bayar,
    tahun_ajaran.periode,
    tahun_ajaran.tgl_mulai,
    tahun_ajaran.tgl_akhir,
    tahun_ajaran.kurikulum
FROM
    pembayaran
LEFT JOIN
    tahun_ajaran ON pembayaran.id_ta = tahun_ajaran.id
WHERE
    pembayaran.id_ta = 1;

-- SELECT Data Transaksi, Pembayaran, Mahasiswa, dan Tahun Ajaran
SELECT
    transaksi.id,
    transaksi.kode_transaksi,
    transaksi.tgl_pembayaran AS transaksi_tgl_pembayaran,
    transaksi.status AS transaksi_status,
    pembayaran.tgl_pembayaran AS pembayaran_tgl_pembayaran,
    pembayaran.jumlah_bayar,
    pembayaran.metode_bayar,
    mahasiswa.nim,
    mahasiswa.nama_lengkap,
    tahun_ajaran.periode,
    tahun_ajaran.tgl_mulai,
    tahun_ajaran.tgl_akhir,
    tahun_ajaran.kurikulum
FROM
    transaksi
INNER JOIN
    pembayaran ON transaksi.id_pembayaran = pembayaran.id
INNER JOIN
    mahasiswa ON transaksi.id_mahasiswa = mahasiswa.id
INNER JOIN
    tahun_ajaran ON transaksi.id_ta = tahun_ajaran.id
WHERE
    transaksi.id_ta = 1;

-- SELECT Data Tagihan SPP, Transaksi, Mahasiswa, dan Tahun Ajaran
SELECT
    tagihan_spp.id,
    tagihan_spp.bulan,
    tagihan_spp.jumlah_bayar,
    tagihan_spp.tgl_bayar,
    tagihan_spp.status AS status_tagihan,
    transaksi.kode_transaksi,
    transaksi.tgl_pembayaran AS transaksi_tgl_pembayaran,
    transaksi.status AS transaksi_status,
    mahasiswa.nim,
    mahasiswa.nama_lengkap,
    tahun_ajaran.periode,
    tahun_ajaran.tgl_mulai,
    tahun_ajaran.tgl_akhir,
    tahun_ajaran.kurikulum
FROM
    tagihan_spp
INNER JOIN
    transaksi ON tagihan_spp.id_transaksi = transaksi.id
INNER JOIN
    mahasiswa ON tagihan_spp.id_mahasiswa = mahasiswa.id
INNER JOIN
    tahun_ajaran ON tagihan_spp.id_ta = tahun_ajaran.id
WHERE
    tagihan_spp.id_ta = 1;

-- SELECT Data Tagihan Lain, Komponen, Transaksi, Mahasiswa, dan Tahun Ajaran
SELECT
    tagihan_lain.id,
    komponen.nama_komponen,
    tagihan_lain.tgl_bayar,
    tagihan_lain.status AS status_tagihan,
    transaksi.kode_transaksi,
    transaksi.tgl_pembayaran AS transaksi_tgl_pembayaran,
    transaksi.status AS transaksi_status,
    mahasiswa.nim,
    mahasiswa.nama_lengkap,
    tahun_ajaran.periode,
    tahun_ajaran.tgl_mulai,
    tahun_ajaran.tgl_akhir,
    tahun_ajaran.kurikulum
FROM
    tagihan_lain
INNER JOIN
    komponen ON tagihan_lain.id_komponen = komponen.id
INNER JOIN
    transaksi ON tagihan_lain.id_transaksi = transaksi.id
INNER JOIN
    mahasiswa ON tagihan_lain.id_siswa = mahasiswa.id
INNER JOIN
    tahun_ajaran ON tagihan_lain.id_ta = tahun_ajaran.id
WHERE
    tagihan_lain.id_ta = 1;