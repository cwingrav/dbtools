# dbtools

Useful things for managing databases with projects and across different development platforms. Uses a 'config.ini' file to store settings for things like databases, system state (dev, testing, live, etc) and software version numbers.

## How To

1. Create a Database

2. Recreate a Database

3. Open A MySQL Console
* type **db_mstart**

## Scripts

* **db_createuser**: Creates a new user for the databases needed for this project. Also creates an empty database and assigns privileges for the user. NOTE: a .my.cnf file is created that stores your mysql password in clear text.
* **db_transition**: Creates a new database version from the old one. Assumes DBVER -1. Or, if ver1, just creates it. This is good for resetting a database to it's original form.
* **db_loadFileTo**: Loads sqlfile into the named database. NOTE: This ignores _dbsettings. Usage : db_loadFileTo dbname sqlfile
* **db_loadlastdump**:  Loads last full database dump, into database according to _dbsettings.
* **db_**: save dump. not copied in yet.


## Setup:
1. Create a config.ini file in your project's main directory.
1. Create a directory 'db' and put a file _dbsettings in it. 
1. Create a directory 'db/ver1' and put a 'load.sql' file.

### config.ini
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
dev.port=
test.host=localhost
test.port=
live.host=?
live.port=80
```

### _dbsettings

A file that creates variables to use with the scripts in this package. It reads from the config.ini file.
``` tcsh
#!/bin/bash

# read from ini file
export CONFIGLOC="../config.ini"

# Override config.ini settings with ENV variables.
if  [ -n "$MICROTEMP_ENV" ];  then
ENVIRONMENT=$MICROTEMP_ENV
fi

APPNAME=`eval "php -r 'echo parse_ini_file("'"'$CONFIGLOC'"'")["'"'"appname"'"'"]"";'"`
ENVIRONMENT=`eval "php -r 'echo parse_ini_file("'"'$CONFIGLOC'"'")["'"'"environment"'"'"]"";'"`
export DBVER=`eval "php -r 'echo parse_ini_file("'"'$CONFIGLOC'"'")["'"'"version"'"'"]"";'"`
export DBUSER=`eval "php -r 'echo parse_ini_file("'"'$CONFIGLOC'"'",true)["'"'"DB"'"'"]["'"'"user"'"'"]"";'"`

ComputeDBName() {
    appname="$1";
    environment="$2";
    dbver="$3";
    retval="cwingrav_"$appname"_"$environment"_$dbver";
    echo $retval
        return 0
}

export DBNAME=$(ComputeDBName $APPNAME $ENVIRONMENT $DBVER)
```

### load.sql
Put all your sql code to use when you initialize your database. I.e. structures and data if you care.

NOTE: I generally separate structure and data into separate files and put two lines in this file: 
* source ../db/ver1/struct.sql
* source ../db/ver1/initdata.sql
