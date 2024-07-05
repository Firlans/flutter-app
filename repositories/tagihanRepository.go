package repositories

import (
	"fmt"
	models "tugasuas/models/tagihan"

	"gorm.io/gorm"
)

type TagihanRepository struct {
	DB *gorm.DB
}

func NewTagihanRepository(db *gorm.DB) *TagihanRepository {
	return &TagihanRepository{DB: db}
}

func (repository *TagihanRepository) GetProfiles() ([]models.Tagihan, error) {
	var Tagihans []models.Tagihan
	query := `SELECT tagihan_spp.bulan, tagihan_spp.jumlah_bayar, transaksi.status, transaksi.tgl_pembayaran 
	FROM tagihan_spp 
	LEFT JOIN transaksi 
	ON tagihan_spp.id_transaksi = transaksi.id 
	WHERE tagihan_spp.id_transaksi = 1;`

	if err := repository.DB.Raw(query).Scan(&Tagihans).Error; err != nil {
		return nil, err
	}
	return Tagihans, nil
}

func (r *TagihanRepository) GetProfilesID(id int) ([]models.Tagihan, error) {
	var Tagihans []models.Tagihan
	query := fmt.Sprintf(`SELECT 
                mahasiswa.id, mahasiswa.nim, mahasiswa.nama_lengkap, 
                mahasiswa.nama_ortu, mahasiswa.telp, mahasiswa.status, 
                tahun_ajaran.periode, tahun_ajaran.tgl_mulai, tahun_ajaran.tgl_akhir, 
                tahun_ajaran.kurikulum
              FROM mahasiswa
              LEFT JOIN tahun_ajaran ON mahasiswa.id_ta = tahun_ajaran.id
              WHERE mahasiswa.id_ta = %d`, id)

	err := r.DB.Raw(query).Scan(&Tagihans).Error
	return Tagihans, err

	// var profiles models.Student
	// err := r.DB.First(&profiles, id).Error
	// return profiles, err
}
