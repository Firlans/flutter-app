package mahasiswaControllers

import (
	"net/http"
	"strconv"
	models "tugasuas/models/mahasiswa"
	"tugasuas/repositories"

	"github.com/gin-gonic/gin"
)

type MahasiswaController struct {
	Repo repositories.MahasiswaRepository
}

func (c *MahasiswaController) Create(ctx *gin.Context) {
	var mahasiswa models.Mahasiswa
	if err := ctx.ShouldBindJSON(&mahasiswa); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	if err := c.Repo.Create(&mahasiswa); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	ctx.JSON(http.StatusCreated, mahasiswa)
}

func (c *MahasiswaController) GetAll(ctx *gin.Context) {
	mahasiswas, err := c.Repo.FindAll()
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, mahasiswas)
}

func (c *MahasiswaController) GetByID(ctx *gin.Context) {
	id, _ := strconv.Atoi(ctx.Param("id"))
	mahasiswa, err := c.Repo.FindByID(id)
	if err != nil {
		ctx.JSON(http.StatusNotFound, gin.H{"error": "Mahasiswa not found"})
		return
	}
	ctx.JSON(http.StatusOK, mahasiswa)
}

func (c *MahasiswaController) Update(ctx *gin.Context) {
	id, _ := strconv.Atoi(ctx.Param("id"))
	var mahasiswa models.Mahasiswa
	if err := ctx.ShouldBindJSON(&mahasiswa); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	mahasiswa.ID = id
	if err := c.Repo.Update(&mahasiswa); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, mahasiswa)
}

func (c *MahasiswaController) Delete(ctx *gin.Context) {
	id, _ := strconv.Atoi(ctx.Param("id"))
	if err := c.Repo.Delete(id); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "Mahasiswa deleted successfully"})
}
