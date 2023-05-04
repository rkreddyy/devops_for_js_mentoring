#!/bin/bash

docker build . -t ranumula/epam-training:rest-api

docker push ranumula/epam-training:rest-api
