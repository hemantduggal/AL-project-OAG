page 50057 BudgetReallocation
{
    PageType = List;
    Caption = 'Annual Budget Reallocation';
    UsageCategory = Administration;
    // ApplicationArea = all;
    SourceTable = reallocationBudet;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("line No."; Rec."line No.")
                {
                    ApplicationArea = all;
                }
                field(BudgetName; Rec.BudgetName)
                {
                    ApplicationArea = all;
                }
                field(BudgetStatus; Rec.BudgetStatus)
                {
                    ApplicationArea = all;
                }
                field(glacc; Rec.glacc)
                {
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        line: Record BudgetLines;
                    begin
                        line.Reset();
                        line.SetRange("Budget name", rec.BudgetName);
                        if line.FindFirst() then
                            if page.RunModal(page::"Budget lines", line) = Action::LookupOK then
                                rec.glacc := line.code;
                    end;
                }
                field(amount; Rec.amount)
                {
                    ApplicationArea = all;
                }
                field(newglacc; Rec.newglacc)
                {
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        line: Record BudgetLines;
                    begin
                        line.Reset();
                        line.SetRange("Budget name", rec.BudgetName);
                        if line.FindFirst() then
                            if page.RunModal(page::"Budget lines", line) = Action::LookupOK then
                                rec.newglacc := line.code;
                    end;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Post)
            {
                Image = Post;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    posting(Rec);
                end;
            }
        }
    }
    procedure posting(var lines: Record reallocationBudet)
    var
        annual: Record AnnualBudget;
        lineno: Integer;
    begin
        if lines.FindSet() then begin
            repeat
                Clear(lineno);
                annual.Reset();
                if annual.FindLast() then
                    lineno := annual."Entry No.";
                annual.Reset();
                annual."Entry No." := lineno + 1;
                annual.BudgetName := lines.BudgetName;
                annual.BudgetStatus := lines.BudgetStatus;
                annual.glacc := lines.glacc;
                annual.amount := -lines.amount;
                annual.reallocated := true;
                annual.Insert();
                annual.Reset();
                annual."Entry No." := lineno + 2;
                annual.BudgetName := lines.BudgetName;
                annual.BudgetStatus := lines.BudgetStatus;
                annual.glacc := lines.newglacc;
                annual.amount := lines.amount;
                annual.reallocated := true;
                annual.Insert();
                rec.Delete();
            until lines.Next() = 0;
            Message('Done');
        end;
    end;
}