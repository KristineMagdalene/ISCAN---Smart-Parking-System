import cv2
import pickle 
import numpy as np
import requests
import serial
import mysql.connector

# Establish connection to the database
db_connection = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="gawanineca"
)
cursor = db_connection.cursor()

# Load the positions of parking spaces
with open('Sample', 'rb') as f:
    posList = pickle.load(f)

# Define the dimensions of each parking space
width, height = 240, 120

# Assign a fixed number to each parking space
parking_space_numbers = list(range(1, len(posList) + 1))

# Initialize serial connection
#ser = serial.Serial('COM6', 115200)  # Adjust the COM port and baud rate as needed

# Function to update parking space status in the database
def update_slot_status(slot_number, status):
    try:
        sql_update_query = f"UPDATE parking_status SET slot{slot_number} = '{status}' WHERE S_ID = 1"
        cursor.execute(sql_update_query)
        db_connection.commit()
        print(f"Updated slot {slot_number} status in the database.")
    except Exception as e:
        print("Error updating database:", e)
        db_connection.rollback()

# Function to check parking space occupancy
def checkParkingSpace(imgPro):
    free_slots = []

    for idx, pos in enumerate(posList):
        x, y = pos

        # Crop the parking space
        imgCrop = imgPro[y:y + height, x:x + width]

        # Count non-zero pixels to determine occupancy
        count = cv2.countNonZero(imgCrop)

        # Set slot status based on occupancy
        if count < 10:
            status = 'FREE'
            color = (0, 255, 0)  # Green if free
            free_slots.append(parking_space_numbers[idx])
        else:
            status = 'TAKEN'
            color = (0, 0, 255)  # Red if occupied

        # Draw rectangle around parking space
        cv2.rectangle(img, (x, y), (x + width, y + height), color, 2)

        # Display parking space number
        cv2.putText(img, str(parking_space_numbers[idx]), (x + 5, y + 15), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 255), 2)

        # Update slot status in the database
        update_slot_status(parking_space_numbers[idx], status)

    # Update available slots count in the database
    update_available_slots(len(free_slots))

    return len(free_slots)

# Function to update available slots count in the database
def update_available_slots(count):
    try:
        sql_update_query = f"UPDATE parking_status SET free_slots = {count} WHERE S_ID = 1"
        cursor.execute(sql_update_query)
        db_connection.commit()
        print(f"Updated available slots count to {count} in the database.")
    except Exception as e:
        print("Error updating available slots count in the database:", e)
        db_connection.rollback()


# Main loop to process the video feed
while True:
    try:
        # Fetch image from URL
        response = requests.get("http://192.168.1.202/cam-hi.jpg")
        img_array = np.array(bytearray(response.content), dtype=np.uint8)
        img = cv2.imdecode(img_array, -1)

        # Preprocess the image for parking space detection
        imgGray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        imgBlur = cv2.GaussianBlur(imgGray, (3, 3), 1)
        imgThreshold = cv2.adaptiveThreshold(imgBlur, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C,
                                             cv2.THRESH_BINARY_INV, 25, 16)
        imgMedian = cv2.medianBlur(imgThreshold, 5)
        kernel = np.ones((3, 3), np.uint8)
        imgDilate = cv2.dilate(imgMedian, kernel, iterations=1)

        # Check parking space occupancy and get the count of free slots
        checkParkingSpace(imgDilate)

        # Display the image
        cv2.imshow("Video Capture", img)
        cv2.waitKey(1)

    except Exception as e:
        print("Error:", e)
 
    finally:
        # Close the video capture window if "q" is pressed
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

# Close the serial connection and database connection
serial.close()
cv2.destroyAllWindows()
cursor.close()
db_connection.close()
