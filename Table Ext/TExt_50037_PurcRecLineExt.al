tableextension 50037 PurRecptLineExt extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50012; "WHT Business Posting Group"; Code[20])
        {
            Caption = 'WHT Business Posting Group';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "WHT Business Posting Group";
        }
        field(50013; "WHT Product Posting Group"; Code[20])
        {
            Caption = 'WHT Product Posting Group';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "WHT Product Posting Group";
        }
        field(50014; "WHT Absorb Base"; Decimal)
        {
            Caption = 'WHT Absorb Base';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
        }
    }
}