tableextension 50035 salescrmemoheadExt extends "Sales Cr.Memo Header"
{
    fields
    {
        field(50009; "WHT Business Posting Group"; Code[20])
        {
            Caption = 'WHT Business Posting Group';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "WHT Business Posting Group";
        }
    }
}