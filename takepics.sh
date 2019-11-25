#!/bin/bash

#this script takes a picture and saves it to a file. thats all 

mem_avail=$(cat /proc/meminfo | grep MemFree | awk '{ print $2 }')


dirname="/home/pi/Pictures/plants/"
filename=$(date +"%s".jpeg)
fullpath=$dirname$filename
raspistill -o  $fullpath

#if success and file created

if [ -e $fullpath ]
then
  #send to s3
  aws s3 cp $fullpath s3://totoro-garden-bucket/$filename
else
  echo "file does not exist"
fi  

