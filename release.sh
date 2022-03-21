#!/bin/bash

# Current Version: 1.0.6

## How to get and use?
# git clone "https://github.com/hezhijie0327/Trackerslist.git" && bash ./Trackerslist/release.sh

## Function
# Get Data
function GetData() {
    trackerlist_combine=(
        "https://gitee.com/harvey520/www.yaozuopan.top/raw/master/blacklist.txt"
        "https://newtrackon.com/api/all"
        "https://newtrackon.com/api/live"
        "https://newtrackon.com/api/stable"
        "https://raw.githubusercontent.com/1265578519/OpenTracker/master/tracker.txt"
        "https://raw.githubusercontent.com/DeSireFire/animeTrackerList/master/AT_all.txt"
        "https://raw.githubusercontent.com/DeSireFire/animeTrackerList/master/AT_bad.txt"
        "https://raw.githubusercontent.com/DeSireFire/animeTrackerList/master/AT_best.txt"
        "https://raw.githubusercontent.com/XIU2/TrackersListCollection/master/all.txt"
        "https://raw.githubusercontent.com/XIU2/TrackersListCollection/master/best.txt"
        "https://raw.githubusercontent.com/XIU2/TrackersListCollection/master/blacklist.txt"
        "https://raw.githubusercontent.com/XIU2/TrackersListCollection/master/other.txt"
        "https://raw.githubusercontent.com/ngosang/trackerslist/master/blacklist.txt"
        "https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_all.txt"
        "https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_best.txt"
    )
    trackerlist_custom=(
        "https://raw.githubusercontent.com/hezhijie0327/Trackerslist/source/data/data_http.txt"
        "https://raw.githubusercontent.com/hezhijie0327/Trackerslist/source/data/data_udp.txt"
        "https://raw.githubusercontent.com/hezhijie0327/Trackerslist/source/data/data_ws.txt"
    )
    trackerlist_http=(
        "https://newtrackon.com/api/http"
        "https://raw.githubusercontent.com/DeSireFire/animeTrackerList/master/AT_all_http.txt"
        "https://raw.githubusercontent.com/DeSireFire/animeTrackerList/master/AT_all_https.txt"
        "https://raw.githubusercontent.com/XIU2/TrackersListCollection/master/http.txt"
        "https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_all_http.txt"
        "https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_all_https.txt"
    )
    trackerlist_udp=(
        "https://newtrackon.com/api/udp"
        "https://raw.githubusercontent.com/DeSireFire/animeTrackerList/master/AT_all_udp.txt"
        "https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_all_udp.txt"
    )
    trackerlist_ws=(
        "https://raw.githubusercontent.com/DeSireFire/animeTrackerList/master/AT_all_ws.txt"
        "https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_all_ws.txt"
    )
    rm -rf ./trackerslist_* ./Temp && mkdir ./Temp ./Temp/data && cd ./Temp
    for trackerlist_combine_task in "${!trackerlist_combine[@]}"; do
        curl -s --connect-timeout 15 "${trackerlist_combine[$trackerlist_combine_task]}" >> ./trackerlist_combine.tmp
    done
    for trackerlist_custom_task in "${!trackerlist_custom[@]}"; do
        curl -s --connect-timeout 15 "${trackerlist_custom[$trackerlist_custom_task]}" >> ./trackerlist_custom.tmp
    done
    for trackerlist_http_task in "${!trackerlist_http[@]}"; do
        curl -s --connect-timeout 15 "${trackerlist_http[$trackerlist_http_task]}" >> ./trackerlist_http.tmp
    done
    for trackerlist_udp_task in "${!trackerlist_udp[@]}"; do
        curl -s --connect-timeout 15 "${trackerlist_udp[$trackerlist_udp_task]}" >> ./trackerlist_udp.tmp
    done
    for trackerlist_ws_task in "${!trackerlist_ws[@]}"; do
        curl -s --connect-timeout 15 "${trackerlist_ws[$trackerlist_ws_task]}" >> ./trackerlist_ws.tmp
    done
}
# Analyse Data
function AnalyseData() {
    trackerlist_verified=($(cat ./trackerlist_*.tmp | tr -cd "[:alnum:]-./:_\n" | tr "A-Z" "a-z" | sed "s/\.php$//g" | grep -E "^(http|https|udp|ws|wss):[\/]{2}(([a-z]{1})|([a-z]{1}[a-z]{1})|([a-z]{1}[0-9]{1})|([0-9]{1}[a-z]{1})|([a-z0-9][-\.a-z0-9]{1,61}[a-z0-9]))\.([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3}):[0-9]{1,5}/announce$" | sort | uniq | awk "{ print $2 }"))
    trackerlist_unverified_udp=($(cat ./trackerlist_*.tmp | tr -cd "[:alnum:]-./:_\n" | tr "A-Z" "a-z" | sed "s/\.php$//g" | grep -vE "^(udp):[\/]{2}(([a-z]{1})|([a-z]{1}[a-z]{1})|([a-z]{1}[0-9]{1})|([0-9]{1}[a-z]{1})|([a-z0-9][-\.a-z0-9]{1,61}[a-z0-9]))\.([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3}):[0-9]{1,5}/announce$" | grep -E "^(udp):[\/]{2}(([a-z]{1})|([a-z]{1}[a-z]{1})|([a-z]{1}[0-9]{1})|([0-9]{1}[a-z]{1})|([a-z0-9][-\.a-z0-9]{1,61}[a-z0-9]))\.([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3})/announce$" | sed "s/\/announce$/\:6969\/announce/g" | sort | uniq | awk "{ print $2 }"))
    trackerlist_unverified_nossl=($(cat ./trackerlist_*.tmp | tr -cd "[:alnum:]-./:_\n" | tr "A-Z" "a-z" | sed "s/\.php$//g" | grep -vE "^(http|udp|ws):[\/]{2}(([a-z]{1})|([a-z]{1}[a-z]{1})|([a-z]{1}[0-9]{1})|([0-9]{1}[a-z]{1})|([a-z0-9][-\.a-z0-9]{1,61}[a-z0-9]))\.([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3}):[0-9]{1,5}/announce$" | grep -E "^(http|udp|ws):[\/]{2}(([a-z]{1})|([a-z]{1}[a-z]{1})|([a-z]{1}[0-9]{1})|([0-9]{1}[a-z]{1})|([a-z0-9][-\.a-z0-9]{1,61}[a-z0-9]))\.([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3})/announce$" | sed "s/\/announce$/\:80\/announce/g" | sort | uniq | awk "{ print $2 }"))
    trackerlist_unverified_ssl=($(cat ./trackerlist_*.tmp | tr -cd "[:alnum:]-./:_\n" | tr "A-Z" "a-z" | sed "s/\.php$//g" | grep -vE "^(https|wss):[\/]{2}(([a-z]{1})|([a-z]{1}[a-z]{1})|([a-z]{1}[0-9]{1})|([0-9]{1}[a-z]{1})|([a-z0-9][-\.a-z0-9]{1,61}[a-z0-9]))\.([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3}):[0-9]{1,5}/announce$" | grep -E "^(https|wss):[\/]{2}(([a-z]{1})|([a-z]{1}[a-z]{1})|([a-z]{1}[0-9]{1})|([0-9]{1}[a-z]{1})|([a-z0-9][-\.a-z0-9]{1,61}[a-z0-9]))\.([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3})/announce$" | sed "s/\/announce$/\:443\/announce/g" | sort | uniq | awk "{ print $2 }"))
    trackerlist_data=($(echo ${trackerlist_verified[*]} ${trackerlist_unverified_udp[*]} ${trackerlist_unverified_nossl[*]} ${trackerlist_unverified_ssl[*]} | tr " " "\n" | sort | uniq | awk "{ print $2 }"))
}
# Output Data
function OutputData() {
    for trackerlist_data_task in "${!trackerlist_data[@]}"; do
        if [ "$(nmap $(echo ${trackerlist_data[$trackerlist_data_task]} | sed 's/http\:\/\///g;s/https\:\/\///g;s/udp\:\/\///g;s/ws\:\/\///g;s/wss\:\/\///g;s/\:.*//g') -p $(echo ${trackerlist_data[$trackerlist_data_task]} | sed 's/.*\://g;s/\/.*//g') | grep 'Host is up')" != "" ] || [ "$(nmap -sU $(echo ${trackerlist_data[$trackerlist_data_task]} | sed 's/http\:\/\///g;s/https\:\/\///g;s/udp\:\/\///g;s/ws\:\/\///g;s/wss\:\/\///g;s/\:.*//g') -p $(echo ${trackerlist_data[$trackerlist_data_task]} | sed 's/.*\://g;s/\/.*//g') | grep 'Host is up')" != "" ] || [ "$(nmap -6 $(echo ${trackerlist_data[$trackerlist_data_task]} | sed 's/http\:\/\///g;s/https\:\/\///g;s/udp\:\/\///g;s/ws\:\/\///g;s/wss\:\/\///g;s/\:.*//g') -p $(echo ${trackerlist_data[$trackerlist_data_task]} | sed 's/.*\://g;s/\/.*//g') | grep 'Host is up')" != "" ] || [ "$(nmap -6 -sU $(echo ${trackerlist_data[$trackerlist_data_task]} | sed 's/http\:\/\///g;s/https\:\/\///g;s/udp\:\/\///g;s/ws\:\/\///g;s/wss\:\/\///g;s/\:.*//g') -p $(echo ${trackerlist_data[$trackerlist_data_task]} | sed 's/.*\://g;s/\/.*//g') | grep 'Host is up')" != "" ]; then
            echo "${trackerlist_data[$trackerlist_data_task]}" >> ../trackerslist_combine.txt
            echo "${trackerlist_data[$trackerlist_data_task]}" >> ../trackerslist_tracker.txt
            if [ ! -f "../trackerslist_tracker_aria2.txt" ]; then
                echo -n "${trackerlist_data[$trackerlist_data_task]}" >> ../trackerslist_combine_aria2.txt
                echo -n "${trackerlist_data[$trackerlist_data_task]}" >> ../trackerslist_tracker_aria2.txt
            else
                echo -n ",${trackerlist_data[$trackerlist_data_task]}" >> ../trackerslist_combine_aria2.txt
                echo -n ",${trackerlist_data[$trackerlist_data_task]}" >> ../trackerslist_tracker_aria2.txt
            fi
        else
            echo "${trackerlist_data[$trackerlist_data_task]}" >> ../trackerslist_combine.txt
            echo "${trackerlist_data[$trackerlist_data_task]}" >> ../trackerslist_exclude.txt
            if [ ! -f "../trackerslist_exclude_aria2.txt" ]; then
                echo -n "${trackerlist_data[$trackerlist_data_task]}" >> ../trackerslist_combine_aria2.txt
                echo -n "${trackerlist_data[$trackerlist_data_task]}" >> ../trackerslist_exclude_aria2.txt
            else
                echo -n ",${trackerlist_data[$trackerlist_data_task]}" >> ../trackerslist_combine_aria2.txt
                echo -n ",${trackerlist_data[$trackerlist_data_task]}" >> ../trackerslist_exclude_aria2.txt
            fi
        fi
    done
    cd .. && rm -rf ./Temp
    exit 0
}

## Process
# Call GetData
GetData
# Call AnalyseData
AnalyseData
# Call OutputData
OutputData
