page 50053 "Annual Budget Entry"
{
    Caption = 'Annual Budget Entry';
    PageType = List;
    Editable = false;
    DeleteAllowed = false;
    UsageCategory = Administration;
    // ApplicationArea = all;
    SourceTable = AnnualBudget;
    // SourceTableView = sorting("No.") order(descending) where(Status = filter(Open | "Pending for Approval"));

    layout
    {
        area(Content)
        {

            repeater(GroupName)
            {
                Caption = 'General';
                field("Budget Name"; Rec.BudgetName)
                {
                    ApplicationArea = all;
                }
                field(BudgetStatus; Rec.BudgetStatus)
                {
                    ApplicationArea = all;
                }
                field(glacc; Rec.glacc)
                {
                    Caption = 'G/L Account';
                    ApplicationArea = all;
                }
                field(amount; Rec.amount)
                {
                    ApplicationArea = all;
                }
                field(programcode; Rec.programcode)
                {
                    ApplicationArea = all;
                    Caption = 'Programme Code';
                }
                field(directorate; Rec.directorate)
                {
                    Caption = 'Directorate Code';
                    ApplicationArea = all;
                }
                field(budget5; Rec.budget5)
                {
                    Caption = 'Fund Code';
                    ApplicationArea = all;
                }
                field(funding; Rec.funding)
                {
                    Caption = 'Funding Source';
                    ApplicationArea = all;
                }
                field(projectfilter; Rec.projectfilter)
                {
                    ApplicationArea = all;
                    Caption = 'Project Code';
                }
                field(budgetoutput; Rec.budgetoutput)
                {
                    ApplicationArea = all;
                    Caption = 'Budget Output';
                }
                field(auditentities; Rec.auditentities)
                {
                    Caption = 'Audit Entities';
                    ApplicationArea = all;
                }
                field(auditsegment; Rec.auditsegment)
                {
                    Caption = 'Audit Segments';
                    ApplicationArea = all;
                }
                field(budgetcategory; Rec.budgetcategory)
                {
                    Caption = 'Budget Category';
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("Import Data")
            {
                action(ImportLines)
                {
                    // ApplicationArea = All;
                    Caption = 'Import Budget';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    // RunObject = xmlport "WO ImportData";

                    trigger OnAction()
                    var

                        ImportworkOrderLines: XmlPort 50002;
                    begin
                        Clear(ImportworkOrderLines);
                        ImportworkOrderLines.Run();
                    end;
                }
            }
        }
    }
}