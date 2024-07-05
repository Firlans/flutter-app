-- UPDATE Semua Kolom di Tabel mahasiswa
UPDATE mahasiswa
SET 
    id_ta = (SELECT id FROM tahun_ajaran WHERE periode = 2024),
    nim = '211011401086',
    nama_lengkap = 'Updated Name',
    nama_ortu = 'Updated Ortu',
    telp = '081234567891',
    foto = NULL,
    status = 'TIDAK AKTIF'
WHERE 
    id_ta = (SELECT id FROM tahun_ajaran WHERE periode = 2023);


-- UPDATE Semua Kolom di Tabel komponen
UPDATE komponen
SET 
    kode_komponen = 'C02',
    nama_komponen = 'Updated Komponen',
    id_ta = (SELECT id FROM tahun_ajaran WHERE periode = 2024),
    biaya = 750000,
    kode_kelas = 102,
    tgl_dibuat = CURRENT_TIMESTAMP
WHERE 
    id_ta = (SELECT id FROM tahun_ajaran WHERE periode = 2023);


-- UPDATE Semua Kolom di Tabel pembayaran
UPDATE pembayaran
SET 
    id_ta = (SELECT id FROM tahun_ajaran WHERE periode = 2024),
    id_mahasiswa = (SELECT id FROM mahasiswa WHERE nim = '211011401086'),
    tgl_pembayaran = '2023-09-01',
    jumlah_bayar = 2000000,
    metode_bayar = 'Updated Method'
WHERE 
    id_mahasiswa = (SELECT id FROM mahasiswa WHERE nim = '211011401085');

-- UPDATE Semua Kolom di Tabel transaksi
UPDATE transaksi
SET 
    kode_transaksi = 'T002',
    id_ta = (SELECT id FROM tahun_ajaran WHERE periode = 2024),
    id_mahasiswa = (SELECT id FROM mahasiswa WHERE nim = '211011401086'),
    id_pembayaran = (SELECT id FROM pembayaran WHERE id_mahasiswa = (SELECT id FROM mahasiswa WHERE nim = '211011401086')),
    tgl_pembayaran = '2023-09-01',
    status = 'pending'
WHERE 
    id_pembayaran = (SELECT id FROM pembayaran WHERE id_mahasiswa = (SELECT id FROM mahasiswa WHERE nim = '211011401085'));

-- UPDATE Semua Kolom di Tabel tagihan_spp
UPDATE tagihan_spp
SET 
    id_transaksi = (SELECT id FROM transaksi WHERE kode_transaksi = 'T002'),
    id_mahasiswa = (SELECT id FROM mahasiswa WHERE nim = '211011401086'),
    id_ta = (SELECT id FROM tahun_ajaran WHERE periode = 2024),
    bulan = 'September',
    jumlah_bayar = 1000000,
    tgl_bayar = '2023-09-01',
    status = TRUE
WHERE 
    id_mahasiswa = (SELECT id FROM mahasiswa WHERE nim = '211011401085') 
    AND id_ta = (SELECT id FROM tahun_ajaran WHERE periode = 2023);

-- UPDATE Semua Kolom di Tabel tagihan_lain
UPDATE tagihan_lain
SET 
    id_komponen = (SELECT id FROM komponen WHERE kode_komponen = 'C02'),
    id_transaksi = (SELECT id FROM transaksi WHERE kode_transaksi = 'T002'),
    id_siswa = (SELECT id FROM mahasiswa WHERE nim = '211011401086'),
    id_ta = (SELECT id FROM tahun_ajaran WHERE periode = 2024),
    tgl_bayar = '2023-09-01',
    status = FALSE
WHERE 
    id_siswa = (SELECT id FROM mahasiswa WHERE nim = '211011401085') 
    AND id_komponen = (SELECT id FROM komponen WHERE kode_komponen = 'C01')
    AND id_ta = (SELECT id FROM tahun_ajaran WHERE periode = 2023);

-- UPDATE Semua Kolom di Tabel tahun_ajaran
UPDATE tahun_ajaran
SET 
    periode = 2024,
    tgl_mulai = '2023-03-01',
    tgl_akhir = '2024-08-01',
    kurikulum = 'Updated Kurikulum'
WHERE 
    periode = 2023;