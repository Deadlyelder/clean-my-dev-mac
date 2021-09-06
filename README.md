# clean-my-dev-mac
A simple bash script that cleans up macOS storage, especially development related items.

## What It Does:
-   Prompt for password if the script is not ran as root (some cleanups will need root access)
-   Empty the trash
-   Deletes system logs
-   Updates and cleans Homebrew
-   Clean ruby
-   Clean CocoaPod cache
-   Delete old Xcode simulators 
-   Removes docker volumes
-   Clean the `node_modules` that are older thn 5 months
-   Purges memory

## WARNING

The script is specifically written for my system, therefore it might clean up things that you do not want and even break your development enviornment !!

## Usage:
-   Read the code and comment out the options that you dont want to be cleaned out
-   Be care as the cleaning up of `node_modules` checks for all folders within the directory in which the script is executed. Suggestion is to run the script in your code-base folder.

### Running

```
bash sweep_it.sh
```

## To-Do
- [ ] Code to clean up local git merged branches
- [ ] Docker images and containers cleanup
- [ ] Cleanup other things that hog the storage
