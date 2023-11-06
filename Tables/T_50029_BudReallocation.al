table 50029 reallocationBudet
{
    DataClassification = ToBeClassified;
    Caption = 'Reaalocation Journal';
    fields
    {
        field(1; "line No."; Integer)
        {
            DataClassification = ToBeClassified;
            // AutoIncrement = true;
        }
        field(2; BudgetName; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "OAG Budget Header"."Budget Name";
            trigger OnValidate()
            var
                bud: Record "OAG Budget Header";

            begin
                bud.Reset();
                bud.SetRange("Budget Name", Rec.BudgetName);
                if bud.FindFirst() then begin
                    rec.BudgetStatus := bud.BudgetStatus;
                end;
            end;
        }
        field(3; BudgetStatus; Option)
        {
            OptionMembers = "Approved Budget","Revised Budget";
            DataClassification = ToBeClassified;
        }
        field(4; glacc; Code[30])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                line: Record BudgetLines;
            begin
                line.Reset();
                line.SetRange("Budget Name", Rec.BudgetName);
                line.SetRange(code, Rec.glacc);
                if line.FindFirst() then begin
                    rec.amount := line.annualbudget;
                    rec.Modify();
                end;
            end;
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
        field(16; newglacc; code[30])
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
                        rec.newglacc := line.code;
            end;
        }
    }
    keys
    {
        key(key1; "line No.")
        {
            Clustered = true;
        }
    }
}