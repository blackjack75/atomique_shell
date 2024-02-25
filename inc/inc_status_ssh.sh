#!/usr/bin/env bash
                                                                                                                                                         
 SECONDS=0                                                                                                                                               
                                                                                                                                                         
 while true; do                                                                                                                                          
   sec=$(( SECONDS % 60 ))                                                                                                                   
   min=$(( SECONDS / 60 ))                                                                                                                   
                                                                                                                                                         
   echo -ne "\r [ ${min}:${sec} ]  \e[44;33;44m  $1 (ssh)   "
   sleep 1                                                                                                                                               
 done     
