# 🌱 Sistem Monitoring Hidroponik IoT

## 📋 Informasi UTS

- **Mata Kuliah**: Pemrograman IoT (IFB309)
- **Dosen**: Auralius Manurung, Ph.D.
- **Semester**: Ganjil 2025/2026
- **Tanggal**: 11 November 2025
- **Nama**: Arvin Kurniawan
- **NIM**: 152023140
- **Kelas**: AA

---

## 🎯 Deskripsi Proyek

Sistem monitoring dan kontrol hidroponik berbasis Internet of Things (IoT) yang mengintegrasikan:

- **Mikrokontroler ESP32** untuk pembacaan sensor dan kontrol aktuator
- **Sensor DHT22** untuk monitoring suhu dan kelembapan
- **Backend API** menggunakan Node.js & Express
- **Database MySQL** untuk penyimpanan data historis
- **Web Dashboard** untuk visualisasi real-time
- **Protokol MQTT** untuk komunikasi IoT

---

## 🏗️ Arsitektur Sistem

```
┌─────────────┐      WiFi/MQTT      ┌──────────────┐      HTTP/REST     ┌─────────────┐
│   ESP32     │ ──────────────────> │   Backend    │ ─────────────────> │     Web     │
│  + Sensor   │                     │   Node.js    │                    │  Dashboard  │
│  + Aktuator │ <────────────────── │   + MySQL    │ <───────────────── │             │
└─────────────┘      Commands       └──────────────┘     JSON Data      └─────────────┘
```

### Flow Data:

1. **Sensor Reading**: DHT22 → ESP32 (setiap 2 detik)
2. **Data Processing**: ESP32 memproses & menentukan status LED
3. **Data Transmission**: ESP32 → Backend via MQTT/HTTP
4. **Data Storage**: Backend → MySQL Database
5. **Data Visualization**: Backend → Web Dashboard (JSON API)
6. **Control Command**: Web Dashboard → Backend → ESP32

---

## 📁 Struktur Proyek

```
hidroponik-iot/
│
├── backend/                    # Backend Node.js Express
│   ├── server.js              # Main server file
│   ├── package.json           # Dependencies
│   └── database.sql           # Database schema
│
├── web/                       # Web Dashboard
│   └── index.html            # Single page application
│
├── README.md                 # This file
└── .gitignore               # Git ignore file
```

---

## 🔧 Hardware Requirements

### Komponen:

1. **ESP32 Development Board** (1x)
2. **Sensor DHT22** atau DHT11 (1x)
3. **LED** - Hijau, Kuning, Merah (3x)
4. **Buzzer** aktif 5V (1x)
5. **Relay Module** 1 channel (1x)
6. **Pompa DC** 12V (1x)
7. **Resistor** 220Ω (3x untuk LED)
8. **Breadboard** dan kabel jumper

### Pin Configuration:

| Komponen    | Pin ESP32 |
| ----------- | --------- |
| DHT22       | GPIO 8    |
| LED Hijau   | GPIO 5    |
| LED Kuning  | GPIO 10   |
| LED Merah   | GPIO 12   |
| Relay Pompa | GPIO 7    |
| Buzzer      | GPIO 9    |

---

## 💻 Software Requirements

### Development Tools:

- **Arduino IDE** 2.0+ atau PlatformIO
- **Node.js** v18+ (tested on v23)
- **MySQL** 8.0+ (Laragon)
- **VS Code** (recommended)

### Library ESP32:

```cpp
- DHT sensor library by Adafruit
- WiFi (built-in ESP32)
- PubSubClient (untuk MQTT)
- ArduinoJson (untuk JSON parsing)
```

### Backend Dependencies:

```json
{
  "express": "^4.18.2",
  "mysql2": "^3.6.5",
  "cors": "^2.8.5",
  "body-parser": "^1.20.2"
}
```

---

## 🚀 Cara Menjalankan

### 1. Setup Database

```sql
-- Buka phpMyAdmin (Laragon)
-- Jalankan script database.sql

CREATE DATABASE hidroponik_db;
USE hidroponik_db;

-- Jalankan semua query di database.sql
```

### 2. Setup Backend

```bash
# Navigate to backend folder
cd backend

# Install dependencies
npm install

# Start server
npm start

# Server akan berjalan di http://localhost:3000
```

### 3. Setup ESP32

```cpp
// 1. Buka Arduino IDE
// 2. Install library yang diperlukan:
//    - DHT sensor library
//    - PubSubClient
//    - ArduinoJson

// 3. Edit konfigurasi WiFi di sketch:
const char* ssid = "YOUR_WIFI_SSID";
const char* password = "YOUR_WIFI_PASSWORD";

// 4. Upload sketch ke ESP32
// 5. Buka Serial Monitor (115200 baud)
```

### 4. Akses Web Dashboard

```
Buka browser:
http://localhost/uts-iot/web/index.html

atau langsung:
file:///C:/laragon/www/uts-iot/web/index.html
```

