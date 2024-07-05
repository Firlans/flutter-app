package repositories

import (
	"tugasuas/config"
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

func (r *KomponenRepository) Update(id int) error {
	var komponen models.Komponen

	db := config.ConnectDatabase()
	query := "UPDATE komponen SET biaya = ? WHERE id = ?"

	// komponen.ID = id
	err := db.Exec(query, komponen.Biaya, komponen.ID).Error
	return err

	// ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
	// }

	// func (r *KomponenRepository) Update(m *models.Komponen) error {
	// 	return r.DB.Save(m).Error
}

func (r *KomponenRepository) Delete(id int) error {
	return r.DB.Delete(&models.Komponen{}, id).Error
}
