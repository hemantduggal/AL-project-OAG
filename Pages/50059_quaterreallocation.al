page 50059 BudgetReallocationquater
{
    PageType = List;
    Caption = 'Quarter Budget Reallocation';
    UsageCategory = Administration;
    ApplicationArea = all;
    SourceTable = reallocationquater;
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
                    Editable = false;
                }
                field(BudgetName; Rec.BudgetName)
                {
                    ApplicationArea = all;
                }
                field(BudgetStatus; Rec.BudgetStatus)
                {
                    ApplicationArea = all;
                }
                field(Quater; Rec.Quater)
                {
                    ApplicationArea = all;
                }
                field(glacc; Rec.glacc)
                {
                    Caption = 'G/L Account';
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        line: Record BudgetLines;
                    begin
                        line.Reset();
                        line.SetRange("Budget name", rec.BudgetName);
                        if line.FindFirst() then
                            if page.RunModal(page::"Budget lines all", line) = Action::LookupOK then
                                rec.glacc := line.code;
                    end;
                }
                field(amount; Rec.amount)
                {
                    Caption = 'Amount';
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        line: Record BudgetQuater;
                        amt: Decimal;
                    begin
                        Clear(amt);
                        line.Reset();
                        line.SetRange(BudgetName, rec.BudgetName);
                        line.SetRange(glacc, rec.glacc);
                        if line.FindSet() then
                            repeat
                                amt += line.amount
                            until line.Next() = 0;
                        if amt < rec.amount then
                            error('Amount is not valid')
                    end;
                }
                field(newglacc; Rec.newglacc)
                {
                    caption = 'New G/L Account';
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        line: Record BudgetLines;
                    begin
                        line.Reset();
                        line.SetRange("Budget name", rec.BudgetName);
                        if line.FindFirst() then
                            if page.RunModal(page::"Budget lines all", line) = Action::LookupOK then
                                rec.newglacc := line.code;
                    end;
                }
                field(newquater; Rec.newquater)
                {
                    caption = 'New Quarter';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        if rec.Quater = rec.newquater then
                            Error('Quaters can not be same');
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
    procedure posting(var lines: Record reallocationquater)
    var
        annual: Record BudgetQuater;
        head: Record "OAG Budget Header";
        lineno: Integer;
    begin
        if lines.FindSet() then begin
            repeat
                head.Reset();
                head.SetRange("Budget Name", rec.BudgetName);
                if head.FindFirst() then begin
                    head.BudgetStatus := head.BudgetStatus::"Revised Budget";
                    head.Modify();
                end;
                clear(lineno);
                annual.Reset();
                if annual.FindLast() then
                    lineno := annual."Entry No.";
                annual.Reset();
                annual."Entry No." := lineno + 1;
                annual.BudgetName := lines.BudgetName;
                annual.BudgetStatus := annual.BudgetStatus::"Revised Budget";
                annual.glacc := lines.glacc;
                annual.Quater := lines.Quater;
                annual.amount := -lines.amount;
                annual.isreallocated := true;
                annual.Is_Supplementry := annual.Is_Supplementry::N;
                annual.Insert();
                annual.Reset();
                annual."Entry No." := lineno + 2;
                annual.BudgetName := lines.BudgetName;
                annual.BudgetStatus := annual.BudgetStatus::"Revised Budget";
                annual.glacc := lines.newglacc;
                annual.Quater := lines.newquater;
                annual.amount := lines.amount;
                annual.isreallocated := true;
                annual.Is_Supplementry := annual.Is_Supplementry::N;
                annual.Insert();
                rec.Delete();
            until lines.Next() = 0;

            Message('Done');
        end;
    end;
}