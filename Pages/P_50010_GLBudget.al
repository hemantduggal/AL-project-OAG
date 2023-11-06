page 50010 "G/L Budget Standard"
{
    AdditionalSearchTerms = 'general ledger budgets,general ledger forecast';
    ApplicationArea = Suite;
    Caption = 'OAG Approved Budget';
    PageType = List;
    SourceTable = "G/L Budget Name";
    UsageCategory = Lists;
    CardPageId = "G/L Budget Standard";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Name; Rec.Name)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the name of the general ledger budget.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies a description of the general ledger budget name.';
                }
                //>>>.
                field("Budget Type"; Rec."Budget Type")
                {
                    ApplicationArea = all;
                }
                field("Budget Status"; Rec."Budget Status")
                {
                    ApplicationArea = all;
                }
                field("Financial Year"; Rec."Financial Year")
                {
                    ApplicationArea = all;
                }
                field("Budget Name"; Rec."Budget Name")
                {
                    ApplicationArea = all;
                }

                field("Global Dimension 1 Code"; GLSetup."Global Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Global Dimension 1 Code';
                    Editable = false;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                }
                field("Global Dimension 2 Code"; GLSetup."Global Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Global Dimension 2 Code';
                    Editable = false;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                }
                field("Budget Dimension 1 Code"; Rec."Budget Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies a code for a budget dimension. You can specify four additional dimensions on each budget that you create.';
                }
                field("Budget Dimension 2 Code"; Rec."Budget Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies a code for a budget dimension. You can specify four additional dimensions on each budget that you create.';
                }
                field("Budget Dimension 3 Code"; Rec."Budget Dimension 3 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies a code for a budget dimension. You can specify four additional dimensions on each budget that you create.';
                }
                field("Budget Dimension 4 Code"; Rec."Budget Dimension 4 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies a code for a budget dimension. You can specify four additional dimensions on each budget that you create.';
                }
                field("Budget Dimension 5 Code"; Rec."Budget Dimension 5 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies a code for a budget dimension. You can specify four additional dimensions on each budget that you create.';
                }
                field("Budget Dimension 6 Code"; Rec."Budget Dimension 6 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies a code for a budget dimension. You can specify four additional dimensions on each budget that you create.';
                }
                field("Budget Dimension 7 Code"; Rec."Budget Dimension 7 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies a code for a budget dimension. You can specify four additional dimensions on each budget that you create.';
                }
                field("Budget Dimension 8 Code"; Rec."Budget Dimension 8 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies a code for a budget dimension. You can specify four additional dimensions on each budget that you create.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies that the related record is blocked from being posted in transactions, for example a customer that is declared insolvent or an item that is placed in quarantine.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(EditBudget)
            {
                ApplicationArea = Suite;
                Caption = 'Edit Budget';
                Image = EditLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortCutKey = 'Return';
                ToolTip = 'Specify budgets that you can create in the general ledger application area. If you need several different budgets, you can create several budget names.';

                trigger OnAction()
                var
                    Budget: Page "Budget Standard";
                begin
                    Budget.SetBudgetName(Rec.Name);
                    Budget.Run();
                end;
            }
            group(ReportGroup)
            {
                Caption = 'Report';
                Image = "Report";
                action(ReportTrialBalance)
                {
                    ApplicationArea = Suite;
                    Caption = 'Trial Balance/Budget';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'View budget details for the specified period.';

                    trigger OnAction()
                    begin
                        REPORT.Run(REPORT::"Trial Balance/Budget");
                    end;
                }
            }
            group("Approvals")
            {
                action("Send For Approval")
                {
                    Caption = 'Send For Approval';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approval Management Custom";
                    begin

                        if Rec."Budget Status" = Rec."Budget Status"::"Initial Budget" then begin
                            IF ApprovalsMgmt.CheckGLBudNameApprovalsWorkflowEnabled(Rec) THEN
                                ApprovalsMgmt.OnSendGLBudNameForApproval(Rec);
                        end else
                            Error('Status should be open');

                    end;
                }
                action("Cancel Approval")
                {
                    Caption = 'Cancel Approval';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approval Management Custom";
                    begin

                        ApprovalsMgmt.OnCancelGLBudNameForApproval(Rec);

                    end;
                }

            }
        }
    }

    trigger OnOpenPage()
    begin
        GLSetup.Get();
    end;

    var
        GLSetup: Record "General Ledger Setup";

    procedure GetSelectionFilter(): Text
    var
        GLBudgetName: Record "G/L Budget Name";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SetSelectionFilter(GLBudgetName);
        exit(SelectionFilterManagement.GetSelectionFilterForGLBudgetName(GLBudgetName));
    end;
}

