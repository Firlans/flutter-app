package repositories

import (
	models "tugasuas/models/tahunAjaran"

	"gorm.io/gorm"
)

type TahunAjaranRepository struct {
	DB *gorm.DB
}

func NewTahunAjaranRepository(db *gorm.DB) *TahunAjaranRepository {
	return &TahunAjaranRepository{DB: db}
}

func (r *TahunAjaranRepository) Create(tahunAjaran *models.TahunAjaran) error {
	return r.DB.Create(tahunAjaran).Error
}

func (r *TahunAjaranRepository) GetByID(id uint) (*models.TahunAjaran, error) {
	var tahunAjaran models.TahunAjaran
	err := r.DB.First(&tahunAjaran, id).Error
	return &tahunAjaran, err
}

func (r *TahunAjaranRepository) GetAll() ([]models.TahunAjaran, error) {
	var tahunAjaran []models.TahunAjaran
	err := r.DB.Find(&tahunAjaran).Error
	return tahunAjaran, err
}

func (r *TahunAjaranRepository) Update(tahunAjaran *models.TahunAjaran) error {
	return r.DB.Save(tahunAjaran).Error
}

func (r *TahunAjaranRepository) Delete(id uint) error {
	return r.DB.Delete(&models.TahunAjaran{}, id).Error
}
