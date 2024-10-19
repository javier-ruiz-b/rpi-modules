# Raspberry Pi modules

A collection of files and scripts to install easily software (probably adapted 
 to my needs).

Feel free to use and improve what you see :)


## Module Structure

Each [module](module/) is a collection of files that will be copied to the root
 dir ( / ) with a few exceptions:

* **configpaths.txt**: Contains a list of paths (with wildcards) where configuration
 files are saved
* **build.d/10-script.sh**: scripts in this run are executed after copying the files 
 to the root dir


## Install module(s)

Run `bash install-modules.sh [list of modules]`