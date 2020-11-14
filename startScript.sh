 #!/bin/bash

echo "starting startup script..."

# start pd and load patch
sudo /usr/local/bin/pd -nogui -rt -blocksize 64 -audiobuf 80 -r 48000 -open /home/pi/Documents/RSP/RSP/RSP_Main_Generic_Dynamic.pd &

# wait for pd to initialize
#KA=$(sudo aconnect -l | grep "Pure Data")

#while [ "$KA" = "" ]
#do
#	sudo sleep 1
#	sudo echo "waiting for pd to init midi devices..."
#	KA=$(sudo aconnect -l | grep "Pure Data")
#done

while [ "$(sudo aconnect -l | grep "Pure Data")" = "" ];
do 
	sudo echo "fuck me"
	sudo sleep 0.1
done

sudo echo "pd now should have midi devices running"

# make midi connections
sudo echo "connecting Launchpad Midi-Out to Pure Data-In..."
sudo aconnect 'Launchpad Mini':0 'Pure Data':0

sudo echo "connecting Pure Data-Out to Launchpad Mini-In..."
sudo aconnect 'Pure Data':1 'Launchpad Mini':0

