package models

type Student struct {
	ID          uint   `json:"id"`
	NIM         string `json:"nim"`
	NamaLengkap string `json:"nama_lengkap"`
	// Alamat
	// tgllahir
	// kelamin
	// agama
	NamaOrtu string `json:"nama_ortu"`
	Telp     string `json:"telp"`
	Status   string `json:"status"`
	// Periode     string `json:"periode"`
	// TglMulai    string `json:"tgl_mulai"`
	// TglAkhir    string `json:"tgl_akhir"`
	// Kurikulum   string `json:"kurikulum"`
}
