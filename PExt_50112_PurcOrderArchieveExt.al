pageextension 50112 PurchHeadarchive extends "Purchase Order Archive"
{
    layout
    {
        addafter("No.")
        {
            field("WHT Business Posting Group"; rec."WHT Business Posting Group")
            {
                ApplicationArea = All;
            }
            /* field("Actual Vendor No."; rec."Actual Vendor No.")
             {
                 ApplicationArea = All;
             }*/

        }
    }
}