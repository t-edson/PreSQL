PreSQL 2.4b
===========

Client and preprocessor for Oracle databases using the SQLPlus

PreSQL is a text preprocessor and a client for connecting to Oracle Databases. It works at the same way than the SQLPlus client.

It's a console program than can make a preprocessing before of sending the query to the Database.

The preprocessing is for implement some macro functionalities (For details, see the documentation).

The PreSQL client, is called using this syntax:

```
PreSQL @<query file> [output file]
```

For example, to send the query "report.sql":

```
> PreSQL @report.sql
```

The 'output file' is not necessary for sending a query to the Database.

If the 'output file' is specified, then the query file is "expanded" into the output file, but sent to the Database.

The connection string must be indicated at the beginning of the query file, in the form:

user/password@sid

