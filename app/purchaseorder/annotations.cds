using CatalogService as service from '../../srv/CatalogService';

annotate service.PurchaseOrderSet with @(

    //Add fields to the screen for filtering the data
    UI.SelectionFields: [
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        GROSS_AMOUNT,
        OVERALL_STATUS
    ],
    UI.LineItem:[
  {
      $Type : 'UI.DataField',
      Value : PO_ID,
  },
  {
      $Type : 'UI.DataField',
      Value : NOTE,
  },
  {
      $Type : 'UI.DataField',
      Value : PARTNER_GUID.COMPANY_NAME,
  },
  {
      $Type : 'UI.DataField',
      Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
  },
  {
      $Type : 'UI.DataField',
      Value : GROSS_AMOUNT,
  },
  {
      $Type : 'UI.DataField',
      Value : OVERALL_STATUS,
      Criticality:colorCode,
  },
  {
      $Type : 'UI.DataFieldForAction',
      Action : 'CatalogService.boost',
      Label:'Boost',
      Inline:true
  },
    ],
UI.HeaderInfo:{
 TypeName:'Purchase Order',
TypeNamePlural:'Purchcase Orders',
Title:{Value:PO_ID},
Description:{Value:PARTNER_GUID.COMPANY_NAME},
ImageUrl:'https://substackcdn.com/image/fetch/$s_!1XDp!,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fb162f2d8-7878-4f8c-9b3f-6184293024dc_1000x1000.jpeg' 
    },
 UI.Facets:[
    {
        $Type : 'UI.CollectionFacet',
        Label: 'General Information',
        Facets:[
{
     Label:'Basic Info',
    $Type : 'UI.ReferenceFacet',
    Target : '@UI.Identification',
},
{
     Label:'Pricing Details',
    $Type : 'UI.ReferenceFacet',
    Target : '@UI.FieldGroup#Fieldgrp1',
},
{
    Label:'Additional Data',
    $Type : 'UI.ReferenceFacet',
    Target : '@UI.FieldGroup#Fieldgrp2',
},
        ]
    },
    {
        $Type : 'UI.ReferenceFacet',
        Label: 'Items',
        Target:'Items/@UI.LineItem'
    }
 ],
 UI.Identification:
 [
    {
        $Type : 'UI.DataField',
        Value : PO_ID,
    },

    {
        $Type : 'UI.DataField',
        Value : PARTNER_GUID_NODE_KEY,
    },
    {
        $Type : 'UI.DataField',
        Value : OVERALL_STATUS,
    }
 ],
 UI.FieldGroup #Fieldgrp1:{
   
    Data:[
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT,
        },

    ]
 } ,
 UI.FieldGroup #Fieldgrp2:
 {
    Data:[
        {
            $Type : 'UI.DataField',
            Value : OVERALL_STATUS,
        },
        {
            $Type : 'UI.DataField',
            Value : LIFECYCLE_STATUS,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        },
    ]
 }
);
annotate service.PurchaseItemsSet with @(
    UI.HeaderInfo:
    {
        TypeName:'PoItem',
        TypeNamePlural:'Purchase Order Items',
        Title:{ Value: PO_ITEM_POS},
        Description:{Value: PRODUCT_GUID.DESCRIPTION}
    },
UI.LineItem:[
 {
     $Type : 'UI.DataField',
     Value : PO_ITEM_POS,
 },
 {
     $Type : 'UI.DataField',
     Value : PRODUCT_GUID_NODE_KEY,
 },
 {
     $Type : 'UI.DataField',
     Value : GROSS_AMOUNT,
 },
 {
     $Type : 'UI.DataField',
     Value : NET_AMOUNT,
 },
 {
     $Type : 'UI.DataField',
     Value : TAX_AMOUNT,
 },
],
UI.Facets:[
    {
        $Type : 'UI.ReferenceFacet',
        Label: 'Item Details',
        Target: '@UI.Identification'
    }
],
UI.Identification:
[
    {
        $Type : 'UI.DataField',
        Value : PO_ITEM_POS,
    },
    {
        $Type : 'UI.DataField',
        Value : PRODUCT_GUID_NODE_KEY,
    },
    {
        $Type : 'UI.DataField',
        Value : GROSS_AMOUNT,
    },
    {
        $Type : 'UI.DataField',
        Value : NET_AMOUNT,
    },
    {
        $Type : 'UI.DataField',
        Value : TAX_AMOUNT,
    },
    {
        $Type : 'UI.DataField',
        Value : CURRENCY_code,
    },
]
); 

annotate service.PurchaseOrderSet with {
@(
    Common.Text:OVERALLSTATUS,
    Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'StatusCode',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : OVERALL_STATUS,
                ValueListProperty : 'Code',
            },
        ],
        Label : 'Status',
    },
    Common.ValueListWithFixedValues : true,
)
OVERALL_STATUS;
@Common.Text:NOTE
PO_ID;
@Common.Text :PARTNER_GUID.COMPANY_NAME
@Common.TextArrangement:#TextOnly
@ValueList.entity:service.BusinessPartnerSet
PARTNER_GUID;
};

annotate service.PurchaseItemsSet with{
@Common.Text: PRODUCT_GUID.DESCRIPTION
@ValueList.entity:service.ProductSet
PRODUCT_GUID;
};
@cds.odata.valuelist
annotate service.ProductSet with @(
    UI.Identification:
    [
        {
            $Type : 'UI.DataField',
            Value : DESCRIPTION,
        },
    ]
);
@cds.odata.valuelist
annotate service.BusinessPartnerSet with @(
    UI.Identification:
    [
        {
            $Type : 'UI.DataField',
            Value : COMPANY_NAME,
        },
    ]
);






annotate service.StatusCode with {
    Code @(
        Common.Text : value,
        Common.Text.@UI.TextArrangement : #TextLast,
    )
};

