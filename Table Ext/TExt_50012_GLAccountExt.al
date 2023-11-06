tableextension 50012 GLAccountExt extends "G/L Account"
{
    fields
    {
        field(50002; "G/L Budget"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'G/L Budget';
        }
        field(50000; "WHT Business Posting Group"; Code[20])
        {
            Caption = 'WHT Business Posting Group';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "WHT Business Posting Group";
        }
        field(50001; "WHT Product Posting Group"; Code[20])
        {
            Caption = 'WHT Product Posting Group';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "WHT Product Posting Group";
        }

    }
}