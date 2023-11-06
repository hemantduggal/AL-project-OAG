page 50035 "Requests to Approve requistion"
{
    ApplicationArea = Suite;
    Caption = 'Requistion to Approve';
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Approval Entry requistion";
    SourceTableView = SORTING("Approver ID 1", Status, "Date-Time Sent for Approval")
                      ORDER(Ascending);
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(ToApprove; Rec."Document No.")
                {
                    ApplicationArea = Suite;
                    Caption = 'To Approve';
                    ToolTip = 'Specifies the record that you are requested to approve. On the Home tab, in the Process group, choose Record to view the record on a new page where you can also act on the approval request.';
                    Width = 30;
                }
                field(Details; Rec.description)
                {
                    ApplicationArea = Suite;
                    Caption = 'Details';
                    ToolTip = 'Specifies details about the approval request, such as what and who the request is about.';
                }
                field("Approver ID"; Rec."Approver ID 1")
                {
                    Caption = 'Approver ID';
                    // Visible = ShowAllEntries1;
                    ApplicationArea = all;
                }

                // field("Approver's comment"; Rec.Comment1)
                // {
                //     // Visible = ShowAllEntries1;
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies whether there are comments relating to the approval of the record. If you want to read the comments, choose the field to open the Approval Comment Sheet window.';
                // }
                // field("Approver ID 2"; Rec."Approver ID 2")
                // {
                //     // Visible = ShowAllEntries2;
                //     ApplicationArea = all;
                // }

                // field("Approver's comment 2"; Rec.Comment2)
                // {
                //     // Visible = ShowAllEntries2;
                //     ApplicationArea = all;
                //     ToolTip = 'Specifies whether there are comments relating to the approval of the record. If you want to read the comments, choose the field to open the Approval Comment Sheet window.';
                // }
                field("Sender ID"; Rec."Sender ID")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the ID of the user who sent the approval request for the document to be approved.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the approval status for the entry:';
                }
            }
        }
        area(factboxes)
        {
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = Suite;
                Visible = ShowCommentFactbox;
            }
            part(Change; "Workflow Change List FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                UpdatePropagation = SubPart;
                Visible = ShowChangeFactBox;
            }
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
        area(navigation)
        {
            group(Show)
            {
                Caption = 'Show';
                Image = View;
                action("Record")
                {
                    ApplicationArea = Suite;
                    Caption = 'Open Record';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Scope = Repeater;
                    ToolTip = 'Open the document, journal line, or card that the approval is requested for.';

                    trigger OnAction()
                    var
                        req: Record "Requisition Header";
                        catr: Record "Catering Header";
                        purreq: Record "purchase Requisition Header";
                    begin
                        catr.Reset();
                        catr.SetRange("No.", rec."Document No.");
                        if catr.FindFirst() then
                            Page.run(Page::"Catering Card", catr);

                        purreq.Reset();
                        purreq.SetRange("Requisition Slip No.", rec."Document No.");
                        if purreq.FindFirst() then
                            Page.run(Page::PurchRequisitionCard, purreq);

                        req.Reset();
                        req.SetRange("Requisition Slip No.", Rec."Document No.");
                        if req.FindFirst() then
                            Page.run(page::RequisitionCard, req);
                    end;
                }
                action(Comments)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Enabled = ShowRecCommentsEnabled;
                    Image = ViewComments;
                    // Promoted = true;
                    // PromotedCategory = Process;
                    Scope = Repeater;
                    ToolTip = 'View or add comments for the record.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        RecRef: RecordRef;
                    begin

                    end;
                }
            }
        }
        area(processing)
        {
            action(Approve)
            {
                // ApplicationArea = Suite;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                ToolTip = 'Approve the requested changes.';

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    reqhead: Record "Requisition Header";
                    catrhead: Record "Catering Header";
                begin
                    reqhead.Reset();
                    reqhead.SetRange("Requisition Slip No.", Rec."Document No.");
                    if reqhead.FindFirst() then begin
                        if reqhead."1st Approved/Rejected User ID" = UserId then begin
                            reqhead."1st Reject Comment" := 'Approved';
                            reqhead."1st Approved/Rejected Date" := Today;
                            reqhead.Modify();
                            Rec.Status := '2nd Approval Pending';
                            Rec.Modify();
                            Message('done');
                        end;
                        if reqhead."2nd Approved/Rejected User ID" = UserId then begin
                            reqhead."2nd Reject Comment" := 'Approved';
                            reqhead."2nd Approved/Rejected Date" := Today;
                            reqhead.Status := reqhead.Status::Approved;
                            reqhead.Modify();
                            Rec.Status := 'Released';
                            Rec.Modify();
                            Message('done');
                        end;
                    end;
                    catrhead.Reset();
                    catrhead.SetRange("No.", Rec."Document No.");
                    if catrhead.FindFirst() then begin
                        if catrhead."1st Approved/Rejected User ID" = UserId then begin
                            catrhead."1st Reject Comment" := 'Approved';
                            catrhead."1st Approved/Rejected Date" := Today;
                            catrhead.Modify();
                            Rec.Status := '2nd Approval Pending';
                            Rec.Modify();
                            Message('done');
                        end;
                        if catrhead."2nd Approved/Rejected User ID" = UserId then begin
                            catrhead."2nd Reject Comment" := 'Approved';
                            catrhead."2nd Approved/Rejected Date" := Today;
                            catrhead.Status := catrhead.Status::Approved;
                            catrhead.Modify();
                            Rec.Status := 'Released';
                            Rec.Modify();
                            Message('done');
                        end;
                    end;
                end;
            }
            action(Reject)
            {
                // ApplicationArea = Suite;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                ToolTip = 'Reject the approval request.';

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    reqhead: Record "Requisition Header";
                    catrhead: Record "Catering Header";
                begin
                    reqhead.Reset();
                    reqhead.SetRange("Requisition Slip No.", Rec."Document No.");
                    if reqhead.FindFirst() then begin
                        if reqhead."1st Approved/Rejected User ID" = UserId then begin
                            reqhead."1st Reject Comment" := 'Rejected';
                            reqhead."1st Approved/Rejected Date" := Today;
                            reqhead.Status := reqhead.Status::Rejected;
                            reqhead.Modify();
                            rec.Status := 'Rejected';
                            Rec.Modify();
                            Message('Done');
                        end;
                        if reqhead."2nd Approved/Rejected User ID" = UserId then begin
                            reqhead."2nd Reject Comment" := 'Rejected';
                            reqhead."2nd Approved/Rejected Date" := Today;
                            reqhead.Status := reqhead.Status::Rejected;
                            reqhead.Modify();
                            rec.Status := 'Rejected';
                            Rec.Modify();
                            Message('Done');
                        end;
                    end;
                    catrhead.Reset();
                    catrhead.SetRange("No.", Rec."Document No.");
                    if catrhead.FindFirst() then begin
                        if catrhead."1st Approved/Rejected User ID" = UserId then begin
                            catrhead."1st Reject Comment" := 'Rejected';
                            catrhead."1st Approved/Rejected Date" := Today;
                            catrhead.Status := catrhead.Status::Rejected;
                            catrhead.Modify();
                            rec.Status := 'Rejected';
                            Rec.Modify();
                            Message('Done');
                        end;
                        if catrhead."2nd Approved/Rejected User ID" = UserId then begin
                            catrhead."2nd Reject Comment" := 'Rejected';
                            catrhead."2nd Approved/Rejected Date" := Today;
                            catrhead.Status := catrhead.Status::Rejected;
                            catrhead.Modify();
                            rec.Status := 'Rejected';
                            Rec.Modify();
                            Message('Done');
                        end;
                    end;
                end;
            }
            action(Delegate)
            {
                Visible = false;
                ApplicationArea = Suite;
                Caption = 'Delegate';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Scope = Repeater;
                ToolTip = 'Delegate the approval to a substitute approver.';

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    // CurrPage.SetSelectionFilter(ApprovalEntry);
                    // ApprovalsMgmt.DelegateApprovalRequests(ApprovalEntry);
                end;
            }
            group(View)
            {
                Caption = 'View';
                action(OpenRequests)
                {
                    ApplicationArea = Suite;
                    Caption = 'Open Requests';
                    Image = Approvals;
                    ToolTip = 'Open the approval requests that remain to be approved or rejected.';

                    trigger OnAction()
                    begin
                        Rec.SetRange(Status, 'Open');
                    end;
                }
                action(AllRequests)
                {
                    ApplicationArea = Suite;
                    Caption = 'All Requests';
                    Image = AllLines;
                    ToolTip = 'View all approval requests that are assigned to you.';

                    trigger OnAction()
                    begin
                        Rec.SetRange(Status);
                        // ShowAllEntries := true;
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin

    end;

    trigger OnAfterGetCurrRecord()
    var
        RecRef: RecordRef;
    begin

    end;

    trigger OnAfterGetRecord()
    begin
        if Rec."Approver ID 1" = UserId then begin
            rec.SetRange("Approver ID 1", UserId);
            Rec.Setfilter(Status, '%1|%2', 'OPEN', '2nd Approval Pending');
            ShowAllEntries1 := false;
        end;
        if Rec."Approver ID 2" = UserId then begin
            rec.SetRange("Approver ID 2", UserId);
            Rec.SetRange(Status, '2nd Approval Pending');
            ShowAllEntries2 := true;
        end;
        if (Rec."Approver ID 1" <> UserId) and (Rec."Approver ID 2" <> UserId) then begin
            rec.SetRange("Approver ID 1", UserId);
            Rec.Setfilter(Status, '%1|%2', 'OPEN', '2nd Approval Pending');
        end;
    end;

    trigger OnOpenPage()

    begin

    end;

    var
        DateStyle: Text;
        ShowAllEntries1: Boolean;
        ShowAllEntries2: Boolean;
        ShowChangeFactBox: Boolean;
        ShowRecCommentsEnabled: Boolean;
        ShowCommentFactbox: Boolean;

    [IntegrationEvent(false, false)]
    local procedure OnOpenPageOnAfterSetUserIdFilter(var ApprovalEntry: Record "Approval Entry")
    begin
    end;
}

