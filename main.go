package main

import (
	"time"
	"tugasuas/config"
	"tugasuas/controllers/komponenControllers"
	"tugasuas/controllers/mahasiswaControllers"
	"tugasuas/controllers/pembayaranControllers"
	"tugasuas/controllers/profilControlers"
	TagihanControlers "tugasuas/controllers/tagihanControlers"
	TahunAjaranControllers "tugasuas/controllers/tahunAjaranControllers"
	"tugasuas/repositories"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

func main() {
	db := config.ConnectDatabase()

	studentRepository := repositories.NewStudentRepository(db)
	studentController := profilControlers.NewStudentController(studentRepository)

	tagihanRepository := repositories.NewTagihanRepository(db)
	tagihanController := TagihanControlers.NewTagihanController(tagihanRepository)

	mahasiswaRepo := repositories.MahasiswaRepository{DB: db}
	mahasiswaController := mahasiswaControllers.MahasiswaController{Repo: mahasiswaRepo}

	komponenRepo := repositories.KomponenRepository{DB: db}
	komponenController := komponenControllers.KomponenController{Repo: komponenRepo}

	tahunAjaranRepository := repositories.TahunAjaranRepository{DB: db}
	tahunAjaranController := TahunAjaranControllers.TahunAjaranController{Repository: tahunAjaranRepository}

	pembayaranRepository := repositories.PembayaranRepository{DB: db}
	pembayaranController := pembayaranControllers.PembayaranController{Repository: pembayaranRepository}

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

	// PROFILES
	r.GET("/tagihan", tagihanController.GetProfiles)
	r.GET("/tagihan/:id", tagihanController.GetProfilesID)

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

	// TAHUN AJARAN
	r.POST("/tahun-ajaran", tahunAjaranController.Create)
	r.GET("/tahun-ajaran/:id", tahunAjaranController.GetByID)
	r.GET("/tahun-ajaran", tahunAjaranController.GetAll)
	r.PUT("/tahun-ajaran/:id", tahunAjaranController.Update)
	r.DELETE("/tahun-ajaran/:id", tahunAjaranController.Delete)

	// PEMBAYARAN
	r.GET("/pembayaran", pembayaranController.GetAll)
	r.GET("/pembayaran/:id", pembayaranController.GetByID)
	r.POST("/pembayaran", pembayaranController.Create)
	r.PUT("/pembayaran/:id", pembayaranController.Update)
	r.DELETE("/pembayaran/:id", pembayaranController.Delete)

	r.Run(":1233")
}
