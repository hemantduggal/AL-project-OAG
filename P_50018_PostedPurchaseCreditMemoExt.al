pageextension 50018 PostedPurchaseCreditMemoExt extends "Posted Purchase Credit Memo"
{
    layout
    {
        addafter("Buy-from Vendor Name")
        {
            field("Vendor Type"; Rec."Vendor Type")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addafter("No. Printed")
        {
            field("WHT Business Posting Group"; rec."WHT Business Posting Group")
            {
                ApplicationArea = all;
            }
            /* field("Actual Vendor No."; rec."Actual Vendor No.")
             {
                 ApplicationArea = all;
             }*/
        }
    }

    trigger OnOpenPage()
    begin

    end;

    var
        UserSetup: Record 91;
}