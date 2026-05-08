#! /bin/bash

#Assumptions:
# you've already run 'pub global activate yt' to activate the command line utility
# you've already run 'yt authorize' and completed the steps for authorization.
# you have the 'jq' utility from - https://stedolan.github.io/jq/download/ - installed

#get the json playlists list response and parse the json with jq
echo 'Playlist: PLjxrf2q8roU3BopVma21AnrhDD_12Bu1w'
yt playlists list --part snippet,contentDetails --id PLjxrf2q8roU3BopVma21AnrhDD_12Bu1w | \
	jq -r '.items[] | "title: " + .snippet.title + "\nthumbnail: " + .snippet.thumbnails.default.url'

echo "\nChannel: UCwXdFgeE9KYzlDdR7TG9cMw"
#get the json channels list response and parse the json with jq
yt channels list --part snippet,contentDetails --id UCwXdFgeE9KYzlDdR7TG9cMw | \
	jq -r '.items[] | "title: " + .snippet.title + "\nthumbnail: " + .snippet.thumbnails.default.url + "\nrelatedPlaylists: " + .contentDetails.relatedPlaylists.uploads'
