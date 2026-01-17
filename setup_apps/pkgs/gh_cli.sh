#!/bin/bash

echo "installing GitHub CLI..."
curl -sS https://webi.sh/gh | sh; \
source ~/.config/envman/PATH.env

echo "Login to GitHub..."
gh auth login
