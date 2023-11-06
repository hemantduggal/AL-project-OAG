tableextension 50014 AccPeriodExt extends "Accounting Period"
{
    fields
    {
        field(50000; "Code Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = CodeType_AccountingPeriod."Dimension Financial Year";//"S.No.";
        }
        field(50001; "Quarter"; Option)
        {
            OptionMembers = ,Q1,Q2,Q3,Q4;
            DataClassification = ToBeClassified;
        }
    }
    var
        myInt: Integer;
}