#!/bin/sh
clear
printf "\nXiaomi MI-3 WDS frequency changing script.\nFeel free to fork, modify and distribute.\nGitHub: github.com/goshil/MI-3-reset-button-switcher\nCredits: besprovodnoe.ru, 2017.\n"
default=5 #this freq will be set 1st by default
f_toset=$default #freq to set, initialized as default
counter=0 #init of led flashes counter
flashes_count=0 # init of led count
while : #infinity loop
do 
 while [ $(echo $(mtk_gpio -r 30) |tail -c 2) = "1" ] #read reset gpio (mi3 is inverted)
 do 
  usleep 100000 #check every 100ms if button pushed
 done
 if [ "$f_toset" -eq 5 ]; then
  echo "Setting up 5ghz WDS bridge" | tee /dev/kmsg #also append to kernel log
  nvram set rt_mode_x=0 # 2.4ghz mode to AP
  echo -n "."
  nvram set rt_radio_x=1 # enable 2.4ghz radio module
  echo -n "."
  nvram set wl_mode_x=2 # 5ghz mode to WDS + AP
  echo -n "."
  nvram set wl_radio_x=1 # enable 5ghz radio module
  echo -n "."
  nvram commit #save changes permanently
  echo ".done"
  flashes_count=$f_toset
  f_toset=2 # next will be 2.4ghz
 elif [ "$f_toset" -eq 2 ]; then
  echo "Setting up 2.4ghz WDS bridge" | tee /dev/kmsg #also append to kernel log
  nvram set wl_mode_x=0 # 5ghz mode to AP
  echo -n "."
  nvram set wl_radio_x=1 # enable 5ghz radio module
  echo -n "."
  nvram set rt_mode_x=2 # 2.4ghz mode to WDS + AP
  echo -n "."
  nvram set rt_radio_x=1 # enable 2.4ghz radio module
  echo -n "."
  nvram commit #save changes permanently
  echo ".done"
  flashes_count=$f_toset
  f_toset=5 # next will be 5ghz
 fi
 usleep 500000 #pause to prevent led flickering with button
 for counter in $(seq 1 $flashes_count); # number of led flashes matches applied freq
 do
  mtk_gpio -w 29 0 # enable red colour on led (+ existing blue = violet);
  usleep 500000 # wait half a second;
  mtk_gpio -w 29 1 # disable red colour on led (=blue);
  usleep 500000 # wait half a second;
 done
 counter=0
done
