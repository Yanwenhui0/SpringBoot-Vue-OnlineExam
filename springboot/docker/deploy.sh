#! /bin/sh

cd ..
mvn package

cd docker
echo ">>>>> copy station-service-0.1.0.jar to workspace"
cp ../target/exam-0.0.1-SNAPSHOT.jar ./

echo ">>>>> docker build image..."
docker build -t yanwenhui/exam-service:0.1 .
docker rm -f exam-service
docker rmi -f $(docker images -q -f dangling=true)

echo ">>>>> docker run image..."
docker run -d --name exam-service -p 8080:8080 yanwenhui/exam-service:0.1