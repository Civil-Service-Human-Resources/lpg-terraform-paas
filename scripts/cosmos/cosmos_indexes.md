# Indexes for Cosmos 3.6

Cosmos was using 3.2 and did not allow compund indexes, the Learning Locker XAPI worked with this without issues. But now that Cosmos 3.6 allows some compound indexes now, some are *required* to be in place by Learning Locker XAPI.

These are the queries that have been identified as required, and need to be implemented in a new Cosmos 3.6 instance before it can be used.

Run the following commands in a MongoDb client (like Robo3T)

```bash
db.statements.createIndex({ "statement.actor": 1, "timestamp": -1 }, { background: true });

db.statements.createIndex({ "stored": -1, "_id": -1 }, { background: true });
```

You may need to reindex the collection if the above commands do not work:

```bash
 db.getCollection(‘statements’).reIndex();
 ```

## Robo3T Mongo Client

This can be found here https://robomongo.org/

Download and install following the instructions.

To connect to Cosmos you will need the following:
 * CosmosDb address
 * Port number
 * Username
 * Password

These are all available from the Azure Portal.

When creating the connection fill in these details on the Connection and Authentication tabs. 
![Connection dialog box](images/connection.png?raw=true "Connection dialog")
![Authentication dialog box](images/authentication.png?raw=true "Authentication dialog")
You then need to click on the "TLS" tab and ensure that it is checked and the Authentication Method is set to Self-signed Certificate.
![TLS dialog box](images/tls.png?raw=true "TLS dialog")

Once connected, expand out the collections and right click statements and select "View Documents"
![View Documents dialog box](images/preview.png?raw=true "Selecting view documents")

This will open a window where you can now run mongo commands:
![Editor dialog box](images/editor.png?raw=true "Query Editor")