using { index.db.master,index.db.transaction } from '../db/datamodel';
service CatalogService@(path:'Catalogservice',requires:'authenticated-user') {
entity EmployeeSet @(restrict :[
                                {grant : ['READ'], to: 'Viewer',
                                    //row level security
                                    where :'bankName = $user.Bank'},
                                {grant : ['WRITE', 'DELETE'], to: 'Editor'}
                              ])  as projection on master.employees;
entity ProductSet as projection on master.product;
entity BusinessPartnerSet as projection on master.businesspartner;
entity AddressSet as projection on master.address;
@readonly
entity StatusCode as projection on master.StatusCode;
//@Capabilities:{ Deletable : false }
entity PurchaseOrderSet @(
                            restrict:[ {grant: ['READ'], to:'Viewer'},
                                       {grant: ['WRITE','DELETE'],  to:'Editor'} ],
                          odata.draft.enabled:true, 
                          Common.DefaultValuesFunction: 'getDefaultValue' ) as projection on transaction.purchaseorder
{
    *,
    case OVERALL_STATUS 
    when 'A' then 'Approved'
    when 'P' then 'Pending'
    when 'X' then 'Rejected'
    when 'D' then 'Delivered'
    else 'Unkonwn'
    end as OVERALLSTATUS: String(10),
    case OVERALL_STATUS 
    when 'A' then 3
    when 'P' then 2
    when 'X' then 1
    when 'D' then 3
    else 0
    end as colorCode:Integer
}
actions
{
    @cds.odata.bindingparameter.name: '_sideeffect'
    @Common.SideEffects:
    {
        TargetProperties:['_sideeffect/GROSS_AMOUNT']
    }
    action boost() returns PurchaseOrderSet
};
entity PurchaseItemsSet as projection on transaction.poitems;

function getLargestOrder() returns array of PurchaseOrderSet;
function getDefaultValue() returns PurchaseOrderSet;
}