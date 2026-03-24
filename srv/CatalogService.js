const cds = require('@sap/cds')
const { where } = require('@sap/cds/lib/ql/cds-ql')

module.exports = class CatalogService extends cds.ApplicationService { init() {

  const { EmployeeSet, PurchaseOrderSet, PurchaseItemsSet } = cds.entities('CatalogService')

  this.before (['CREATE', 'UPDATE'], EmployeeSet, async (req) => {
    console.log('Before CREATE/UPDATE EmployeeSet', req.data)
    let salaryAmount = parseFloat(req.data.salaryAmount);
    if(salaryAmount > 1000000)
    {
      req.error(500,"Hey error in updating salary");
    }
  })
  this.after ('READ', EmployeeSet, async (employeeSet, req) => {
    console.log('After READ EmployeeSet', employeeSet)
  })
  this.before (['CREATE', 'UPDATE'], PurchaseOrderSet, async (req) => {
    console.log('Before CREATE/UPDATE PurchaseOrderSet', req.data)
  })
  this.after ('READ', PurchaseOrderSet, async (purchaseOrderSet, req) => {
    console.log('After READ PurchaseOrderSet', purchaseOrderSet)
    for (let index = 0; index < purchaseOrderSet.length; index++) {
      const element = purchaseOrderSet[index];
      if (!element.Note) {
         element.NOTE = '(Not Found)';
      }
    }
  })
  this.before (['CREATE', 'UPDATE'], PurchaseItemsSet, async (req) => {
    console.log('Before CREATE/UPDATE PurchaseItemsSet', req.data)
  })
  this.after ('READ', PurchaseItemsSet, async (purchaseItemsSet, req) => {
    console.log('After READ PurchaseItemsSet', purchaseItemsSet)
  })
  this.on('getDefaultValue', async (req,res)=>{
return{
  OVERALL_STATUS:'N', 
  LIFECYCLE_STATUS : 'N'
} });
 //generic handler to support my function implementation - always returns data, GET
  this.on('getLargestOrder', async (req,res) => {
    try {

      const tx = cds.tx(req);

      //use CDS QL to make call to DB  - SELECT * UP TO 3 ROWS FROM POs ORDER BY GROSS_AMOUNT descending
      const reply = await tx.read(PurchaseOrderSet).orderBy({
        'GROSS_AMOUNT': 'desc'
      }).limit(3);

      return reply;

    } catch (error) {
      req.error(500, "Some error occurred : " + error.toString())
    }
  });
  this.on('boost', async(req)=>
  {
       try{
        const pKey = req.params[0];
        const tx = cds.tx(req);
        await tx.update(PurchaseOrderSet).with(
          {
            GROSS_AMOUNT : { '+=' : 3000 },
            NOTE:'Updated'
          }).where(pKey);
          return await tx.read(PurchaseOrderSet).where(pKey);
       }
       catch(error)
       {
        req.error(500,"Hello erorr" + error.toString());
       }
  }
)
  return super.init()
  }}
