#! /bin/sh
cd ..

echo '\n=> npm install\n'
npm install

echo '\n=> build webapp\n'
npm run build

echo '\n=> dockerfile web app to workspace\n'
cp docker/dockerfile dist/dockerfile
cp docker/nginx.conf dist/nginx.conf

cd dist

echo '\n=> build docker image\n'
docker rm -f station-website
docker rmi -f $(docker images -q -f dangling=true)

docker build -t station-website:0.1 .
docker run -d --name exam-website -p 80:80 exam-website:0.1
