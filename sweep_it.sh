#!/bin/bash
SECONDS=0

# Verify if root else escalate
amiroot=$(sudo -n uptime 2>&1| grep -c "load")
if [ "$amiroot" -eq 0 ]
then
    printf "Sweeping needs root access. Please enter your password...\n"
    sudo -v
    printf "\n"
fi

## First empty the trash
printf "Emptying the trash...\n"
sudo rm -rfv ~/.Trash > /dev/null 2>&1
sudo rm -rfv /Volumes/*/.Trashes > /dev/null 2>&1

## Clean the logs (Be careful, only do if you dont need them anymore)
printf "Emptying the system logs, including diagnostic reports...\n"
sudo rm -rfv /private/var/log/*  > /dev/null 2>&1
sudo rm -rfv /Library/Logs/DiagnosticReports/* > /dev/null 2>&1

## Clean the Homebrew
printf "Cleaning up the Homebrew...\n"
brew update > /dev/null 2>&1
brew upgrade > /dev/null 2>&1
brew cleanup > /dev/null 2>&1

## Clean up Ruby
printf "Cleaning Ruby...\n"
gem cleanup > /dev/null 2>&1

# Xcode development stuffs
## Clean CocoaPod caches 
printf "Cleaning CocoaPod caches...\n"
rm -rf "${HOME}/Library/Caches/CocoaPods" 

## Delete old Xcode simulators
printf "Cleaning old Xcode simulators...\n"
xcrun simctl delete unavailable

## Clean various logs, archives and derived data
printf "Cleaning logs, archives and derived data folder...\n"
rm -rf ~/Library/Developer/Xcode/Archives
rm -rf ~/Library/Developer/Xcode/DerivedData
rm -rf ~/Library/Developer/Xcode/iOS Device Logs/

# Docker related cleanups
## Remove unused local volumes
printf "Cleaning unused local volumes...\n"
docker volume prune -f > /dev/null 2>&1

# Git based
## The following goes inside all the folders of the working dir
## and cleans the merged branches from the git projects
#printf "Removing all merged branches from all folders in this dir...\n"
#for d in */; do 
#    cd $d; 
#    echo WORKING ON $d; 
#    git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d; cd ..; 
#done

# Javascript cleanups
## Clean up the node_modules that are around
printf "Cleaning all node_modules folder that are older than 5 months...\n"
find . -name "node_modules" -type d -mtime +150 | xargs rm -rf 

## Cleaning up memory (purge)
printf "Purging the memory...\n"
sudo purge > /dev/null 2>&1

## Fin
timetaken="$((SECONDS / 3600)) Hours $(((SECONDS / 60) % 60)) Minutes $((SECONDS % 60)) seconds"

printf "Overall cleaning took %s time \n" "$timetaken"
