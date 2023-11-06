table 50021 "OAG Budget Header"
{
    DataClassification = ToBeClassified;
    Caption = 'Budget Header';

    fields
    {
        field(2; "Budget Name"; code[30])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                BudgetType := 'Click Here to Upload';
            end;
        }
        field(3; BudgetType; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(1; BudgetStatus; Option)
        {
            OptionMembers = "Approved Budget","Revised Budget";
            DataClassification = ToBeClassified;
        }
        field(4; FinancialYear; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = CodeType_AccountingPeriod."Dimension Financial Year";
            trigger OnValidate()
            var
                head: Record "OAG Budget Header";
            begin
                head.Reset();
                head.SetFilter("Budget Name", '<>%1', Rec."Budget Name");
                if head.FindFirst() then
                    repeat
                        if head.FinancialYear = rec.FinancialYear then
                            Error('Only one budget can be made for year : %1', rec.FinancialYear);
                    until head.Next() = 0;
            end;
        }
        field(5; datefilter; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; glaccountfilter; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(7; glaccountcategory; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account Category";
        }
        field(8; incomebalance; Code[20])
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
        field(16; AuditAssign; code[20]) //pru neha 3-9-23
        {
            DataClassification = ToBeClassified;
        }
        field(17; BudgetCategory; code[20]) //pru neha 3-9-23
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(key1; "Budget Name")
        {
            Clustered = true;
        }
    }
    var
        prod: Record "Production Order";
}