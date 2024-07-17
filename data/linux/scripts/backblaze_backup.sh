#!/bin/bash

# rclone sync / BackblazeCrypt:Frankenstein-stock-pc/root --links --exclude "dev/*" --exclude "swapfile" --exclude "raid/*" --exclude "proc/*" --exclude "sys/*" --exclude "tmp/*" --exclude "run/*" --exclude "mnt/*" --exclude "media/*" --exclude "lost+found" --exclude "home/stock/ssd/" --exclude "home/stock/data/" --exclude "home/stock/nvme" &
# rclone sync /home/stock/ssd BackblazeCrypt:Frankenstein-stock-pc/ssd --links --exclude /home/stock/ssd/rustc_target/ &
# rclone sync /home/stock/data BackblazeCrypt:Frankenstein-stock-pc/data --links --exclude /home/stock/data/Downloads/Torrents &
# 