---

## 📡 API Endpoints

### GET Endpoints:

```
GET /api/health
Response: { status: "ok", message: "Backend API is running" }

GET /api/sensor/data
Response: { status: "success", count: 10, data: [...] }

GET /api/sensor/latest
Response: { status: "success", data: { id, suhu, humidity, lux, timestamp } }
```

### POST Endpoints:

```
POST /api/sensor/data
Body: { "suhu": 28.5, "kelembapan": 65.2, "lux": 450 }
Response: { status: "success", id: 123 }

POST /api/control/pompa
Body: { "state": true }
Response: { status: "success", message: "Pompa turned ON" }
```

---

## 🔌 MQTT Topics

```
Publish (ESP32 → Backend):
Topic: hidroponik/sensor/data
Payload: { "device_id": "ESP32_001", "suhu": 28.5, "humidity": 65.2 }

Subscribe (Backend → ESP32):
Topic: hidroponik/control/pompa
Payload: { "pompa": true }
```

**MQTT Broker**: broker.hivemq.com:1883 (public)

---

## 🎨 Fitur Web Dashboard

1. **Real-time Monitoring**

   - Display suhu, kelembapan, dan kecerahan
   - Auto-refresh setiap 5 detik
   - Indikator status (Normal/Warning/Danger)

2. **Control Panel**

   - ON/OFF pompa via button
   - Manual refresh data

3. **Data Table**

   - Riwayat 10 data terakhir
   - Sortir berdasarkan timestamp

4. **Responsive Design**
   - Support desktop dan mobile
   - Gradient background
   - Smooth animations

---

## 🧪 Testing

### Test Backend:

```bash
# Test health check
curl http://localhost:3000/api/health

# Test get data
curl http://localhost:3000/api/sensor/data

# Test post data
curl -X POST http://localhost:3000/api/sensor/data \
  -H "Content-Type: application/json" \
  -d '{"suhu":28.5,"kelembapan":65.2,"lux":450}'
```

### Test ESP32:

1. Upload sketch
2. Buka Serial Monitor
3. Verifikasi:
   - WiFi connected
   - Sensor reading OK
   - LED menyala sesuai kondisi
   - Data terkirim ke backend/MQTT

### Test Web:

1. Buka dashboard
2. Verifikasi data tampil
3. Test button control pompa
4. Cek console browser untuk error

---

## 📊 Database Schema

### Tabel: data_sensor

| Column     | Type     | Description                  |
| ---------- | -------- | ---------------------------- |
| id         | INT      | Primary key (auto increment) |
| suhu       | FLOAT    | Suhu dalam Celcius           |
| kelembapan | FLOAT    | Kelembapan dalam persen      |
| lux        | FLOAT    | Kecerahan dalam Lux          |
| timestamp  | DATETIME | Waktu pencatatan             |

---

## ⚙️ Logika Kontrol Suhu

```
Suhu > 35°C  → LED MERAH + BUZZER ON  (BAHAYA)
Suhu 30-35°C → LED KUNING ON          (WASPADA)
Suhu < 30°C  → LED HIJAU ON           (NORMAL)
```

---

## 📹 Video Demo

Link video demo: https://youtu.be/0N_CSvZENUE

**Konten video:**

1. Setup dan konfigurasi backend
2. Akses API endpoint di browser
3. JSON parsing di jsoneditoronline.org
4. Demo web dashboard
5. Upload dan test ESP32
6. Serial Monitor output
7. MQTT communication demo

---

## 🐛 Troubleshooting

### Backend tidak bisa start

```bash
# Cek port 3000 digunakan atau tidak
netstat -ano | findstr :3000

# Kill process jika ada
taskkill /PID [PID_NUMBER] /F
```

### Database connection error

- Pastikan MySQL di Laragon running
- Cek credentials di server.js
- Verifikasi database sudah dibuat

### ESP32 tidak connect WiFi

- ESP32 hanya support 2.4GHz WiFi
- Cek SSID dan password
- Pastikan WiFi tidak hidden

### CORS error di web

- Sudah ditangani dengan middleware cors
- Pastikan backend running
- Clear browser cache

---

## 📝 License

MIT License - Free to use for educational purposes

---

## 👨‍💻 Author

**[Nama Anda]**

- NIM: 152023140
- Kelas: AA
- Email: arvin.kurniawan@mhs.itenas.ac.id
- GitHub: [@arvinkurniawan140](https://github.com/arvinkurniawan140)

---

## 🙏 Acknowledgments

- Dosen Pengampu:Auralius Manurung, Ph.D.
- Institut Teknologi Nasional Bandung
- Mata Kuliah: Pemrograman IoT (IFB309)

---

## 📅 Timeline

- **Start Date**: 11 November 2025, 07:30 WIB
- **Deadline**: 11 November 2025, 22:00 WIB
- **Submission**: Via Dropbox

---

**⭐ Don't forget to star this repository if you find it helpful!**
