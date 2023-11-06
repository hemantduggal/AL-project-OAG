table 50026 AnnualBudget
{
    DataClassification = ToBeClassified;
    Caption = 'Budget Annual';
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
        field(5; amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Description; text[100])
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
        field(16; newglacc; Code[30])
        {
            DataClassification = ToBeClassified;
            trigger OnLookup()
            var
                line: Record BudgetLines;
            begin
                line.Reset();
                line.SetRange("Budget name", rec.BudgetName);
                if line.FindFirst() then
                    if page.RunModal(page::oagbudgetsubform, line) = Action::LookupOK then
                        rec.glacc := line.code;
            end;
        }
        field(17; reallocated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; auditsegment; code[30])
        {

        }
        field(19; budgetcategory; Code[30])
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