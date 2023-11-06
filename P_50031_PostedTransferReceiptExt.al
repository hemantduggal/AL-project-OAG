pageextension 50031 PostedTransferReceiptExt extends "Posted Transfer Receipt"
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
}