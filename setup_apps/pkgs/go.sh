#!/bin/bash

echo "installing Go..." 
curl -sS https://webi.sh/golang | sh; \
source ~/.config/envman/PATH.env
go version
