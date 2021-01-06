# musicschool_database

## Setup

Create database musicschool.

```bash
CREATE DATABASE musicschool
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Swedish_Sweden.1252'
    LC_CTYPE = 'Swedish_Sweden.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
```
This database is created with PostgresSQL.\n
Execute commands in the SQL file in this repo.\n
If desired a text file with the same info as the SQL file but with data as well exists.\n 
