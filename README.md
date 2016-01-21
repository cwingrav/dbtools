# dbtools

Useful things for managing databases with projects and across different development platforms. Uses a 'config.ini' file to store settings for things like databases, system state (dev, testing, live, etc) and software version numbers.

## To use:
# Create a config.ini file in your project's main directory.
# Create a director 'db' and put a file _dbsettings.tcsh in it. 
# Create a directory 'db/ver1' and put a 'load.sql' file.

## config.ini
Common settings used in this project. Useful if you are using several development languages and tools, since ini is generally readable by all.
```
version=1

appname=microtemp
environment=dev
; env=test
; env=live

[DB]
user=microtemp
; NOTE: should be appname
password=

[SERVER]
dev.host=localhost
dev.port=9301
test.host=localhost
test.port=9302
live.host=?
live.port=80
```

## _dbsettings.tcsh

A file that creates variables to use with the scripts in this package. It reads from the config.ini file.
``` tcsh
#!/bin/tcsh 
# NOTE: use db_transition to reload the database
setenv CONFIGLOC "../config.ini"
set    APPNAME=`eval "php -r 'echo parse_ini_file("'"'$CONFIGLOC'"'")["'"'"appname"'"'"]"";'"`
set    ENVIRONMENT=`eval "php -r 'echo parse_ini_file("'"'$CONFIGLOC'"'")["'"'"environment"'"'"]"";'"`
setenv DBVER       `eval "php -r 'echo parse_ini_file("'"'$CONFIGLOC'"'")["'"'"version"'"'"]"";'"`
setenv DBUSER      `eval "php -r 'echo parse_ini_file("'"'$CONFIGLOC'"'",true)["'"'"DB"'"'"]["'"'"user"'"'"]"";'"`
setenv DBNAME $APPNAME"_"$ENVIRONMENT"_$DBVER"
```

## load.sql
Put all your sql code to use when you initialize your database. I.e. structures and data if you care.

NOTE: I generally separate structure and data into separate files and put two lines in this file: 
* source ../db/ver1/struct.sql
* source ../db/ver1/initdata.sql
