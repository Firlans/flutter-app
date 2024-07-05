package models

import "time"

// import "gorm.io/gorm"

type Tagihan struct {
	// gorm.Model
	// ID            int       `gorm:"primaryKey"`
	Bulan         string    `gorm:"column:bulan;type:char(1)"`
	JumlahBayar   float64   `gorm:"column:jumlah_bayar;type:decimal(10,2)"`
	Status        string    `gorm:"column:status"`
	TglPembayaran time.Time `gorm:"column:tgl_pembayaran;autoCreateTime"`
	// KodeKelas    int       `gorm:"column:kode_kelas"`
	// TglDibuat    time.Time `gorm:"column:tgl_dibuat;autoCreateTime"`
}

func (Tagihan) TableName() string {
	return "tagihan	"
}

// type Status string

// // Declare the enum values
// const (
// 	StatusActive   Status = "brhasil"
// 	StatusInactive Status = "pending"
// 	StatusPending  Status = "gagal"
// )

// // Implement the Stringer interface for pretty printing (optional)
// func (s Status) String() string {
// 	return string(s)
// }
