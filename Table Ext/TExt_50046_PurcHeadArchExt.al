tableextension 50046 PurchHeadArchive extends "Purchase Header Archive"
{

    fields
    {
        field(50013; "WHT Business Posting Group"; Code[20])
        {
            Caption = 'WHT Business Posting Group';
            DataClassification = ToBeClassified;
            Description = 'PRU_RPG WHT_0.1';
            TableRelation = "WHT Business Posting Group";
        }
    }

}

