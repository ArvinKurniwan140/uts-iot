const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const mqtt = require('mqtt');

const app = express();
const PORT = 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.static('public'));

// ========== Konfigurasi MQTT ==========
const MQTT_BROKER = 'mqtts://3d334b6b47764fffb7480823a8402c8c.s1.eu.hivemq.cloud';
const MQTT_PORT = 8883;
const MQTT_USERNAME = 'uts-iot';
const MQTT_PASSWORD = 'Password07';

// Topics MQTT
const TOPIC_CONTROL_POMPA = 'hidroponik/control/pompa';
const TOPIC_SENSOR_DATA = 'hidroponik/sensor/data';
const TOPIC_DEVICE_STATUS = 'hidroponik/device/status';

// Koneksi MQTT dengan SSL/TLS
const mqttOptions = {
    port: MQTT_PORT,
    username: MQTT_USERNAME,
    password: MQTT_PASSWORD,
    rejectUnauthorized: false
};

console.log('🔄 Menghubungkan ke MQTT Broker...');
const mqttClient = mqtt.connect(MQTT_BROKER, mqttOptions);

// Status koneksi MQTT
let mqttConnected = false;

// ========== Koneksi MQTT ==========
mqttClient.on('connect', () => {
    console.log('✅ Terhubung ke HiveMQ Cloud');
    mqttConnected = true;
    
    // Subscribe ke topic sensor data untuk menyimpan data ke database
    mqttClient.subscribe(TOPIC_SENSOR_DATA, (err) => {
        if (!err) {
            console.log(`✅ Subscribed to ${TOPIC_SENSOR_DATA}`);
        } else {
            console.log('❌ Gagal subscribe:', err);
        }
    });
});

mqttClient.on('error', (error) => {
    console.log('❌ MQTT Error:', error);
    mqttConnected = false;
});

mqttClient.on('close', () => {
    console.log('❌ MQTT connection closed');
    mqttConnected = false;
});

mqttClient.on('offline', () => {
    console.log('❌ MQTT offline');
    mqttConnected = false;
});

// ========== Handle Incoming MQTT Messages ==========
mqttClient.on('message', (topic, message) => {
    try {
        console.log(`📩 Message received on ${topic}`);
        
        if (topic === TOPIC_SENSOR_DATA) {
            const data = JSON.parse(message.toString());
            console.log('📊 Data sensor dari ESP32:', data);
            
            // Simpan data sensor ke database
            saveSensorDataToDB(data);
        }
        
    } catch (error) {
        console.log('❌ Error parsing MQTT message:', error);
    }
});

// ========== Database connection ==========
const db = mysql.createConnection({
  host: 'localhost',
  port: 3306, 
  user: 'root',
  password: '',
  database: 'uts-iot'
});

db.connect((err) => {
  if (err) {
    console.error('Database connection failed:', err);
    return;
  }
  console.log('✅ Connected to MySQL database');
});

// ========== Fungsi Simpan Data Sensor ke Database ==========
function saveSensorDataToDB(data) {
    const { suhu, kelembapan, lux, pompa, status_led, device_id } = data;
    
    console.log('📊 Data sensor diterima:', {
        suhu: suhu,
        kelembapan: kelembapan,
        lux: lux,
        pompa: pompa,
        status_led: status_led,
        device_id: device_id
    });
    
    const pompaStatus = pompa ? 'true' : 'false';
    
    const query = `
        INSERT INTO data_sensor (suhu, kelembapan, lux, pompa_status, status_led, device_id, timestamp) 
        VALUES (?, ?, ?, ?, ?, ?, NOW())
    `;
    
    const values = [
        suhu || 0,
        kelembapan || 0,
        lux || 0,  
        pompaStatus,
        status_led || 'unknown',
        device_id || 'uts-iot'
    ];
    
    console.log('📝 Menyimpan data ke database:', values);
    
    db.query(query, values, (err, result) => {
        if (err) {
            console.error('❌ Gagal menyimpan data sensor:', err);
        } else {
            console.log('✅ Data sensor disimpan ke database, ID:', result.insertId);
        }
    });
}
// ========== API Routes ==========

// API Endpoint: GET semua data sensor (format JSON)
app.get('/api/sensor/data', (req, res) => {
  const query = `
      SELECT id, suhu, kelembapan, lux, pompa_status, status_led, device_id, timestamp 
      FROM data_sensor 
      ORDER BY timestamp DESC 
      LIMIT 100
  `;
  
  db.query(query, (err, results) => {
    if (err) {
      return res.status(500).json({
        status: 'error',
        message: 'Failed to fetch sensor data',
        error: err.message
      });
    }
    
    res.json({
      status: 'success',
      count: results.length,
      data: results
    });
  });
});

