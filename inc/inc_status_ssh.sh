#!/usr/bin/env bash
                                                                                                                                                         
 SECONDS=0                                                                                                                                               
                                                                                                                                                         
 while true; do                                                                                                                                          
   sec=$(( SECONDS % 60 ))                                                                                                                   
   min=$(( SECONDS / 60 ))                                                                                                                   
                                                                                                                                                         
	echo -ne "\r [ ${min}:${sec} ]  SSH CONNECTION: $1   "
   sleep 1                                                                                                                                               
 done     
