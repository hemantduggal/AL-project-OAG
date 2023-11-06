tableextension 50051 RetRecHead1 extends "Return Receipt Header"
{
    fields
    {
        field(50009; "WHT Business Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}