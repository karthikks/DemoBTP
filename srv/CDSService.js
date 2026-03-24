const cds = require('@sap/cds')

module.exports = class CDSService extends cds.ApplicationService { init() {

  const { ProductSet, ItemsSet } = cds.entities('CDSService')

  this.before (['CREATE', 'UPDATE'], ProductSet, async (req) => {
    console.log('Before CREATE/UPDATE ProductSet', req.data)
  })
  this.after ('READ', ProductSet, async (productSet, req) => {
    //console.log('After READ ProductSet', productSet);
    let ids = productSet.map(f => f.ProductId);
   const openCount = await SELECT.from(ItemsSet).columns('ProductId',{func : 'count' , as:'sold'})
   .where({'ProductId':{in : ids}}).groupBy('ProductId');
    for (let index = 0; index < productSet.length; index++) {
      const element = productSet[index];
      const foundRecord = openCount.find(pc=>pc.ProductId === element.ProductId );
      element.totalCount = foundRecord ? foundRecord.sold : 0 ; 
    }
    
  })
  this.before (['CREATE', 'UPDATE'], ItemsSet, async (req) => {
    console.log('Before CREATE/UPDATE ItemsSet', req.data)
  })
  this.after ('READ', ItemsSet, async (itemsSet, req) => {
    console.log('After READ ItemsSet', itemsSet)
  })


  return super.init()
}}
