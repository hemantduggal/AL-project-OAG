tableextension 50052 RetRcptLine extends "Return Receipt Line"
{
    fields
    {
        // Add changes to table fields here

        field(50012; "WHT Business Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "WHT Product Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "WHT Absorb Base"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}