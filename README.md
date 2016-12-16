# dbtools

Useful things for managing databases with projects and across different development platforms. Uses a 'config.ini' file to store settings for things like databases, system state (dev, testing, live, etc) and software version numbers.

## How To

1. Create a Database
* Use the command: ```db_transition```

2. Recreate a Database
* Rerun the command: ```db_transition```

3. Open A MySQL Console to the database.
* type **db_mstart**


## Scripts

* **db_createuser**: Creates a new user for the databases needed for this project. Also creates an empty database and assigns privileges for the user. NOTE: a .my.cnf file is created that stores your mysql password in clear text.
* **db_transition**: Creates a new database version from the old one. Assumes DBVER -1. Or, if ver1, just creates it. This is good for resetting a database to it's original form.
* **db_loadFileTo**: Loads sqlfile into the named database. NOTE: This ignores _dbsettings. Usage : db_loadFileTo dbname sqlfile
* **db_loadlastdump**:  Loads last full database dump, into database according to _dbsettings.
* **db_**: save dump. not copied in yet.


## Setup:
1. Cretae a config.conf file, to name your project's environment variable root. See below.
1. Create a config.ini file in your project's ROOT directory. Use the sample below to get started.
1. Create a directory ROOT/'db_common'. This can be changed in the config.ini file's DB.loaddir setting.
1. Create a directory ROOT/'db/ver1' and put a 'load.sql' file.

### ROOT/config.conf

Sets the CONFIGBASE variables, which is the name of your environment variables to use. For example:

    CONFIGBASE='MICROTEMP'


### ROOT/config.ini

Common settings used in this project. Useful if you are using several development languages and tools, since ini is generally readable by all.
```
version=1

appname=microtemp
environment=dev
; environment=test
; environment=live

[DB]
loaddir=db
user=microtemp
; NOTE: should be appname
password=***YOUR DB PASSWORD***

[SERVER]
; The server runs on different ports for different environments.
dev.host=localhost
dev.port=*****1
test.host=localhost
test.port=******2
live.host=MYHOST.COM
live.port=80
```


### load.sql
Put all your sql code to use when you initialize your database. I.e. structures and data if you care. The first
version of this can do whatever you want, but continuing versions should be updates only. I.e. Don't redeclare a table, but only alters.

This reads in the file db/verX/load_SYSTEM.sql. ex. db/ver2/load_CCOM.sql. Then, if it exists, the environment. ex. db/ver2/load_CCOM_test.sql. The best way to structure the load files is by structure changes, and then data. So, you create struct_updates.sql, loaded by both load_SYSTEM.sql files, then in each ENVIRONMENT file, load a different initdata_CCOM_ENVIRONMENT.sql file.

Typical starting files:

    ROOT/db/ver1/load_CCOM.sql
    ROOT/db/ver1/load_LCOM.sql
    ROOT/db/ver1/struct.sql
    ROOT/db/ver1/initdata_CCOM_dev.sql
    ROOT/db/ver1/initdata_CCOM_test.sql
    ROOT/db/ver1/initdata_CCOM_live.sql
    ROOT/db/ver1/initdata_LCOM_dev.sql
    ROOT/db/ver1/initdata_LCOM_test.sql
    ROOT/db/ver1/initdata_LCOM_live.sql


ROOT/db/ver1/load_CCOM.sql:

    source ./struct.sql
    source ./initdata_CCOM.sql


ROOT/db/ver1/load_LCOM.sql:

    source ./struct.sql
    source ./initdata_LCOM.sql
