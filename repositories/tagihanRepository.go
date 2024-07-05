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
	query := `SELECT 
    tagihan_spp.bulan,
    tagihan_spp.jumlah_bayar,
    transaksi.status,
    tagihan_spp.tgl_bayar
FROM 
    tagihan_spp
JOIN 
    transaksi ON tagihan_spp.id_transaksi = transaksi.id
JOIN 
    tahun_ajaran ON tagihan_spp.id_ta = tahun_ajaran.id
WHERE 
    tahun_ajaran.periode = '2023/2024';`

	if err := repository.DB.Raw(query).Scan(&Tagihans).Error; err != nil {
		return nil, err
	}
	return Tagihans, nil
}

func (r *TagihanRepository) GetProfilesID(id int) ([]models.Tagihan, error) {
	var Tagihans []models.Tagihan
	query := fmt.Sprintf(`SELECT 
    tagihan_spp.bulan,
    tagihan_spp.jumlah_bayar,
    transaksi.status,
    tagihan_spp.tgl_bayar
FROM 
    tagihan_spp
JOIN 
    transaksi ON tagihan_spp.id_transaksi = transaksi.id
JOIN 
    tahun_ajaran ON tagihan_spp.id_ta = tahun_ajaran.id
WHERE 
    tahun_ajaran.periode = %d;`, id)

	err := r.DB.Raw(query).Scan(&Tagihans).Error
	return Tagihans, err

	// var profiles models.Student
	// err := r.DB.First(&profiles, id).Error
	// return profiles, err
}
