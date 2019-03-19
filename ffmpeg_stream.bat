powershell ffmpeg -stream_loop -1 -re -i video.mp4 -bsf:v h264_mp4toannexb ^
-c copy -f mpegts http://localhost:8080/publish/video1 ^
-c copy -f mpegts http://localhost:8080/publish/video2 ^
-c copy -f mpegts http://localhost:8080/publish/video3 ^
-c copy -f mpegts http://localhost:8080/publish/video4