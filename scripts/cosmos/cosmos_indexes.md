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
