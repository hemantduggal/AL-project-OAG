table 50025 HCMMaster
{
    DataClassification = ToBeClassified;
    Caption = 'HCM Master';
    fields
    {
        field(1; "userID"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(2; HCM_Username; code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; passwrd; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; userID)
        {
        }
    }
}