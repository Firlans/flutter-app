package TagihanControlers

import (
	"net/http"
	"strconv"
	"tugasuas/repositories"

	"github.com/gin-gonic/gin"
)

type TagihanController struct {
	Repository *repositories.TagihanRepository
}

func NewTagihanController(repository *repositories.TagihanRepository) *TagihanController {
	return &TagihanController{Repository: repository}
}

// GET PROFILES
func (controller *TagihanController) GetProfiles(c *gin.Context) {

	Tagihans, err := controller.Repository.GetProfiles()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, Tagihans)
}

func (c *TagihanController) GetProfilesID(ctx *gin.Context) {
	id, _ := strconv.Atoi(ctx.Param("id"))
	// id := ctx.Param("id")

	// Tagihans, err := c.Repository.GetProfiles()
	// if err != nil {
	// 	c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
	// 	return
	// }
	// c.JSON(http.StatusOK, Tagihans)

	komponen, err := c.Repository.GetProfilesID(id)
	if err != nil {
		ctx.JSON(http.StatusNotFound, gin.H{"error": "komponen not found"})
		return
	}
	ctx.JSON(http.StatusOK, komponen)
}
