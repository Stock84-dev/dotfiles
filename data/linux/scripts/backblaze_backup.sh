#!/bin/bash

rclone sync / BackblazeCrypt:Frankenstein-stock-pc/root --links --exclude={"/dev/*","/swapfile","/raid/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found", "/home/stock/ssd/", "/home/stock/data/", "/home/stock/nvme"}
rclone sync /home/stock/ssd BackblazeCrypt:Frankenstein-stock-pc/ssd --links --exclude /home/stock/ssd/rustc_target/
rclone sync /home/stock/data BackblazeCrypt:Frankenstein-stock-pc/data --links
