#! /bin/sh
cd ..

echo '\n=> npm install\n'
npm install

echo '\n=> build webapp\n'
npm run build

echo '\n=> copy web app to workspace\n'
cp -r . ./docker

cd docker

echo '\n=> build docker image\n'
docker rm -f station-website
docker rmi -f $(docker images -q -f dangling=true)

docker build -t station-website:0.1 .
docker run -d --name exam-website -p 80:80 exam-website:0.1
