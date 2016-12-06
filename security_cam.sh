#!/bin/bash

    if [ ! -d "/var/run/motion" ]; then
	echo "Creating directory /var/run/motiom/"
	sudo mkdir /var/run/motion >/dev/null 2>/dev/null
    fi    

    echo "Starting motion"
    motion >/dev/null 2>/dev/null

    numfiles=(*)
    my_pic=(*)
        while true; 
	do
	    numfiles=$(ls -1 --file-type | grep -v '/$' | wc -l)
	    echo "Number of files before copying:" $numfiles

	    echo "Copying files"
	    find /home/paulo/.motion/motion-images/ -type f \( -iname "*.jpg" -o -iname "*.jpeg" \) -exec cp '{}' ./ \;

	    numfiles2=$(ls -1 --file-type | grep -v '/$' | wc -l)
	    echo "Number of files after copying:" $numfiles2

	    if [ "$numfiles2" -gt "$numfiles" ]
	    then
		
		echo "Executing sounds"
                mpg123 siren.mp3 sound.mp3 >/dev/null 2>/dev/null &

#		echo "Creating files list"
#		sudo touch gdrive_files; sudo chmod 777 gdrive_files
#		sudo touch local_files; sudo chmod 777 local_files
#		sudo touch upload_files; sudo chmod 777 upload_files
#		sudo gdrive list | awk '{print $2}' | tail -n +2 | sort -u > gdrive_files
#		sudo ls -1 | sort -u > local_files
#		sudo comm -23 local_files gdrive_files > upload_files

# 	        read -p "Press [Enter] key to start backup..."

#		echo "Adding new files to Google Drive"				
#		sudo xargs -0 -n 1 gdrive upload --no-progress < <(tr \\n \\0 <upload_files) >/dev/null 2>/dev/null &
#		echo "Finihsed uploading"

# 	        read -p "Press [Enter] key to start backup..."

	        echo "Adding new files"
	        git add --all >/dev/null 2>/dev/null 

    	        echo "Comitting changes"
	        git commit -m "Pictures" >/dev/null 2>/dev/null

   	        echo "Pushing changes" 
		git push >/dev/null 2>/dev/null

# 	        read -p "Press [Enter] key to start backup..."

		my_pic=$(ls *.jpg | sort -r | head -1)
		echo "Sending e-mail" $my_pic
            	mutt  -s "Security cam information: new picture added to repository" 'prarante@laas.fr' -a ${my_pic} < email 			
	    fi	    
	    
            echo ""

    	    sleep 1
        done
