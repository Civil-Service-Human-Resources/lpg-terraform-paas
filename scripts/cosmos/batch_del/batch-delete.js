// Will iterate over dates to run query in batches of date ranges using list of modules
db = db.getSiblingDB('admin')

dates.forEach(function (dateGtLt) {
  let start = new Date();
  print('Started deleting for date ' + dateGtLt.gt)
  let query = { $and: [
    {'timestamp': { $gt: dateGtLt.gt }},
    {'timestamp': { $lt: dateGtLt.lt }},
    { 'statement.verb.id': { $eq: 'http://adlnet.gov/expapi/verbs/experienced' }},
    { 'statement.object.id': { $in: modules } }
  ]}

  batchDeleteFromCollection(query, 1000, 20)

  let end = new Date();
  let milliseconds = end - start;
  print('Finished deleting for date ' + dateGtLt.gt + ' in ' + milliseconds)
})

function batchDeleteFromCollection( query, batchSize, pauseMS){
  batchBucket = new Array();
  totalToProcess = db.statements.find(query,{_id:1}).count();
  if (totalToProcess < batchSize){ batchSize = totalToProcess};
  currentCount = 0;
  print("Processed "+currentCount+"/"+totalToProcess+"...");
  db.statements.find(query).addOption(DBQuery.Option.noTimeout).forEach(function(doc){
      batchBucket.push(doc._id);
      if ( batchBucket.length >= batchSize){
        let start = new Date();

        db.statements.remove({_id : { "$in" : batchBucket}});
        currentCount += batchBucket.length;
        batchBucket = [];
        sleep (pauseMS);

        let end = new Date();
        let milliseconds = end - start;
        print("Processed "+currentCount+"/"+totalToProcess+" in " + milliseconds +" ...");
      }
  })
  print("Completed");
}

