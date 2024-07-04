package repositories

import (
	models "tugasuas/models/mahasiswa"

	"gorm.io/gorm"
)

type MahasiswaRepository struct {
	DB *gorm.DB
}

func (r *MahasiswaRepository) Create(m *models.Mahasiswa) error {
	return r.DB.Create(m).Error
}

func (r *MahasiswaRepository) FindAll() ([]models.Mahasiswa, error) {
	var mahasiswas []models.Mahasiswa
	err := r.DB.Find(&mahasiswas).Error
	return mahasiswas, err
}

func (r *MahasiswaRepository) FindByID(id int) (models.Mahasiswa, error) {
	var mahasiswa models.Mahasiswa
	err := r.DB.First(&mahasiswa, id).Error
	return mahasiswa, err
}

func (r *MahasiswaRepository) Update(m *models.Mahasiswa) error {
	return r.DB.Save(m).Error
}

func (r *MahasiswaRepository) Delete(id int) error {
	return r.DB.Delete(&models.Mahasiswa{}, id).Error
}
