# Linux VPN Connection Checker

This simple bash script will check if your VPN connection is up. If not then you'll see a notification message on your desktop. You also have the option to configure the script to switch off your WiFi connection if the VPN connection is down.

This is a very basic script I wrote in 5 minutes and it does the job I need.

The assumption of this script is that your VPN connection is named "tun0". Feel free to modity it to your needs.

## Installation and Usage

Clone the script
```
git clone https://github.com/vedamak/vpn-connection-checker
```

Make the file executable
```
$ chmod u+x vpn-connection-checker/vpn_checker.sh
```

### Adding script to crontab

Setup a cron job to run the script every minute

```
$ crontab -e
```

In Unbuntu 18+ you'll need do add the following so that cron knows which desktop session to send notifications to. This may be different for other types of desktop sessions.
```
XDG_RUNTIME_DIR=/run/user/$(id -u)
```

To check for the VPN connection only
```
* * * * * XDG_RUNTIME_DIR=/run/user/$(id -u) [path_to_script]/vpn_checker.sh
```

To check for the VPN connection and switch of WiFi if VPN is off
```
* * * * * XDG_RUNTIME_DIR=/run/user/$(id -u) [path_to_script]/vpn_checker.sh wifi_off
```
