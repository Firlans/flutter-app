package models

// import "gorm.io/gorm"

type Mahasiswa struct {
	// gorm.Model
	ID          int    `gorm:"primaryKey"`
	IdTa        int    `gorm:"column:id_ta"`
	Nim         string `gorm:"column:nim;type:char(12)"`
	NamaLengkap string `gorm:"column:nama_lengkap;type:varchar(255)"`
	// TanggalLahir time.Time `gorm:"column:tanggal_lahir;type:date"`
	TanggalLahir string `gorm:"column:tanggal_lahir;"`
	Alamat       string `gorm:"column:alamat;type:varchar(255)"`
	NamaOrtu     string `gorm:"column:nama_ortu;type:varchar(255)"`
	Telp         string `gorm:"column:telp;type:char(15)"`
	Foto         string `gorm:"column:foto;type:varchar(255)"`
	Status       string `gorm:"column:status;type:enum('AKTIF','TIDAK AKTIF')"`
}

func (Mahasiswa) TableName() string {
	return "mahasiswa"
}
