const mqtt = require('mqtt');
const mysql = require('mysql2');

// ========== HiveMQ Cloud Configuration ==========
const MQTT_OPTIONS = {
  host: '3d334b6b47764fffb7480823a8402c8c.s1.eu.hivemq.cloud', 
  port: 8883,
  protocol: 'mqtts',
  username: 'uts-iot',      
  password: 'Password07',               
  clientId: 'backend_subscriber_' + Math.random().toString(16).substr(2, 8),
  clean: true,
  reconnectPeriod: 5000,
  connectTimeout: 30000,
  keepalive: 60
};

// ========== MQTT Topics ==========
const TOPICS = {
  SENSOR_DATA: 'hidroponik/sensor/data',
  DEVICE_STATUS: 'hidroponik/device/status',
  CONTROL_POMPA: 'hidroponik/control/pompa'
};

// ========== Database Configuration ==========
const dbConfig = {
  host: 'localhost',
  port: 3306,
  user: 'root',
  password: '',
  database: 'uts-iot',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
};

// ========== Create Database Pool ==========
const db = mysql.createPool(dbConfig);

// Test database connection
db.getConnection((err, connection) => {
  if (err) {
    console.error('❌ Database connection failed:', err.message);
    process.exit(1);
  }
  console.log('✅ Connected to MySQL database (Laragon)');
  connection.release();
});

// ========== Connect to MQTT Broker ==========
console.log('🔌 Connecting to HiveMQ Cloud MQTT Broker...');
const client = mqtt.connect(MQTT_OPTIONS);

// ========== MQTT Event Handlers ==========

client.on('connect', () => {
  console.log('✅ Connected to HiveMQ Cloud!');
  console.log('📡 Client ID:', MQTT_OPTIONS.clientId);
  console.log('');
  
  // Subscribe to topics
  client.subscribe(TOPICS.SENSOR_DATA, { qos: 0 }, (err) => {
    if (err) {
      console.error('❌ Subscribe error:', err);
    } else {
      console.log('✅ Subscribed to:', TOPICS.SENSOR_DATA);
    }
  });
  
  client.subscribe(TOPICS.DEVICE_STATUS, { qos: 0 }, (err) => {
    if (err) {
      console.error('❌ Subscribe error:', err);
    } else {
      console.log('✅ Subscribed to:', TOPICS.DEVICE_STATUS);
    }
  });
  
  console.log('');
  console.log('🎧 Listening for messages...');
  console.log('==========================================');
});

client.on('message', (topic, message) => {
  const timestamp = new Date().toLocaleString('id-ID');
  
  console.log('');
  console.log('📨 Message Received');
  console.log('⏰ Time:', timestamp);
  console.log('📍 Topic:', topic);
  console.log('📦 Payload:', message.toString());
  
  try {
    const data = JSON.parse(message.toString());
    
    // Handle based on topic
    if (topic === TOPICS.SENSOR_DATA) {
      handleSensorData(data);
    } else if (topic === TOPICS.DEVICE_STATUS) {
      handleDeviceStatus(data);
    }
    
  } catch (error) {
    console.error('❌ JSON Parse Error:', error.message);
  }
  
  console.log('------------------------------------------');
});

client.on('error', (error) => {
  console.error('❌ MQTT Error:', error.message);
});

client.on('reconnect', () => {
  console.log('🔄 Reconnecting to MQTT Broker...');
});

client.on('offline', () => {
  console.log('📴 MQTT Client is offline');
});

client.on('close', () => {
  console.log('🔌 MQTT Connection closed');
});

// ========== Handler Functions ==========

function handleSensorData(data) {
  console.log('📊 Processing sensor data...');
  
  // Validate data
  if (!data.suhu || !data.kelembapan) {
    console.error('❌ Invalid sensor data: missing required fields');
    return;
  }
  
  // Insert ke database
  const query = `
    INSERT INTO data_sensor (suhu, kelembapan, lux, timestamp) 
    VALUES (?, ?, ?, NOW())
  `;
  
  // Gunakan lux = 0 jika tidak ada data lux dari ESP32
  const lux = data.lux || 0;
  
  db.query(query, [data.suhu, data.kelembapan, lux], (err, result) => {
    if (err) {
      console.error('❌ Database Error:', err.message);
    } else {
      console.log('✅ Data saved to database');
      console.log('   ID:', result.insertId);
      console.log('   Suhu:', data.suhu + '°C');
      console.log('   Kelembapan:', data.kelembapan + '%');
      console.log('   Lux:', lux);
      
      // Log status LED
      if (data.status_led) {
        console.log('   LED Status:', data.status_led);
      }
      
      // Log pompa state
      if (data.pompa !== undefined) {
        console.log('   Pompa:', data.pompa ? 'ON' : 'OFF');
      }
    }
  });
}

function handleDeviceStatus(data) {
  console.log('ℹ️  Device Status:', data.status);
  
}

// ========== Control Functions ==========

// Fungsi untuk publish control command (bisa dipanggil dari API)
function publishPompaControl(state) {
  const payload = JSON.stringify({ pompa: state });
  
  client.publish(TOPICS.CONTROL_POMPA, payload, { qos: 0 }, (err) => {
    if (err) {
      console.error('❌ Publish Error:', err);
    } else {
      console.log('✅ Published pompa control:', state ? 'ON' : 'OFF');
    }
  });
}

module.exports = {
  publishPompaControl,
  mqttClient: client
};

// ========== Graceful Shutdown ==========

process.on('SIGINT', () => {
  console.log('');
  console.log('🛑 Shutting down gracefully...');
  
  client.end(false, () => {
    console.log('✅ MQTT connection closed');
    
    db.end((err) => {
      if (err) {
        console.error('❌ Error closing database:', err);
      } else {
        console.log('✅ Database connection closed');
      }
      
      console.log('👋 Goodbye!');
      process.exit(0);
    });
  });
});

// ========== Info Messages ==========

console.log('');
console.log('==========================================');
console.log('  MQTT Subscriber - Hidroponik IoT');
console.log('==========================================');
console.log('📡 Broker:', MQTT_OPTIONS.host);
console.log('🔒 Port:', MQTT_OPTIONS.port + ' (TLS/SSL)');
console.log('👤 User:', MQTT_OPTIONS.username);
console.log('💾 Database:', dbConfig.database);
console.log('==========================================');
console.log('');
