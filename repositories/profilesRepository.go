package repositories

import (
	"fmt"
	models "tugasuas/models/profils"

	"gorm.io/gorm"
)

type StudentRepository struct {
	DB *gorm.DB
}

func NewStudentRepository(db *gorm.DB) *StudentRepository {
	return &StudentRepository{DB: db}
}

func (repository *StudentRepository) GetProfiles() ([]models.Student, error) {
	var students []models.Student
	query := `SELECT
    mahasiswa.id,
    mahasiswa.nim,
    mahasiswa.nama_lengkap,
    mahasiswa.nama_ortu,
    mahasiswa.telp,
    mahasiswa.status,
    mahasiswa.alamat,
    mahasiswa.tanggal_lahir,
    mahasiswa.status
FROM
    mahasiswa
LEFT JOIN
    tahun_ajaran ON mahasiswa.id_ta = tahun_ajaran.id
WHERE
    mahasiswa.id_ta = 1;`

	if err := repository.DB.Raw(query).Scan(&students).Error; err != nil {
		return nil, err
	}
	return students, nil
}

func (r *StudentRepository) GetProfilesID(id int) ([]models.Student, error) {
	var students []models.Student
	query := fmt.Sprintf(`SELECT
    mahasiswa.id,
    mahasiswa.nim,
    mahasiswa.nama_lengkap,
    mahasiswa.nama_ortu,
    mahasiswa.telp,
    mahasiswa.status,
    mahasiswa.alamat,
    mahasiswa.tanggal_lahir,
    mahasiswa.status
FROM
    mahasiswa
LEFT JOIN
    tahun_ajaran ON mahasiswa.id_ta = tahun_ajaran.id
WHERE
    mahasiswa.id_ta = %d`, id)

	err := r.DB.Raw(query).Scan(&students).Error
	return students, err

	// var profiles models.Student
	// err := r.DB.First(&profiles, id).Error
	// return profiles, err
}
