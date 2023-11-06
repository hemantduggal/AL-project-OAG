pageextension 50109 SalesreceivableSetup extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Allow Document Deletion Before")
        {
            field("Print WHT on Credit Memo"; rec."Print WHT on Credit Memo")
            {
                ApplicationArea = all;
            }
            field("Print Dialog"; rec."Print Dialog")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}