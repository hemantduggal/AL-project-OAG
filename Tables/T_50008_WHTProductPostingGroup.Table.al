table 50008 "WHT Product Posting Group"
{
    Caption = 'WHT Product Posting Group';
    DrillDownPageID = "WHT Product Posting Group";//50022;
    LookupPageID = 50022;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description)
        {
        }
    }
}

