page 50058 "Budget lines"
{
    CardPageId = "Oag approved test";
    Caption = 'Budget lines';
    PageType = List;
    Editable = false;
    DeleteAllowed = true;
    UsageCategory = Administration;
    ApplicationArea = all;
    SourceTable = BudgetQuater;
    SourceTableView = where(amount = filter(> 0));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                Caption = 'General';
                field(glacc; Rec.glacc)
                {
                    ApplicationArea = all;
                }
                field(Quater; Rec.Quater)
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(amount; Rec.amount)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        line: Record BudgetQuater;
    begin
        line.Reset();
        line.SetRange(BudgetName, rec.BudgetName);
        line.SetRange(Is_Supplementry, line.Is_Supplementry::N);
    end;

    var
        amt: Decimal;
}
page 50060 "Budget lines all"
{
    CardPageId = "Oag approved test";
    Caption = 'Budget lines';
    PageType = List;
    Editable = false;
    DeleteAllowed = true;
    UsageCategory = Administration;
    ApplicationArea = all;
    SourceTable = BudgetLines;

    layout
    {
        area(Content)
        {

            repeater(GroupName)
            {
                Caption = 'General';
                field(code; Rec.code)
                {
                    ApplicationArea = all;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                }
                field(Q1; Rec.Q1)
                {
                    ApplicationArea = all;
                }
                field(Q2; Rec.Q2)
                {
                    ApplicationArea = all;
                }
                field(Q3; Rec.Q3)
                {
                    ApplicationArea = all;
                }
                field(Q4; Rec.Q4)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}