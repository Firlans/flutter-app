// models/pembayaran.go
package models

import "time"

type Pembayaran struct {
	ID            uint      `gorm:"primaryKey"`
	IDTA          uint      `gorm:"column:id_ta"`
	IDMahasiswa   uint      `gorm:"column:id_mahasiswa"`
	TglPembayaran time.Time `gorm:"column:tgl_pembayaran;autoCreateTime"`
	JumlahBayar   int       `gorm:"column:jumlah_bayar"`
	MetodeBayar   string    `gorm:"column:metode_bayar"`
}

func (Pembayaran) TableName() string {
	return "pembayaran"
}
