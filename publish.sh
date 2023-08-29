#!/bin/bash

python3 tools/build_readme.py

git add .

git stage .

commit_msg=$(python3 ~/.config/tools/commit_msg.py)

git commit -m "$commit_msg"
git push origin main

yabai --restart-service
skhd --reload
brew services restart sketchybar
