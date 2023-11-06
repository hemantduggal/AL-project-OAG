tableextension 50048 ReturnShipHead extends "Return Shipment Header"
{
    fields
    {
        // Add changes to table fields here
        field(50009; "WHT Business Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

    }

    var
        myInt: Integer;
}