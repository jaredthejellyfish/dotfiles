#!/bin/bash

python3 skhd/build_readme.py

git add .
git commit -m "update config files"
git push origin main
