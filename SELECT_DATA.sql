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