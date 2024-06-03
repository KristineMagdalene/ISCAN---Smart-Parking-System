import cv2
import numpy as np
import pickle
import requests
#from io import BytesIO

width, height = 240,120

try:
    with open('Sample', 'rb') as f:
        posList = pickle.load(f)
except:
    posList = []


def mouseClick(events, x, y, flags, params):
    if events == cv2.EVENT_LBUTTONDOWN:
        posList.append((x, y))
    if events == cv2.EVENT_RBUTTONDOWN:
        for i, pos in enumerate(posList):
            x1, y1 = pos
            if x1 < x < x1 + width and y1 < y < y1 + height:
                posList.pop(i)

    with open('Sample', 'wb') as f:
        pickle.dump(posList, f)


while True:
    try:
        response = requests.get("http://192.168.1.202/cam-hi.jpg")
        img_array = np.array(bytearray(response.content), dtype=np.uint8)
        img = cv2.imdecode(img_array, -1)
        for pos in posList:
            cv2.rectangle(img, pos, (pos[0] + width, pos[1] + height), (255, 0, 255), 2)

        cv2.imshow("Image", img)
        cv2.setMouseCallback("Image", mouseClick)
        cv2.waitKey(1)
    except Exception as e:
        print("Error:", e)
