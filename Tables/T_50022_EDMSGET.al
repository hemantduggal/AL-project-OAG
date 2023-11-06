table 50022 EDMSGET
{
    DataClassification = ToBeClassified;
    Caption = 'Catering Lines';

    fields
    {
        field(1; Databaseid; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; DocumentID; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; documentTyp; code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(4; url; text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "File Name"; text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Databaseid, DocumentID)
        {
            Clustered = true;
        }
    }
    var
        purch: Record "Purchase Header";
}