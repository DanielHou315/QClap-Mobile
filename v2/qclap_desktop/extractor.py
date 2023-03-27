import cv2
import subprocess as sp
import numpy as np

# Input video file path
input_file = '/Users/danielhou/Documents/Code/test4.mp4'

# Enable hardware acceleration using ffmpeg
hwaccel = 'videotoolbox'  # Use the VideoToolbox hardware decoder
output_format = 'rgb24'  # Output format supported by VideoToolbox
command = ['ffmpeg',
           '-hwaccel', hwaccel,
           '-i', input_file,
           '-vf', 'fps=29.97',
           '-f', 'image2pipe',
           '-pix_fmt', output_format,
           '-vcodec', 'rawvideo', '-']
pipe = sp.Popen(command, stdout=sp.PIPE, bufsize=10**8)

# Initialize QR code detector
detector = cv2.QRCodeDetector()

decoded = False
# Read and process the frames from the video
while True:
    # Read the raw frame data from the pipe
    raw_frame = pipe.stdout.read(720*1280*3)
    if len(raw_frame) != 720*1280*3:
        break
    
    # Convert the raw frame data to a numpy array
    frame = np.frombuffer(raw_frame, dtype=np.uint8)
    frame = frame.reshape((720, 1280, 3))
    
    # Process the frame as needed
    gray = cv2.cvtColor(frame, cv2.COLOR_RGB2GRAY)
    
    # Detect QR codes in the frame
    decoded, _ = detector.detect(gray)
    if decoded:
        break

print(decoded)

