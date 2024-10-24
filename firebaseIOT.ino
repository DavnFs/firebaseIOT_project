#include <FirebaseESP8266.h>
#include <ESP8266WiFi.h>
#include <DHT.h>

// Firebase configuration
#define FIREBASE_HOST "" // isi dengan firebase host anda
#define FIREBASE_AUTH "" // isi dengan firebase auth anda

// WiFi configuration
#define WIFI_SSID "Davin's S20"
#define WIFI_PASSWORD "********"

// DHT and LED configuration
#define DHTPIN D5      // Data pin for DHT11
#define DHTTYPE DHT11  // DHT sensor type
int led = D2;          // Pin for LED

DHT dht(DHTPIN, DHTTYPE);  // Initialize DHT sensor

// Create Firebase objects
FirebaseData firebaseData;
FirebaseData ledData;
FirebaseConfig firebaseConfig;
FirebaseAuth firebaseAuth;
FirebaseJson json;

void setup() {
// Start serial communication
Serial.begin(115200);

// Initialize DHT sensor
dht.begin();

// Set up LED pin
pinMode(led, OUTPUT);

// Connect to Wi-Fi
Serial.println("=== WiFi Connection ===");
WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
Serial.print("Connecting to Wi-Fi");
while (WiFi.status() != WL_CONNECTED) {
Serial.print(".");
delay(300);
}

Serial.println();
Serial.print("Connected with IP: ");
Serial.println(WiFi.localIP());
Serial.println("========================\n");

// Set Firebase configurations
firebaseConfig.host = FIREBASE_HOST;
firebaseConfig.signer.tokens.legacy_token = FIREBASE_AUTH;

// Initialize Firebase
Firebase.begin(&firebaseConfig, &firebaseAuth);
Firebase.reconnectWiFi(true);
}

void sensorUpdate() {
// Read humidity and temperature from DHT sensor
float h = dht.readHumidity();
float t = dht.readTemperature();
float f = dht.readTemperature(true);  // Read temperature in Fahrenheit

// Check if any reads failed
if (isnan(h) || isnan(t) || isnan(f)) {
Serial.println(F("Failed to read from DHT sensor!"));
return;
}

// Print temperature and humidity values to Serial Monitor
Serial.println("=== Sensor Readings ===");
Serial.print("Humidity    : ");
Serial.print(h);
Serial.println(" %");

Serial.print("Temperature : ");
Serial.print(t);
Serial.println(" °C");

Serial.print("Temperature : ");
Serial.print(f);
Serial.println(" °F");
Serial.println("========================\n");

// Send temperature data to Firebase
if (Firebase.setFloat(firebaseData, "/esiot-db/suhu", t)) {
Serial.println("Temperature data sent successfully to Firebase.");
} else {
Serial.println("Failed to send temperature data to Firebase.");
Serial.println("Reason: " + firebaseData.errorReason());
}

// Send humidity data to Firebase
if (Firebase.setFloat(firebaseData, "/esiot-db/kelembapan", h)) {
Serial.println("Humidity data sent successfully to Firebase.");
} else {
Serial.println("Failed to send humidity data to Firebase.");
Serial.println("Reason: " + firebaseData.errorReason());
}	

Serial.println("========================\n");
}

void loop() {
// Update sensor data
sensorUpdate();

// Check LED status from Firebase
Serial.println("=== LED Status Check ===");
if (Firebase.getString(ledData, "/esiot-db/led")) {
String ledStatus = ledData.stringData();  // Ambil nilai status LED dari Firebase
if (ledStatus == "1") {
Serial.println("LED Status: ON");
digitalWrite(led, HIGH);   // Nyalakan LED
} else if (ledStatus == "0") {
Serial.println("LED Status: OFF");
digitalWrite(led, LOW);    // Matikan LED
} else {
Serial.println("Unknown LED command from Firebase!");
}
} else {
Serial.println("Failed to get LED status from Firebase.");
}

Serial.println("========================\n");

// Delay 100 ms before the next loop
delay(3000);
}
