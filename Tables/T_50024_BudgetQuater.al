table 50024 BudgetQuater
{
    DataClassification = ToBeClassified;
    Caption = 'Budget Quater';
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; BudgetName; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; BudgetStatus; Option)
        {
            OptionMembers = "Approved Budget","Revised Budget";
            DataClassification = ToBeClassified;
        }
        field(4; glacc; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Is_Supplementry; Option)
        {
            OptionMembers = ,Y,N;
            DataClassification = ToBeClassified;
        }
        field(6; Quater; Option)
        {
            OptionMembers = ,Q1,Q2,Q3,Q4;
            DataClassification = ToBeClassified;
        }
        field(7; amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Description; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; programcode; code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; directorate; code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; projectfilter; code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12; budgetoutput; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; auditentities; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; funding; code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(15; budget5; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; isreallocated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; auditsegment; code[30])
        {

        }
        field(18; budgetcategory; Code[30])
        {

        }
    }
    keys
    {
        key(key1; "Entry No.")
        {
            Clustered = true;
        }
    }
}