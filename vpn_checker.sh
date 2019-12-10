#!/bin/bash
wifioff=$1

status=$(ifconfig tun0 2>&1 | grep -q 'flags' && echo $?)

# if the status is 0, the connection is active
if [ "$status" = "0" ]; then

    # if notification file exist, remove it
    if [ -f "show_notification" ]; then 
        
        rm -f show_notification 
    fi
else

    if [ ! -f "show_notification" ]; then 
        
        # if user added paramter to command, switch off wifi
        if [ "$wifioff" = "wifi_off" ]; then

            nmcli radio wifi off
        fi
        
        # let's show a desktop notification
        notify-send -u critical "VPN Connection Down" "Please re-connect to your VPN asap. Your WIFI will be automatically switched off if the flag has been set."
        echo 1 > show_notification
    fi
fi