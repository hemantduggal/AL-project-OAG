tableextension 50050 ItemChrg extends "Item Charge"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "WHT Product Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}