#!/bin/bash

echo "starting startup script..."

# start pd and load patch
sudo /usr/local/bin/pd -nogui -rt -open /home/pi/Documents/RSP/RSP/RSP_Main_Generic_Dynamic.pd &


# wait for pd to initialize
KA=$(aconnect -l | grep "Pure Data")

while [ "$KA" = "" ]
do
	sleep 1
	echo "waiting for pd to init midi devices..."
	KA=$(aconnect -l | grep "Pure Data")
done
echo "pd now should have midi devices running"

# make midi connections
echo "connecting Launchpad Midi-Out to Pure Data-In..."
aconnect 'Launchpad Mini':0 'Pure Data':0

echo "connecting Pure Data-Out to Launchpad Mini-In..."
aconnect 'Pure Data':1 'Launchpad Mini':0

