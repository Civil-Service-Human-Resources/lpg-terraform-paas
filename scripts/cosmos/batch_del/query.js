// Will iterate over dates to run query in batches of date ranges using list of modules
db = db.getSiblingDB('admin')

dates.forEach(function (dateGtLt) {
  printjson(db.statements.count({ $and: [
    {'timestamp': { $gt: dateGtLt.gt }},
    {'timestamp': { $lt: dateGtLt.lt }},
    { 'statement.verb.id': { $eq: 'http://adlnet.gov/expapi/verbs/experienced' }},
    { 'statement.object.id': { $in: modules } }
  ]}))
})
