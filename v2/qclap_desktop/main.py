from PyQt6.QtWidgets import QApplication, QWidget

import sys, os, time

import cv2
# from pyzbar import pyzbar
import ffmpeg

class QRExtractor:
    def __init__(self):
        self.URI = ""
        self.uri_detected = False
        return

    def extract_qr(self, video):
        fps = video.get(cv2.CAP_PROP_FPS)
        total_frames = video.get(cv2.CAP_PROP_FRAME_COUNT)
        print('frames per second =',fps)
        print('total frames =',total_frames)

        frame_id = 100
        last_time = time.time()

        while frame_id < total_frames:
            print('frame id =',frame_id)
            # Read Frame
            video.set(cv2.CAP_PROP_POS_FRAMES, frame_id)
            ret, frame = video.read()
            # if frame_id == 235:
                # cv2.imshow('frame', frame); cv2.waitKey(0)
                # cv2.imwrite('frame' + str(frame_id) + '.png', frame)
            
            # Frame Record Logging
            frame_id += round(1)
            print("Extracted Frame " + str(frame_id) + " in " + str(round((time.time()-last_time)*1000)) + " ms.")
            last_time = time.time()
            
            response = self.decode_qr(frame, frame_id)
            if response is not None:
                self.URI = response
                return True
        return False

    # def ffmpeg_extract_qr(self, video):



    def decode_qr(self, frame, frame_id):
        qcd = cv2.QRCodeDetector()
        retval, points = qcd.detect(frame)
        # retval, points, straight_qrcode = qcd.detectAndDecodeCurved(frame)
        print(retval)
        
        if not retval:
            return None

        else: 
            # cv2.imwrite('frame' + str(frame_id) + '.png', frame)
            # try:
            last_time = time.time()
            self.URI, straight_qr = qcd.decodeCurved(frame, points)
            print("Decoded URI in " + str(round((time.time()-last_time)*1000)) + " ms.")
            # decoded_list = decode(img)
            # self.URI = decoded_list[0].data
            print("URI: ", self.URI)
            if self.URI != "":
                return True
            return None
            # except:
            #     return None

    def handle(self, filename):
        # Check File
        if not os.path.exists(filename):
            raise Exception("Video File Does Not Exist!")

        # Read File
        video = cv2.VideoCapture(filename)
        status = self.extract_qr(video)
        if status == False:
            print("QR Code Not Detected!")
        else:
            print("Detected URI: ", self.URI)
        return

    def handle_ffmpeg(self, filename):
        # Check File
        if not os.path.exists(filename):
            raise Exception("Video File Does Not Exist!")

        # Read File
        video = cv2.VideoCapture(filename)
        status = self.extract_qr(video)
        if status == False:
            print("QR Code Not Detected!")
        else:
            print("Detected URI: ", self.URI)
        return









class QClapDesktop:
    def __init__(self):
        self.app = QApplication(sys.argv)

        # Create a Qt widget, which will be our window.
        self.window = QWidget()
        self.window.show()  # IMPORTANT!!!!! Windows are hidden by default.

    def run(self):
        # Start the event loop.
        self.app.exec()




if __name__ == "__main__":
    extractor = QRExtractor()
    # extractor.handle('/Users/danielhou/Documents/Code/test1.MP4')
    extractor.handle('/Users/danielhou/Documents/Code/test2.MP4')
    extractor.handle('/Users/danielhou/Documents/Code/test4.mp4')
    # app = QClapDesktop()
    # app.run()