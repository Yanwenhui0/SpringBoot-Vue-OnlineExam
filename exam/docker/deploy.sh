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
docker rm -f exam-web
docker rmi -f $(docker images -q -f dangling=true)

docker build -t exam-web:0.1 .
docker run -d --name exam-web -p 80:80 exam-web:0.1
