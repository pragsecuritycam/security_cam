#!/bin/bash
	sudo rm -f /home/paulo/.motion/motion-images/*.jpg
    	sudo rm -f /home/paulo/.motion/motion-images/*.swf
    	sudo rm -f /home/paulo/.motion/motion-images/*.avi
    	sudo kill -9 $(ps -A | grep motion | awk '{print $1}')
