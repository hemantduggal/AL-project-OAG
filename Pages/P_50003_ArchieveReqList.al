page 50003 "Archieve Req List"
{
    PageType = List;
    Caption = 'Archieve Requisition List';
    UsageCategory = Administration;
    ApplicationArea = all;
    SourceTable = "Archieve Req Header";
    CardPageId = "Archieve Req Card";
    Editable = false;
    SourceTableView = sorting("Requisition Slip No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Requisition Slip No."; Rec."Requisition Slip No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("Requested User ID"; Rec."Requested User ID")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("1st Approved/Rejected User ID"; Rec."1st Approved/Rejected User ID")
                {
                    ApplicationArea = All;
                }
                field("2nd Approved/Rejected User ID"; Rec."2nd Approved/Rejected User ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(View)
            {
                ApplicationArea = All;
                RunObject = page "Archieve Req Card";
                Promoted = true;
                PromotedCategory = New;
                Image = View;

                trigger OnAction();
                begin

                end;
            }
        }
        area(Reporting)
        {
            action("Store Requisition Order")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = Print;
                Caption = 'Store Requisition Order';
                trigger OnAction()
                begin
                    Rec.SETRANGE("Requisition Slip No.", Rec."Requisition Slip No.");
                    REPORT.RUN(50000, TRUE, FALSE, Rec);
                end;
            }

        }
    }
    trigger OnOpenPage()
    var
        usersetup: Record "User Setup";
    begin
        usersetup.get(UserId);
        if usersetup.storeuser = false then
            Rec.SetRange("Requested User ID", UserId);
    end;

    var

}