
import numpy as np
import cv2
import os


def get_image_from_video(video, out_put_path):
    cap = cv2.VideoCapture(video)
    count = 0
    print(cap.isOpened())
    while cap.isOpened():
        ret, image = cap.read()
        if ret:
            cv2.imwrite(os.path.join(output_path, "%d.jpg") % count, image)  # save frame as JPEG file
            count += 1
        else:
            break
        if cv2.waitKey(10) == 27:  # exit if Escape is hit
            break

    cap.release()
    cv2.destroyAllWindows()
    print("Total {} images were captured".format(count))


video_name = 'BlueUmbrella.webm'  #Capture_1.avi'
out_put_path = r"C:\Users\dbsnail\ImageFolder\ImageFromVideo"
get_image_from_video(video_name,out_put_path)