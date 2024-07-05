-- DELETE Data Mahasiswa berdasarkan Tahun Ajaran
DELETE FROM mahasiswa
WHERE id_ta = (SELECT id FROM tahun_ajaran WHERE periode = 2023);

-- DELETE Data Pembayaran berdasarkan Mahasiswa
DELETE FROM pembayaran
WHERE id_mahasiswa = (SELECT id FROM mahasiswa WHERE nim = '211011401085');

-- DELETE Data Transaksi berdasarkan Pembayaran
DELETE FROM transaksi
WHERE id_pembayaran = (SELECT id FROM pembayaran WHERE id_mahasiswa = (SELECT id FROM mahasiswa WHERE nim = '211011401085'));

-- DELETE Data Tagihan SPP berdasarkan Mahasiswa dan Tahun Ajaran
DELETE FROM tagihan_spp
WHERE id_mahasiswa = (SELECT id FROM mahasiswa WHERE nim = '211011401085') 
AND id_ta = (SELECT id FROM tahun_ajaran WHERE periode = 2023);

-- DELETE Data Tagihan Lain berdasarkan Mahasiswa, Komponen, dan Tahun Ajaran
DELETE FROM tagihan_lain
WHERE id_siswa = (SELECT id FROM mahasiswa WHERE nim = '211011401085') 
AND id_komponen = (SELECT id FROM komponen WHERE nama_komponen = 'Komponen 1')
AND id_ta = (SELECT id FROM tahun_ajaran WHERE periode = 2023);

-- DELETE Data Komponen berdasarkan Tahun Ajaran
DELETE FROM komponen
WHERE id_ta = (SELECT id FROM tahun_ajaran WHERE periode = 2023);

-- DELETE Data Tahun Ajaran berdasarkan Periode
DELETE FROM tahun_ajaran
WHERE periode = 2023;

-- DELETE Data Pembayaran berdasarkan Tahun Ajaran
DELETE FROM pembayaran
WHERE id_ta = (SELECT id FROM tahun_ajaran WHERE periode = 2023);

-- DELETE Data Transaksi berdasarkan Tahun Ajaran
DELETE FROM transaksi
WHERE id_ta = (SELECT id FROM tahun_ajaran WHERE periode = 2023);