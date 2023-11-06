table 50023 BudgetLines
{
    DataClassification = ToBeClassified;
    Caption = 'Budget Lines';

    fields
    {
        field(1; BudgetStatus; Option)
        {
            OptionMembers = "Approved Budget","Revised Budget";
            DataClassification = ToBeClassified;
        }
        field(2; "Budget name"; code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "OAG Budget Header"."Budget Name" WHERE(BudgetStatus = FIELD(BudgetStatus));
        }
        field(3; code; code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Name; text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(5; annualbudget; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = sum("G/L Budget Entry".Amount where("Budget Name" = field("Budget name")));
            Editable = false;
        }
        field(6; Q1; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Q2; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Q3; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Q4; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; supplementry; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; warrents; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; datefilter; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Q1encum; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; Q2encum; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Q3encum; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Q4encum; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; year; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(18; Q1paym; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; Q2paym; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; Q3paym; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; Q4paym; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; totalencum; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; totalpay; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(key1; code, "Budget name")
        {
            Clustered = true;
        }
        key(key2; "Budget name", code)
        { }
    }
    var
        line: Record "Prod. Order Line";
}