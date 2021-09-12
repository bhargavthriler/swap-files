## Description

The main purpose of this script is to swap between config files quickly, instead of using `mv` 3 times.
I mainly use this for switch between different `.vimrc` and `.gitconfig` config files.

Use this script to swap files.
<br>
Currently supports only 2 files to swap names

### **USAGE**

Use the following options to swap file1 to file2 and vice versa
* -f \<file1> \<file2> 
* -c \<config file>
* -C -h config file help
* -h display this message

### **Config file usage**
Config file should be named .conf_rename or conf_rename, 
<br>
I used this so that it doesn't conflict with config files
<br>
content's of config file
<br>
line1: name of file1
<br>
line2: name of file2

