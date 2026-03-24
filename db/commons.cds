namespace index.common;
using { Currency  } from '@sap/cds/common';

type Guid : String(32);
type Gender: String(1) enum
{
    male = 'M';
    female = 'F';
    unknown = 'U';
}
type AmountT : Decimal(10,2) @(
    Semantic.amount.currencyCode:'CURRENCY_code'
);
aspect amount
{
    CURRENCY : Currency ;
    GROSS_AMOUNT: AmountT @(title: '{i18n>GROSS_AMOUNT}');
    NET_AMOUNT:AmountT @(title: '{i18n>NET_AMOUNT}');
    TAX_AMOUNT:AmountT @(title: '{i18n>TAX_AMOUNT}');
}
type PhoneNumber:String(30);
type Email : String(250);


