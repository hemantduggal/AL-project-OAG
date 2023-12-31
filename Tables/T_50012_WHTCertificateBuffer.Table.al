table 50012 "WHT Certificate Buffer"
{
    Caption = 'WHT Certificate Buffer';

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = SystemMetadata;
        }
        field(2; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Vendor No.", "Document No.")
        {
        }
    }

    fieldgroups
    {
    }
}

