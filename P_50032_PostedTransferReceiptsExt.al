pageextension 50032 PostedTransferReceiptsExt extends "Posted Transfer Receipts"
{
    layout
    {
        addafter("No.")
        {

        }
    }



    trigger OnOpenPage()
    begin

    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        TransshipmHeader: Record 5744;
}