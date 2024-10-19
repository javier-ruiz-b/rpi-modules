# Raspberry Pi Modules

A collection of files and scripts to easily install software (probably adapted
 to my needs).

Feel free to use and improve what you see :)


## Module structure

Each [module](module/) is a collection of files that are placed in the root
 dir ( / ) with a few exceptions:

* **configpaths.txt**: Contains a list of paths (with wildcards) where 
 configuration files are stored
* **build.d/10-script.sh**: Scripts in this run are executed after the files
 are copied to the to the root directory


## Install module(s)

Run `bash install-modules.sh [list of modules]`