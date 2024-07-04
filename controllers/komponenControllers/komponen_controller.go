package komponenControllers

import (
	"net/http"
	"strconv"
	"tugasuas/config"
	models "tugasuas/models/komponen"
	"tugasuas/repositories"

	"github.com/gin-gonic/gin"
)

type KomponenController struct {
	Repo repositories.KomponenRepository
}

func (c *KomponenController) Create(ctx *gin.Context) {
	var komponen models.Komponen
	if err := ctx.ShouldBindJSON(&komponen); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	if err := c.Repo.Create(&komponen); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	ctx.JSON(http.StatusCreated, komponen)
}

func (c *KomponenController) GetAll(ctx *gin.Context) {
	komponen, err := c.Repo.FindAll()
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, komponen)
}

func (c *KomponenController) GetByID(ctx *gin.Context) {
	id, _ := strconv.Atoi(ctx.Param("id"))
	komponen, err := c.Repo.FindByID(id)
	if err != nil {
		ctx.JSON(http.StatusNotFound, gin.H{"error": "komponen not found"})
		return
	}
	ctx.JSON(http.StatusOK, komponen)
}

func (c *KomponenController) Update(ctx *gin.Context) {
	id, _ := strconv.Atoi(ctx.Param("id"))
	var komponen models.Komponen
	if err := ctx.ShouldBindJSON(&komponen); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	db := config.ConnectDatabase()
	query := "UPDATE komponen SET biaya = ? WHERE id = ?"

	komponen.ID = id
	if err := db.Exec(query, komponen.Biaya, komponen.ID).Error; err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, komponen)
	// komponen.ID = id
	// if err := c.Repo.Update(&komponen); err != nil {
	// 	ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
	// 	return
	// }
	// ctx.JSON(http.StatusOK, komponen)
}

func (c *KomponenController) Delete(ctx *gin.Context) {
	id, _ := strconv.Atoi(ctx.Param("id"))
	if err := c.Repo.Delete(id); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "komponen deleted successfully"})
}
