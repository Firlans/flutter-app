package controllers

import (
	"net/http"
	"strconv"
	models "tugasuas/models/tahunAjaran"
	"tugasuas/repositories"

	"github.com/gin-gonic/gin"
)

type TahunAjaranController struct {
	Repository *repositories.TahunAjaranRepository
}

func NewTahunAjaranController(repository *repositories.TahunAjaranRepository) *TahunAjaranController {
	return &TahunAjaranController{Repository: repository}
}

func (c *TahunAjaranController) Create(ctx *gin.Context) {
	var tahunAjaran models.TahunAjaran
	if err := ctx.ShouldBindJSON(&tahunAjaran); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := c.Repository.Create(&tahunAjaran); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, tahunAjaran)
}

func (c *TahunAjaranController) GetByID(ctx *gin.Context) {
	id, err := strconv.Atoi(ctx.Param("id"))
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}
	tahunAjaran, err := c.Repository.GetByID(uint(id))
	if err != nil {
		ctx.JSON(http.StatusNotFound, gin.H{"error": "Record not found"})
		return
	}
	ctx.JSON(http.StatusOK, tahunAjaran)
}

func (c *TahunAjaranController) GetAll(ctx *gin.Context) {
	tahunAjaran, err := c.Repository.GetAll()
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, tahunAjaran)
}

func (c *TahunAjaranController) Update(ctx *gin.Context) {
	id, err := strconv.Atoi(ctx.Param("id"))
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	var tahunAjaran models.TahunAjaran
	if err := ctx.ShouldBindJSON(&tahunAjaran); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	tahunAjaran.ID = uint(id)
	if err := c.Repository.Update(&tahunAjaran); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, tahunAjaran)
}

func (c *TahunAjaranController) Delete(ctx *gin.Context) {
	id, err := strconv.Atoi(ctx.Param("id"))
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}
	if err := c.Repository.Delete(uint(id)); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"message": "Record deleted"})
}
