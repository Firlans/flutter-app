<h2>install dependency</h2>
<p>go get -u github.com/gin-gonic/gin</p>
<p>go get -u gorm.io/gorm</p>
<p>go get -u gorm.io/driver/mysql</p>
<p>go get -u github.com/gin-contrib/cors</p>

<h2>ENDPOINT</h2>
<ul>
  <li><Strong><span style="background-color:blue">GET</span> localhost:1233/profiles</Strong> untuk menampilkan semua profiles dari semua mahasiswa</li>
  <li><Strong><span style="background-color:blue">GET</span> localhost:1233/profiles/1</Strong> untuk menampilkan semua profiles dari semua mahasiswa dengan id_ta = 1</li>
  <li><Strong><span style="background-color:blue">GET</span> localhost:1233/komponen</Strong> untuk menampilkan semua data dari tebel komponen</li>
  <li><Strong><span style="background-color:blue">GET</span> localhost:1233/komponen/1</Strong> untuk menampilkan data dari tabel komponen dengan id 1</li>
</ul>

<h2>CONTOH PENGGUNAAN</h2>
<pre>
POST localhost:1233/mahasiswa
{
	"idta": 1,
	"nim": "123456789012",
	"namalengkap": "ujang",
	"namaortu": "mimin",
	"telp": "081234512345",
	"foto": null,
	"status": "AKTIF"
}
</pre>

<pre>
POST localhost:1233/komponen
{
  "KodeKomponen":"c",
  "NamaKomponen":"c",
  "IdTa":1,
  "Biaya":1500000,
  "KodeKelas":20
}

PUT localhost:1233/komponen/1  <= '1' diganti id yang mau di edit
{
"IdTa":1,
"KodeKomponen":"c",
"NamaKomponen":"c",
"Biaya":1700000,
"KodeKelas":21
}

DELETE localhost:1233/komponen/2 <= '2' diganti id yang mau di edit
</pre>
