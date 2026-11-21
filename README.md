# Readers' Haven Public Library

Static 5-page website (HTML + CSS) built with Parcel and served by Nginx in a multi-stage Docker image.

Team: Ali Ashtaf (Team Lead), Muhammad Mahad, Muhammad Abuzar

## Run locally
```
npm ci
npm run build
```

## Docker
```
docker image build -t <dockerhub-username>/readers-haven-final:v2.0 .
docker container run -d --name haven-final -p 8081:80 <dockerhub-username>/readers-haven-final:v2.0
```
Open http://localhost:8081