// API Endpoint: GET data sensor terbaru
app.get('/api/sensor/latest', (req, res) => {
  const query = `
      SELECT id, suhu, kelembapan, lux, pompa_status, status_led, device_id, timestamp 
      FROM data_sensor 
      ORDER BY timestamp DESC 
      LIMIT 1
  `;
  
  db.query(query, (err, results) => {
    if (err) {
      return res.status(500).json({
        status: 'error',
        message: 'Failed to fetch latest data'
      });
    }
    
    if (results.length === 0) {
      return res.status(404).json({
        status: 'error',
        message: 'No data available'
      });
    }
    
    res.json({
      status: 'success',
      data: results[0]
    });
  });
});

// API Endpoint: POST data dari ESP32 
app.post('/api/sensor/data', (req, res) => {
  const { suhu, kelembapan, lux, pompa, status_led, device_id } = req.body;
  
  if (suhu === undefined || kelembapan === undefined || lux === undefined) {
    return res.status(400).json({
      status: 'error',
      message: 'Missing required fields: suhu, kelembapan, lux'
    });
  }
  
  const query = `
      INSERT INTO data_sensor (suhu, kelembapan, lux, pompa_status, status_led, device_id, timestamp) 
      VALUES (?, ?, ?, ?, ?, ?, NOW())
  `;
  
  const values = [
      suhu, 
      kelembapan, 
      lux, 
      pompa || false, 
      status_led || 'unknown', 
      device_id || 'uts-iot'
  ];
  
  db.query(query, values, (err, result) => {
    if (err) {
      return res.status(500).json({
        status: 'error',
        message: 'Failed to insert data'
      });
    }
    
    res.status(201).json({
      status: 'success',
      message: 'Data inserted successfully',
      id: result.insertId
    });
  });
});

// API Endpoint: Control pompa
app.post('/api/control/pompa', (req, res) => {
  const { state } = req.body; // state: true/false
  
  if (typeof state !== 'boolean') {
    return res.status(400).json({
      status: 'error',
      message: 'State harus boolean (true/false)'
    });
  }
  
  // Cek koneksi MQTT
  if (!mqttConnected) {
    return res.status(500).json({
      status: 'error',
      message: 'MQTT tidak terhubung. Tidak dapat mengirim perintah ke ESP32.'
    });
  }
  
  // Kirim perintah ke ESP32 via MQTT
  const message = JSON.stringify({ 
    pompa: state,
    timestamp: new Date().toISOString(),
    source: 'web-dashboard'
  });
  
  mqttClient.publish(TOPIC_CONTROL_POMPA, message, (err) => {
    if (err) {
      console.log('❌ Gagal mengirim perintah pompa:', err);
      return res.status(500).json({
        status: 'error',
        message: 'Gagal mengirim perintah ke ESP32'
      });
    }
    
    console.log(`✅ Perintah pompa dikirim: ${state ? 'ON' : 'OFF'}`);
    
    res.json({
      status: 'success',
      message: `Pompa berhasil di${state ? 'nyalakan' : 'matikan'}`,
      mqttPublished: true
    });
  });
});

// API Endpoint: Cek status koneksi MQTT
app.get('/api/status/mqtt', (req, res) => {
  res.json({
    status: 'success',
    data: {
      mqttConnected: mqttConnected,
      broker: MQTT_BROKER,
      timestamp: new Date().toISOString()
    }
  });
});

// API Endpoint: Test publish MQTT
app.post('/api/mqtt/test', (req, res) => {
  const { topic, message } = req.body;
  
  if (!mqttConnected) {
    return res.status(500).json({
      status: 'error',
      message: 'MQTT tidak terhubung'
    });
  }
  
  mqttClient.publish(topic || TOPIC_CONTROL_POMPA, message || 'Test message from server', (err) => {
    if (err) {
      return res.status(500).json({
        status: 'error',
        message: 'Gagal publish message'
      });
    }
    
    res.json({
      status: 'success',
      message: 'Message published successfully'
    });
  });
});

// Serve HTML dashboard
app.get('/', (req, res) => {
  res.sendFile(__dirname + '/public/index.html');
});

// Start server
app.listen(PORT, () => {
  console.log(`🚀 Backend server running on http://localhost:${PORT}`);
  console.log(`📡 MQTT Target: ${MQTT_BROKER}`);
  console.log(`💧 Control Topic: ${TOPIC_CONTROL_POMPA}`);
});

// Handle graceful shutdown
process.on('SIGINT', () => {
  console.log('\n🛑 Shutting down server...');
  mqttClient.end();
  db.end();
  process.exit(0);
});