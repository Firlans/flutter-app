package repositories

import (
	models "tugasuas/models/pembayaran"

	"gorm.io/gorm"
)

type PembayaranRepository struct {
	DB *gorm.DB
}

func NewPembayaranRepository(db *gorm.DB) *PembayaranRepository {
	return &PembayaranRepository{DB: db}
}

func (r *PembayaranRepository) Create(pembayaran *models.Pembayaran) error {
	return r.DB.Create(pembayaran).Error
}

func (r *PembayaranRepository) GetByID(id uint) (*models.Pembayaran, error) {
	var pembayaran models.Pembayaran
	err := r.DB.First(&pembayaran, id).Error
	return &pembayaran, err
}

func (r *PembayaranRepository) GetAll() ([]models.Pembayaran, error) {
	var pembayaran []models.Pembayaran
	err := r.DB.Find(&pembayaran).Error
	return pembayaran, err
}

func (r *PembayaranRepository) Update(pembayaran *models.Pembayaran) error {
	return r.DB.Save(pembayaran).Error
}

func (r *PembayaranRepository) Delete(id uint) error {
	return r.DB.Delete(&models.Pembayaran{}, id).Error
}
