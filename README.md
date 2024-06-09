```sh
TAG=<tag>
docker build -t yolov8:$TAG .
docker tag yolov8:vastai-v2 alyetama/yolov8:$TAG
docker push alyetama/yolov8:$TAG
```
