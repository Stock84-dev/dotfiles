#!/bin/bash

rsync -tr "/home/stock/ssd/projects/project-fusion" "/home/stock/ssd/projects/backup"
rm -rf "/home/stock/ssd/projects/backup/project-fusion/.git"
cd "/home/stock/ssd/projects/backup/project-fusion"
git add .
git commit -m "cron"
git push


