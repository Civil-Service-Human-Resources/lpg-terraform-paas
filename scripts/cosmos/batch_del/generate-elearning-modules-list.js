const fs = require('fs')

if (!process.argv.length === 3 || !process.argv[2]) {
  console.log('usage: node generate-elearning-modules-list.js courses.json')
  return process.exit(1)
}

let coursesJsonString = fs.readFileSync(process.argv[2])
let courses = JSON.parse(coursesJsonString)

let eLearningModules = []

if (courses && courses.hits && courses.hits.hits) {
  courses.hits.hits.forEach(function (course) {
    if (course._source && course._source.modules) {
      course._source.modules.forEach(function (courseModule) {
        if (courseModule.type === 'elearning') {
          eLearningModules.push({ id: courseModule.id, title: courseModule.title })
        }
      })
    }
  })
} else {
  console.log('Invalid JSON - expecting courses JSON from ElasticSearch')
  return process.exit(1)
}

// list of elearning modules
console.log('var modules = [')
eLearningModules.forEach(function (eLearningModule) {
  console.log(`  'http://cslearning.gov.uk/modules/${eLearningModule.id}', // ${eLearningModule.title}`)
})
console.log(']')