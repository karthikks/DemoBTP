const cds = require('@sap/cds')

module.exports = class MyService extends cds.ApplicationService { init() {

  this.on ('demo', async (req) => {
    console.log('On demo', req.data)
    let myName = req.data.name;
    return `Welcome to CAP Server, Hello ${myName}`
  })
  return super.init()
}}
