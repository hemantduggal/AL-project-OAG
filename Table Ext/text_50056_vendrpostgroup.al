tableextension 50058 vendposGroup extends "Vendor Posting Group"
{
    fields
    {
        field(50000; "WHT VAT"; Code[30])
        {
            Caption = 'WHT VAT';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
            Description = 'Lomesh_0.1';
            trigger OnValidate()
            var
                loc: Record Location;
            begin

            end;
        }
    }
}