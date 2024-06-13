#!/bin/bash
# in cmus press u to update library (u must be binded)
# :bind -f common u shell ~/data/linux/scripts/cmus_update.sh

cmus-remote -C clear
cmus-remote -C "add ~/data/Music"
cmus-remote -C "update-cache -f"
