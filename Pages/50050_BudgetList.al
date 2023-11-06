page 50050 "Budget List"
{
    CardPageId = "Oag approved test";
    Caption = 'Budget List';
    PageType = List;
    Editable = false;
    DeleteAllowed = true;
    UsageCategory = Administration;
    ApplicationArea = all;
    SourceTable = "OAG Budget Header";
    // SourceTableView = sorting("No.") order(descending) where(Status = filter(Open | "Pending for Approval"));

    layout
    {
        area(Content)
        {

            repeater(GroupName)
            {
                Caption = 'General';
                field("Budget Name"; Rec."Budget Name")
                {
                    ApplicationArea = all;
                }
                field(BudgetStatus; Rec.BudgetStatus)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Delete")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    budhead: Record "OAG Budget Header";
                    buline: Record BudgetLines;
                    budquter: Record BudgetQuater;
                    budannual: Record AnnualBudget;
                begin
                    budhead.DeleteAll();
                    buline.DeleteAll();
                    budquter.DeleteAll();
                    budannual.DeleteAll();
                end;
            }
        }
    }
}