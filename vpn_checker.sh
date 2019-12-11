#!/bin/bash

wifioff=$1
scriptpath="$( cd "$(dirname "$0")" ; pwd -P )"
status=$(/sbin/ifconfig tun0 2>&1 | grep -q 'flags' && echo $?)

echo "Status: $status"
echo "Checking tunnel tun0 status"

# if the status is 0, the connection is active
if [ "$status" = "0" ]; then

    echo "VPN tun0 is active"
    # if notification file exist, remove it
    if [ -f "$scriptpath/show_notification" ]; then 
        
        echo "Removing file [$scriptpath/show_notification]"
        rm -f "$scriptpath/show_notification" 
    fi
else

    echo "VPN tun0 is down!"

    if [ ! -f "$scriptpath/show_notification" ]; then 
        
        # if user added paramter to command, switch off wifi
        if [ "$wifioff" = "wifi_off" ]; then

            echo "Switching off WiFi Connection"
            nmcli radio wifi off
        fi
        
        # let's show a desktop notification
        echo "Sending desktop notification message"
        notify-send -u critical "VPN Connection Down" "Please re-connect to your VPN asap. Your WIFI will be automatically switched off if the flag has been set."
        echo 1 > "$scriptpath/show_notification"
    else
        echo "File [$scriptpath/show_notification] exist! Desktop notification will not be shown"
    fi
fi