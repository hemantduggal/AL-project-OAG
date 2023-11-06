page 50013 PostedRequisitionList
{
    PageType = List;
    Caption = 'Posted Requisition Slip History List';
    UsageCategory = Administration;
    ApplicationArea = all;
    SourceTable = "Requisition Header";
    CardPageId = "Posted ReqSlip History Card";
    Editable = false;
    //SourceTableView = where("Short Close" = filter(false));

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
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field("1st Approved/Rejected User ID"; Rec."1st Approved/Rejected User ID")
                {
                    ApplicationArea = all;
                }
                field("2nd Approved/Rejected User ID"; Rec."2nd Approved/Rejected User ID")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Reporting)
        {
            action("Store Requisition Order")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Report;
                //PromotedIsBig = true;
                Image = Report;
                Caption = 'Store Requisition Order';
                trigger OnAction()
                begin
                    Rec.SETRANGE("Requisition Slip No.", Rec."Requisition Slip No.");
                    REPORT.RUN(50000, TRUE, FALSE, Rec);
                end;
            }
        }
    }


    var

}