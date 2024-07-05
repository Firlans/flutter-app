// controller/pembayaran_controller.go
package pembayaranControllers

import (
	"net/http"
	"strconv"
	models "tugasuas/models/pembayaran"
	"tugasuas/repositories"

	"github.com/gin-gonic/gin"
)

type PembayaranController struct {
	Repository repositories.PembayaranRepository
}

func NewPembayaranController(repository repositories.PembayaranRepository) *PembayaranController {
	return &PembayaranController{Repository: repository}
}

func (c *PembayaranController) Create(ctx *gin.Context) {
	var pembayaran models.Pembayaran
	if err := ctx.ShouldBindJSON(&pembayaran); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := c.Repository.Create(&pembayaran); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, pembayaran)
}

func (c *PembayaranController) GetByID(ctx *gin.Context) {
	id, err := strconv.Atoi(ctx.Param("id"))
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}
	pembayaran, err := c.Repository.GetByID(uint(id))
	if err != nil {
		ctx.JSON(http.StatusNotFound, gin.H{"error": "Record not found"})
		return
	}
	ctx.JSON(http.StatusOK, pembayaran)
}

func (c *PembayaranController) GetAll(ctx *gin.Context) {
	pembayaran, err := c.Repository.GetAll()
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, pembayaran)
}

func (c *PembayaranController) Update(ctx *gin.Context) {
	id, err := strconv.Atoi(ctx.Param("id"))
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	var pembayaran models.Pembayaran
	if err := ctx.ShouldBindJSON(&pembayaran); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	pembayaran.ID = uint(id)
	if err := c.Repository.Update(&pembayaran); err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, pembayaran)
}

func (c *PembayaranController) Delete(ctx *gin.Context) {
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
