package main

import (
	"time"
	"tugasuas/config"
	"tugasuas/controllers/komponenControllers"
	"tugasuas/controllers/mahasiswaControllers"
	"tugasuas/controllers/profilControlers"
	"tugasuas/repositories"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

func main() {
	db := config.ConnectDatabase()

	studentRepository := repositories.NewStudentRepository(db)
	studentController := profilControlers.NewStudentController(studentRepository)

	mahasiswaRepo := repositories.MahasiswaRepository{DB: db}
	mahasiswaController := mahasiswaControllers.MahasiswaController{Repo: mahasiswaRepo}

	komponenRepo := repositories.KomponenRepository{DB: db}
	komponenController := komponenControllers.KomponenController{Repo: komponenRepo}

	r := gin.Default()

	r.Use(cors.New(cors.Config{
		AllowAllOrigins:  true,
		AllowMethods:     []string{"GET", "POST", "PUT", "DELETE"},
		AllowHeaders:     []string{"Origin", "Content-Type", "Accept"},
		ExposeHeaders:    []string{"Content-Length"},
		AllowCredentials: true,
		MaxAge:           12 * time.Hour,
	}))

	// PROFILES
	r.GET("/profiles", studentController.GetProfiles)
	r.GET("/profiles/:id", studentController.GetProfilesID)

	//KOMPONEN
	r.POST("/komponen", komponenController.Create)
	r.GET("/komponen", komponenController.GetAll)
	r.GET("/komponen/:id", komponenController.GetByID)
	r.PUT("/komponen/:id", komponenController.Update)
	r.DELETE("/komponen/:id", komponenController.Delete)

	// MAHASISWA
	r.POST("/mahasiswa", mahasiswaController.Create)
	r.GET("/mahasiswa", mahasiswaController.GetAll)
	r.GET("/mahasiswa/:id", mahasiswaController.GetByID)
	r.PUT("/mahasiswa/:id", mahasiswaController.Update)
	r.DELETE("/mahasiswa/:id", mahasiswaController.Delete)

	r.Run(":1233")
}
