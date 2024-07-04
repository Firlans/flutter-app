package profilControlers

import (
	"net/http"
	"strconv"
	"tugasuas/repositories"

	"github.com/gin-gonic/gin"
)

type StudentController struct {
	Repository *repositories.StudentRepository
}

func NewStudentController(repository *repositories.StudentRepository) *StudentController {
	return &StudentController{Repository: repository}
}

// GET PROFILES
func (controller *StudentController) GetProfiles(c *gin.Context) {

	students, err := controller.Repository.GetProfiles()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, students)
}

func (c *StudentController) GetProfilesID(ctx *gin.Context) {
	id, _ := strconv.Atoi(ctx.Param("id"))
	// id := ctx.Param("id")

	// students, err := c.Repository.GetProfiles()
	// if err != nil {
	// 	c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
	// 	return
	// }
	// c.JSON(http.StatusOK, students)

	komponen, err := c.Repository.GetProfilesID(id)
	if err != nil {
		ctx.JSON(http.StatusNotFound, gin.H{"error": "komponen not found"})
		return
	}
	ctx.JSON(http.StatusOK, komponen)
}
