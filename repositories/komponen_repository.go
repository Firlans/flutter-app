package repositories

import (
	models "tugasuas/models/komponen"

	"gorm.io/gorm"
)

type KomponenRepository struct {
	DB *gorm.DB
}

func (r *KomponenRepository) Create(m *models.Komponen) error {
	return r.DB.Create(m).Error
}

func (r *KomponenRepository) FindAll() ([]models.Komponen, error) {
	var komponen []models.Komponen
	err := r.DB.Find(&komponen).Error
	return komponen, err
}

func (r *KomponenRepository) FindByID(id int) (models.Komponen, error) {
	var komponen models.Komponen
	err := r.DB.First(&komponen, id).Error
	return komponen, err
}

func (r *KomponenRepository) Update(m *models.Komponen) error {
	return r.DB.Save(m).Error
}

func (r *KomponenRepository) Delete(id int) error {
	return r.DB.Delete(&models.Komponen{}, id).Error
}
