pageextension 50035 PostedTransferShipmentsExt extends "Posted Transfer Shipments"
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