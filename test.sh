#!/bin/bash

docker run -d -p 5001:5001 --name spiderfoot spiderfoot

echo "Waiting for startup to complete..."
until docker logs spiderfoot | grep -E 'ENGINE Bus STARTED'; do
  echo .
  sleep 5
done

if $(curl -k http://localhost:5001/login/login.html | grep -q "/static/img/spiderfoot-header.png"); then
  echo "Spiderfoot started successfully!"
else
  echo "Spiderfoot couldn't be found. There's probably something wrong"
  exit 1
fi
