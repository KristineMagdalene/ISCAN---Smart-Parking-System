# ISCAN Smart Parking System

## Overview
ISCAN: Smart Parking System is a parking solution utilizing ESP32CAM for image processing and slot detection. This system leverages an SQL database for data management and integrates various hardware components like MFRC522 scanners, a servo motor, an IR sensor, ESP32CAM, and ESP8266 to create an automated parking experience.

## Features
- **Parking Slot Detection**: Uses image processing on the ESP32CAM module to detect the availability of parking slots.
- **Automated Gate Control**: A servo motor is used to manage the entry gate based on slot availability.
- **User Authentication**: Utilizes two MFRC522 RFID scanners for user authentication and slot allocation.
- **Sensor Integration**: An IR sensor for vehicle detection.
- **Remote Management**: ESP8266 module for communication and remote management.
- **Database Management**: SQL database to store and manage parking slot information and user data.

## Components
- **ESP32CAM**: For capturing images and performing image processing to detect parking slot availability.
- **ESP8266**: For Wi-Fi communication and remote control.
- **MFRC522 Scanners (x2)**: For reading RFID tags to authenticate users.
- **Servo Motor**: To control the parking gate based on availability.
- **IR Sensor**: To detect vehicle presence.
- **SQL Database**: To store data related to parking slots and users.

## Installation

### Hardware Setup
1. **ESP32CAM**: Connect the camera module and ensure it is properly configured for image capture.
2. **ESP8266**: Connect to the ESP32CAM for Wi-Fi communication.
3. **MFRC522 Scanners**: Connect the RFID scanners to read user tags.
4. **Servo Motor**: Attach to the gate mechanism and connect to the control pin on the ESP32CAM.
5. **IR Sensor**: Place in the entry path to detect incoming vehicles.
6. **Power Supply**: Ensure all components are adequately powered.

### Software Setup
1. **Clone the Repository**:
git clone https://github.com/KristineMagdalene/ISCAN-Smart-Parking-System-camera-detection-using-esp32Cam.git
    cd ISCAN-Smart-Parking-System-camera-detection-using-esp32Cam
    ```
2. **Install Required Libraries**:
    - Install the necessary Arduino libraries for ESP32CAM, ESP8266, MFRC522, and Servo Motor.
3. **Configure the SQL Database**:
    - Set up your SQL database server and create the required tables for storing parking and user data.
4. **Upload the Code**:
    - Use the Arduino IDE to upload the provided code to the ESP32CAM and ESP8266 modules.

## Usage
1. **Start the System**: Power on all components and ensure the ESP32CAM and ESP8266 are connected to your network.
2. **User Authentication**: Use the RFID tag at the MFRC522 scanner to authenticate and check for available parking slots.
3. **Parking Slot Detection**: The ESP32CAM will process the captured images and update the availability status in the SQL database.
4. **Gate Control**: If a slot is available, the servo motor will open the gate for the vehicle to enter.
5. **Database Update**: The SQL database will be updated with the new parking status and user information.

## Contributing
Contributions are welcome! Please fork this repository and submit pull requests for any improvements or bug fixes.

