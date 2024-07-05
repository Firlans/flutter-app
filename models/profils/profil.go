package models

import "time"

type Student struct {
	ID           uint      `json:"id"`
	NIM          string    `json:"nim"`
	NamaLengkap  string    `json:"nama_lengkap"`
	Alamat       string    `json:"alamat"`
	TanggalLahir time.Time `json:"tgl_mulai"`
	NamaOrtu     string    `json:"nama_ortu"`
	Telp         string    `json:"telp"`
	Status       string    `json:"status"`
	// Periode     string `json:"periode"`
	// TglMulai    string `json:"tgl_mulai"`
	// TglAkhir    string `json:"tgl_akhir"`
	// Kurikulum   string `json:"kurikulum"`
}
