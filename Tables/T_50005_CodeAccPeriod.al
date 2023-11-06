table 50005 CodeType_AccountingPeriod
{
    //DataClassification = ToBeClassified;
    LookupPageId = "Code Type";
    Caption = 'CodeType_AccountingPeriod';
    fields
    {
        field(1; "S.No."; Integer)//code[20])
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Dimension Financial Year"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(Key1; "S.No.", "Dimension Financial Year")
        {
            Clustered = true;
        }
    }
}