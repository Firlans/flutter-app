package models

import "time"

// import "gorm.io/gorm"

type Komponen struct {
	// gorm.Model
	ID           int       `gorm:"primaryKey"`
	KodeKomponen string    `gorm:"column:kode_komponen;type:char(1)"`
	NamaKomponen string    `gorm:"column:nama_komponen;type:char(1)"`
	IdTa         int       `gorm:"column:id_ta"`
	Biaya        uint32    `gorm:"column:biaya"`
	KodeKelas    int       `gorm:"column:kode_kelas"`
	TglDibuat    time.Time `gorm:"column:tgl_dibuat;autoCreateTime"`
}

func (Komponen) TableName() string {
	return "komponen"
}
