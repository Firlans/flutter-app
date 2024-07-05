package models

import "time"

type TahunAjaran struct {
	ID        uint      `gorm:"primaryKey" json:"id"`
	Periode   uint      `gorm:"type:year" json:"periode"`
	TglMulai  time.Time `json:"tgl_mulai"`
	TglAkhir  time.Time `json:"tgl_akhir"`
	Kurikulum string    `gorm:"type:varchar(255)" json:"kurikulum"`
}

func (TahunAjaran) TableName() string {
	return "tahun_ajaran"
}
