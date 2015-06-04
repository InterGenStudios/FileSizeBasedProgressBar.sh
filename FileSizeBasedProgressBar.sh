#!/bin/bash
# -------------------------------------------------------
# FileSizeBasedProgressBar.sh: Illustrating its namesake.
# Github: https://github.com/InterGenStudios/FileSizeBasedProgressBar.sh
# ----------------------------------------------------------------------
# InterGenStudios: 6-4-15 
# Copyright (c) 2015: InterGenStudios
# URL: https://intergenstudios.com
# --------------------------------
# License: GPL-2.0+
# URL: http://opensource.org/licenses/gpl-license.php
# ---------------------------------------------------
# FileSizeBasedProgressBar.sh is free software:
# You may redistribute it and/or modify it under the terms of the
# GNU General Public License as published by the Free Software
# Foundation, either version 2 of the License, or (at your discretion)
# any later version.
# ------------------

#---------------------------#
# Setting initial variables #
#---------------------------#

# 'DEMOFILE' wouldn't be needed in an actual operation- you would send your command's output to a file,
# and substitute your output filename for 'DEMOFILE'

touch DEMOFILE

# Initially you set 'TARGET' to 0, it will be adjusted during the run of the function

TARGET=0

# 'TOTAL' will be your total output file size
# I set a terminal to infinite scrollback, ran my make command, 
# copied the terminal output to a file, and then measured that file to find this in bytes

TOTAL=1218780

#-------------------------#
# Setting up the function #
#-------------------------#

PROGRESS_BAR () {

# Setting the TARGET variable into the function ensures it's new size is constantly reported
# Note - you would replace 'demofile' with the output file from your command

TARGET="$(wc -c < DEMOFILE)"

# This is the functions math, allowing the bar to show some progress :)

let PROGRESS=(${TARGET}*100/${TOTAL}*100)/100
let COMPLETED=(${PROGRESS}*4)/10
let REMAINING=40-$COMPLETED

#  This sets the PROGRESS_BAR string lengths

COMPLETED=$(printf "%${COMPLETED}s")
REMAINING=$(printf "%${REMAINING}s")

#
# Output example
#---------------
###
###  Current 982446
###
###  Filling up the demo file : [################################-------] 80%
###

# If you'd rather not see the dashes in the remaining portion of the bar, replace the
# single dash in the print command below with a space

printf "\rFilling up the demo file : [${COMPLETED// /#}${REMAINING// /-}] ${PROGRESS}%%"

# This is all that's included in the function
}

#----------------------------#
# Setting up the actual code #
#----------------------------#

# The dd command below is being used for this demo
# During actual execution, you would substitute your command, making sure to set it
# to continue in the background with &
#
# Note -- you would need to make sure your command outputs nothing to terminal

dd if=/dev/zero of=DEMOFILE bs=1 count=1250000 status=none &

# The clear command below isn't necessary, nor are the following clear, echo, or print commands-
# I only used them for spacing and placement with this demo

clear

# The while loop, in conjunction with the function, makes the progress bar move

while [ $TARGET -lt $TOTAL ]; do
    sleep 0.1
    clear
    printf "\n\n\n"
    echo Current $TARGET
    echo
    PROGRESS_BAR ${TARGET} ${TOTAL}
done

# spacing for the demo, not necessary
printf "\n\n\n\n"

echo "Complete!"

# spacing for the demo, not necessary
printf "\n\n\n"

# removing the output file can be done, but making it into a logfile is also a good option
rm -rf DEMOFILE

# Don't forget to declare an exit if it's needed
exit 0

#--------------------------------------------------------------------#
# Special Thanks to Teddy Skarin for the basic concept on this one   #
#                                                                    #
# You can find that github right here:                               #
#                                                                    #
# https://github.com/fearside/ProgressBar/blob/master/progressbar.sh #
#--------------------------------------------------------------------#

