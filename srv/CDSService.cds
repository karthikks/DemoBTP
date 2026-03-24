using { index.cds } from '../db/CDSviews';
service CDSService @(path:'CDSService') {
entity ProductSet as projection on cds.CDSViews.ProdcuctView
{
*,
virtual totalCount: Int16
};
entity ItemsSet as projection on cds.CDSViews.ItemView;
}
