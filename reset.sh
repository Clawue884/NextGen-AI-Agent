#!/bin/bash

# Pastikan skrip dijalankan dengan izin eksekusi
# chmod +x reset.sh

# Menampilkan pesan awal
echo "Mempersiapkan untuk mereset proyek..."

# Hentikan semua container Docker yang berjalan
echo "Hentikan semua container Docker..."
docker-compose down --volumes --remove-orphans

# Hapus semua volume Docker yang digunakan oleh proyek (membersihkan data persisten)
echo "Menghapus semua volume yang terkait dengan proyek..."
docker volume prune -f

# Menghapus image Docker jika diperlukan (optional)
echo "Menghapus image Docker yang tidak digunakan..."
docker image prune -af

# Hapus folder build atau file sementara jika ada (misalnya untuk proyek backend)
echo "Menghapus build atau file sementara..."
rm -rf ./backend/build
rm -rf ./minio/data
rm -rf ./db-data

# Pulihkan ke kondisi awal atau reset data jika diperlukan
echo "Melakukan reset data (misalnya migrasi database)..."
# (Opsional) Jalankan skrip migrasi atau reset database
docker-compose run --rm backend npm run migrate:reset  # Ganti dengan perintah yang sesuai untuk proyek Anda

# Mulai ulang semua container dan layanan
echo "Memulai ulang layanan Docker..."
docker-compose up -d --build

# Menampilkan pesan sukses
echo "Reset proyek selesai dan layanan telah dimulai ulang."
