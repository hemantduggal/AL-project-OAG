pageextension 50110 Saleorderarchive extends "Sales Order Archive"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("WHT Business Posting Group"; rec."WHT Business Posting Group")
            {
                ApplicationArea = All;
            }
        }
    }
}