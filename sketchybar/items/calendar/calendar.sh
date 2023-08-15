#!/usr/bin/env bash

CAL_PLUGIN_DIR="$ITEM_DIR/calendar/scripts"



calendar_date=(
	icon.font="$FONT:Bold:13.0"
	icon.align=right
	icon.padding_right=0
	width=30
	y_offset=6
	update_freq=120
	script="$CAL_PLUGIN_DIR/date.sh"
  click_script="$CAL_PLUGIN_DIR/click.sh"
)

calendar_clock=(
	icon=clock
	icon.font="SF Mono:Semibold:12.0"
	icon.align=right
	icon.padding_right=0
	background.padding_right=-28
	background.padding_left=0
	y_offset=-7
	update_freq=1
	script="$CAL_PLUGIN_DIR/clock.sh"
	label.padding_left=-50
  click_script="$CAL_PLUGIN_DIR/click.sh"
)

sketchybar 	--add item calendar.date right 								\
						--set calendar.date "${calendar_date[@]}" 		\
						--subscribe calendar.date system_woke 				\
																													\
						--add item calendar.clock right 							\
						--set calendar.clock "${calendar_clock[@]}" 	\
						--subscribe calendar.clock system_woke
