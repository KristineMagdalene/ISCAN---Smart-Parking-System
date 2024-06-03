#include <ESP8266WiFi.h>
#include <SPI.h>
#include <MFRC522.h>
#include <Servo.h>
#include <ESP8266HTTPClient.h>

#define SUCCESS_PIN A0  // Change SUCCESS_PIN to A0
#define CONN_PIN D8
#define IR_PIN D0
#define SERVO_PIN D3

const char* ssid = "PLDT_Home_82480"; // WIFI NAME OR HOTSPOT
const char* password = "Pldthome*369"; // WIFI PASSWORD OR MOBILE HOTSPOT PASSWORD
const char* slotsServerURL = "http://192.168.1.129/vpms/admin/get-available-slots.php";

bool prevWiFiStatus = false;

// RFID Configuration
#define RST_PIN1 D1   // Reset pin for first MFRC522 module
#define SS_PIN1 D4    // SS (Slave Select) pin for first MFRC522 module
#define RST_PIN2 D2   // Reset pin for second MFRC522 module
#define SS_PIN2 D8    // SS (Slave Select) pin for second MFRC522 module

MFRC522 mfrc522_1(SS_PIN1, RST_PIN1);  // Create first MFRC522 instance
MFRC522 mfrc522_2(SS_PIN2, RST_PIN2);  // Create second MFRC522 instance
Servo servo; // Create servo object

void setup() {
  delay(1000);
  Serial.begin(115200);
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
  Serial.println("");

  pinMode(CONN_PIN, OUTPUT);
  pinMode(SUCCESS_PIN, OUTPUT);
  pinMode(IR_PIN, INPUT_PULLUP); // IR sensor pin as input with internal pull-up resistor
  servo.attach(SERVO_PIN); // Attach servo to pin D3

  Serial.print("Connecting to WiFi");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("Connected to ");
  Serial.println(ssid);
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());
  
  // RFID Initialization
  SPI.begin();
  mfrc522_1.PCD_Init();
  mfrc522_2.PCD_Init();
  Serial.println("RFID and IR Status Data Receiver Initialized");
  prevWiFiStatus = true;
}

void sendRfidLog(long cardid) {
  if (WiFi.status() == WL_CONNECTED) {
    WiFiClient client;
    String getData = "cardid=" + String(cardid);
    String serverURL = "http://192.168.1.129/vpms/admin/store-rfid-log.php";
    Serial.println("Attempting to send RFID log...");
    Serial.print("Sending RFID data: ");
    if (getData.length() > 0) {
      Serial.println(getData);
    } else {
      Serial.println("");
    }
    if (client.connect("192.168.1.129", 80)) {
      client.print(String("POST ") + serverURL + " HTTP/1.1\r\n" +
                   "Host: 192.168.1.129\r\n" +
                   "Connection: close\r\n" +
                   "Content-Type: application/x-www-form-urlencoded\r\n" +
                   "Content-Length: " + getData.length() + "\r\n\r\n" +
                   getData);
      delay(10);
      while (client.available()) {
        String line = client.readStringUntil('\r');
        Serial.print(line);
      }
      client.stop();
      digitalWrite(SUCCESS_PIN, HIGH);
      delay(1000); // Keep the SUCCESS_PIN HIGH for 1 second to indicate success
      digitalWrite(SUCCESS_PIN, LOW);
      Serial.println("RFID log sent successfully");
    } else {
      Serial.println("Failed to send RFID log");
    }
  }
}

void toggleConnStat() {
  bool currentWiFiStatus = (WiFi.status() == WL_CONNECTED);
  if (currentWiFiStatus != prevWiFiStatus) {
    if (currentWiFiStatus) {
      digitalWrite(CONN_PIN, HIGH);
      Serial.println("WiFi connection status: Connected");
    } else {
      digitalWrite(CONN_PIN, LOW);
      Serial.println("WiFi connection status: Disconnected");
    }
    prevWiFiStatus = currentWiFiStatus;
  }
}

void rotateServo() {
  servo.write(180); // Rotate servo to 160 degrees
 // Wait for servo to reach the position
}


void fetchAndDisplayAvailableSlots() {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    WiFiClient client;
    http.begin(client, slotsServerURL);
    int httpCode = http.GET();
    
    if (httpCode > 0) {
      String payload = http.getString();
      Serial.println("Received available slots data: " + payload);
    } else {
      Serial.println("Error fetching available slots data");
    }
    http.end();
  }
}

void loop() {
  if (WiFi.status() == WL_CONNECTED) {
    // Look for new RFID cards
    if (mfrc522_1.PICC_IsNewCardPresent() && mfrc522_1.PICC_ReadCardSerial()) {
      Serial.println("RFID Card Detected on first reader");
      // Get the UID of the card
      String cardUID = "";
      for (byte i = 0; i < mfrc522_1.uid.size; i++) {
        cardUID.concat(String(mfrc522_1.uid.uidByte[i] < 0x10 ? "0" : ""));
        cardUID.concat(String(mfrc522_1.uid.uidByte[i], HEX));
      }
      mfrc522_1.PICC_HaltA(); // Stop reading
      Serial.print("Card UID: ");
      Serial.println(cardUID);s
      // Send RFID log to server
      sendRfidLog(strtol(cardUID.c_str(), NULL, 16));
    }
    // Look for new RFID cards on the second reader
    if (mfrc522_2.PICC_IsNewCardPresent() && mfrc522_2.PICC_ReadCardSerial()) {
      Serial.println("RFID Card Detected on second reader");
      // Get the UID of the card
      String cardUID = "";
      for (byte i = 0; i < mfrc522_2.uid.size; i++) {
        cardUID.concat(String(mfrc522_2.uid.uidByte[i] < 0x10 ? "0" : ""));
        cardUID.concat(String(mfrc522_2.uid.uidByte[i], HEX));
      }
      mfrc522_2.PICC_HaltA(); // Stop reading
      Serial.print("Card UID: ");
      Serial.println(cardUID);
      // Send RFID log to server 
      sendRfidLog(strtol(cardUID.c_str(), NULL, 16));
    }

    
    if (digitalRead(IR_PIN) == LOW) {

      rotateServo(); // Rotate servo to 160 degrees
      delay(1000);
    } else {
      // IR sensor not detecting anything, rotate servo back to 0 degrees
      servo.write(0);
    }
  }
}
