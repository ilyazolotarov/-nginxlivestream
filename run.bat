powershell "docker rm $(docker stop $(docker ps -a -q --filter name=nginxlivestream --format='{{.ID}}'))"
powershell docker run --name nginxlivestream -a stderr -a stdout -p 8080:80 nginxlivestream