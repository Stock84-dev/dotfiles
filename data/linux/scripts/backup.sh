#!/bin/bash
# exclude=(
# --exclude '**/target/' --exclude '**/.git/'
# )
# rsync -trv ${exclude[@]} src:dest
exclude=(
	--exclude '**/target/' 
	--exclude '**/.git/' 
	--exclude '*.csv' 
	--exclude '**/.idea/' 
	--exclude '**/.vscode/' 
	--exclude '**/.undodir/' 
	--exclude '**/venv/' 
	--exclude '*.feather' 
	--exclude '*.svg' 
	--exclude '*.txt' 
	--exclude '*.csv' 
	--exclude '*.bin' 
	--exclude '*.annotation' 
	--exclude '**/*.profdata' 
	--exclude '**/*.mm_profdata' 
	--exclude '**/perf.data*' 
	--exclude '**/*.png' 
	--exclude '**/rustc-ice*' 
	--exclude '**/__pycache__/' 
	--exclude '**/*.so'
)

rsync -trv "${exclude[@]}" "/home/stock/ssd/projects/project-fusion" "/home/stock/ssd/projects/backup"
# rsync -trv "${exclude[@]}" jernej:/home/user_public/leon_s/workspace/repos/ "/home/stock/ssd/projects/backup"

cd "/home/stock/ssd/projects/backup"
git add .
git commit -m "cron"
git push
