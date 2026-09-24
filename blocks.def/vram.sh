#!/bin/sh
read -r TOTAL < /sys/class/drm/card1/device/mem_info_vram_total
read -r USED < /sys/class/drm/card1/device/mem_info_vram_used
awk -v u="$USED" -v t="$TOTAL" 'BEGIN{printf " %.0f/%.0fG", u/1073741824, t/1073741824}'
