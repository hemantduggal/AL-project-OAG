page 50037 "Catering Card"
{
    Caption = 'Catering Card';
    PageType = Card;
    // DeleteAllowed = false;
    //   UsageCategory = Administration;
    //  ApplicationArea = all;
    PopulateAllFields = true;
    SourceTable = "Catering Header";

    layout
    {
        area(Content)
        {

            group("General")
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Editable = PageEditable;
                }
                field(Description; Rec.Description)
                {
                    LookupPageId = Cateringreqdropdown;
                    Caption = 'Description/Purpose';
                    ApplicationArea = all;
                    Editable = PageEditable;
                }
                field(meetingdate; Rec.meetingdate)
                {
                    Caption = 'Meeting Date';
                    ApplicationArea = all;
                    Editable = PageEditable;
                }
                field(meetingTime; Rec.meetingTime)
                {
                    Caption = 'Meeting Time';
                    ApplicationArea = all;
                    Editable = PageEditable;
                }
                field(Venue; Rec.Venue)
                {
                    Caption = 'Confirmed Venue';
                    ApplicationArea = all;
                    Editable = PageEditable;
                }
                field("1st Approved/Rejected User ID"; Rec."1st Approved/Rejected User ID")
                {
                    ApplicationArea = all;
                    Editable = PageEditable;
                }
                field("1st Reject Comment"; Rec."1st Reject Comment")
                {
                    Caption = '1st Approver Comment';
                    ApplicationArea = all;
                    Editable = EditBool1;
                }
                field("2nd Approved/Rejected User ID"; Rec."2nd Approved/Rejected User ID")
                {
                    ApplicationArea = all;
                    Editable = PageEditable;
                }
                field("2nd Reject Comment"; Rec."2nd Reject Comment")
                {
                    Caption = '2nd Approver Comment';
                    ApplicationArea = all;
                    Editable = editbool2;
                }
                field(expectedParticipent; Rec.expectedParticipent)
                {
                    Caption = 'Expected No. of Participents';
                    ApplicationArea = all;
                    Editable = PageEditable;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(user; Rec.user)
                {
                    Editable = false;
                    Caption = 'User';
                    ApplicationArea = all;
                }
            }
            group("Lines")
            {
                Caption = 'Lines';
                part(catering; "Catering SubForm")
                {
                    SubPageLink = DocNo = FIELD("No.");
                    ApplicationArea = All;
                    Editable = PageEditable;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(CateringReport)
            {
                ApplicationArea = Suite;
                Caption = 'Catering Report';
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    chead: Record "Catering Header";
                begin
                    Rec.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(50023, TRUE, true, Rec);
                end;
            }
            // group("&Issued")
            // {
            //     Caption = 'Issued';
            //     Image = Post;

            action(Issued)
            {
                Visible = false;
                // Caption = 'Issued';
                Image = Post;
                // Promoted = true;
                // PromotedCategory = Category4;
                // PromotedIsBig = true;
                // ApplicationArea = all;
                trigger OnAction()
                var
                    ReqL: Record "Requisition_Line";
                    IssueCode: Codeunit RequistionPost;
                    ItemJournalLine: Record 83;
                    RHRec: Record "Archieve Req Header";
                    NoSeriesMan: Codeunit NoSeriesManagement;
                    PurchPay: Record "Purchases & Payables Setup";
                    ReqL1: Record "Requisition_Line";
                    ArchReqLine: Record "Archieve Req_Line";
                    flag: Boolean;

                begin
                    // rec.TestField("Store Location");//for mandatory for store location
                    // rec.TestField("Location Code");
                    // rec.TestField("Shortcut Dimension 2 Code");
                    // rec.TestField(Department);
                    PurchPay.Get();
                    flag := false;
                    ReqL.Reset();
                    ReqL.SetRange("Requisition Slip No.", rec."No.");
                    ReqL.SetFilter("Issued Quantity", '<>%1', 0);
                    //ReqL.SetFilter("Post Issue Qty", '%1', 0);
                    IF ReqL.FINDSET THEN
                        REPEAT
                            ReqL.TestField("Store Location");
                            // IssueCode.PostRequistion(Rec, ReqL);
                            flag := true;
                        UNTIL ReqL.NEXT = 0;
                    if flag = false then
                        Error('Please select Issued Quantity in Lines');
                    if flag = true then begin
                        RHRec.Init();
                        RHRec.TransferFields(Rec);
                        RHRec."Archive Requisition Slip No." := NoSeriesMan.GetNextNo3(PurchPay."Archie Requisition No.", Today, true, false);
                        RHRec."Requisition Slip No." := Rec."No.";
                        RHRec.Insert();


                        ReqL1.Reset();
                        //      ArchReqLine.Reset();//15/11/22
                        ReqL1.SetRange("Requisition Slip No.", Rec."No.");
                        //     ReqL1.SetFilter("Post Issue Qty", '%1', 0);///
                        ReqL1.SetFilter("Issued Quantity", '<>%1', 0);
                        if ReqL1.FindFirst() then begin
                            repeat
                                ArchReqLine.Init();
                                ArchReqLine.TransferFields(ReqL1);
                                ArchReqLine."Requisition Slip No." := RHRec."Archive Requisition Slip No.";
                                ArchReqLine.Insert();
                                ReqL1."Issued Quantity" := 0;
                                ReqL1.Modify();
                            until ReqL1.Next() = 0;
                            Message('PO No. is archieved & Store Location is updated successfully');
                        end;
                    END;

                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access Requisition Document", '<>%1', UserSetup."Access Requisition Document"::Post);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You do not have permission to post Requisition Document')
                end;
            }
            action(Approve)
            {
                Visible = approvbutton;
                ApplicationArea = Suite;
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
                    reqhead: Record "Approval Entry requistion";
                    smtp: Codeunit smtpmail;
                    user: Record "User Setup";
                begin
                    reqhead.Reset();
                    reqhead.SetRange("Document No.", Rec."No.");
                    if reqhead.FindFirst() then begin
                        if Rec."1st Approved/Rejected User ID" = UserId then begin
                            Rec.Validate("1st Reject Comment");
                            reqhead.Comment1 := Rec."1st Reject Comment";
                            Rec."1st Approved/Rejected Date" := Today;
                            Rec.Modify();
                            reqhead."Approver ID 1" := Rec."2nd Approved/Rejected User ID";
                            reqhead.Status := '2nd Approval Pending';
                            reqhead.Modify();
                            Message('Done');
                            CurrPage.Close();
                        end;
                        if Rec."2nd Approved/Rejected User ID" = UserId then begin
                            Rec.Validate("1st Approved/Rejected Date");
                            reqhead.Comment2 := Rec."1st Reject Comment";
                            Rec."2nd Approved/Rejected Date" := Today;
                            Rec.Status := Rec.Status::Approved;
                            Rec.Modify();
                            reqhead.Status := 'Released';
                            reqhead.Modify();
                            user.Reset();
                            if user.get(Rec."User") then
                                smtp.sendmail('Approved : ', rec."No.", UserId, '', '', user."E-Mail", 'Catering Requisition approved :' + Rec."No.");
                            Message('Done');
                            CurrPage.Close();
                        end;
                    end;
                end;
            }
            action(Reject)
            {
                Visible = approvbutton;
                ApplicationArea = Suite;
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
                    reqhead: Record "Approval Entry requistion";
                begin
                    reqhead.Reset();
                    reqhead.SetRange("Document No.", rec."No.");
                    if reqhead.FindFirst() then begin
                        if Rec."1st Approved/Rejected User ID" = UserId then begin
                            reqhead.Comment1 := Rec."1st Reject Comment";
                            Rec."1st Approved/Rejected Date" := Today;
                            Rec.Status := rec.Status::Rejected;
                            Rec.Modify();
                            reqhead.Status := 'Rejected';
                            reqhead.Modify();
                            Message('Done');
                            CurrPage.Close();
                        end;
                        if Rec."2nd Approved/Rejected User ID" = UserId then begin
                            reqhead.Comment2 := Rec."2nd Reject Comment";
                            Rec."2nd Approved/Rejected Date" := Today;
                            Rec.Status := rec.Status::Rejected;
                            Rec.Modify();
                            reqhead.Status := 'Rejected';
                            reqhead.Modify();
                            Message('Done');
                            CurrPage.Close();
                        end;
                    end;
                end;
            }

            group("Approvals")
            {
                action("Send For Approval")
                {

                    // Promoted = true;
                    //  PromotedCategory = Process;
                    // PromotedIsBig = true;
                    Caption = 'Send For Approval';
                    Image = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approval Management Custom";
                        apprval: Record "Approval Entry requistion";
                        noti: Notification;
                        tabl: Record 50;
                        smtp: Codeunit smtpmail;
                        user: Record "User Setup";
                    begin
                        // tabl.DeleteAll();
                        // Commit();
                        // rec.TestField("Store Location");
                        // rec.TestField("Location Code");
                        // rec.TestField("Shortcut Dimension 2 Code");
                        //  rec.TestField(Department);
                        if Rec.Status = Rec.Status::Open then begin
                            apprval.description := Rec.Description;
                            apprval."Document Type" := apprval."Document Type"::Quote;
                            apprval."Record ID to Approve" := rec.RecordId;
                            apprval."Document No." := Rec."No.";
                            apprval."Approver ID 1" := Rec."1st Approved/Rejected User ID";
                            // apprval."Approver ID 2" := Rec."2nd Approved/Rejected User ID";
                            apprval."Date-Time Sent for Approval" := CurrentDateTime;
                            apprval."Sender ID" := UserId;
                            apprval.Status := 'Open';
                            apprval.Insert();
                            Rec.Status := Rec.Status::"Pending for Approval";
                            Rec.Modify();
                        end else
                            Error('Status should be open');
                        // noti.Message := 'This is a notification';
                        // noti.Scope := NotificationScope::LocalScope;
                        // noti.SetData('Created', Format(CurrentDateTime, 0, 9));
                        // noti.SetData('UserID', Rec."1st Approved/Rejected User ID");
                        // noti.SetData('DocNo', rec."Requisition Slip No.");
                        // noti.AddAction('Action 1', Codeunit::notificationhandler, 'OpenRecord');
                        // noti.Send()
                        // user.Reset();
                        // if user.Get(UserId) then
                        //     smtp.sendmail('Store Requisiton : ', rec."Requisition Slip No.", UserId, '', '', user."Contact Email");
                        user.Reset();
                        if user.get(Rec."1st Approved/Rejected User ID") then
                            smtp.sendmail('CateringRequisiton: ', rec."No.", UserId, '', '', user."E-Mail", 'Please approve This Catering requistion :' + Rec."No.");
                        user.Reset();
                        if user.get(Rec."2nd Approved/Rejected User ID") then
                            smtp.sendmail('CateringRequisiton: ', rec."No.", UserId, '', '', user."E-Mail", 'Please approve This Catering requistion :' + Rec."No.");
                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        UserSetup.SETFILTER(UserSetup."Access Requisition Document", '<>%1', UserSetup."Access Requisition Document"::Post);
                        IF UserSetup.FINDFIRST THEN
                            ERROR('You do not have permission to post Requisition Document')
                    end;
                }
                action("Cancel Approval")
                {
                    //Promoted = true;
                    //  PromotedCategory = Process;
                    // PromotedIsBig = true;
                    Caption = 'Cancel Approval';
                    Image = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approval Management Custom";
                    begin
                        // rec.TestField("Store Location");
                        // rec.TestField("Location Code");
                        // rec.TestField("Shortcut Dimension 2 Code");
                        //  rec.TestField(Department);
                        // ApprovalsMgmt.OnCancelRequisitionMasterForApproval(Rec);

                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        UserSetup.SETFILTER(UserSetup."Access Requisition Document", '<>%1', UserSetup."Access Requisition Document"::Post);
                        IF UserSetup.FINDFIRST THEN
                            ERROR('You do not have permission to post Requisition Document')

                    end;
                }
                action("$Short Close")
                {
                    // Promoted = true;
                    // PromotedCategory = Process;
                    Visible = true;
                    Caption = 'Short Close';
                    Image = Close;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        rech: Record "Requisition Header";
                    begin
                        UserSetup.RESET;//usersetup
                        UserSetup.SETRANGE("User ID", USERID);
                        UserSetup.SETFILTER(UserSetup."Short Close", '%1', false);
                        IF UserSetup.FINDFIRST THEN
                            ERROR('You do not have Permission for Short Close');

                        // rech.Reset();
                        // rech.SetRange("Requisition Slip No.", Rec."Requisition Slip No.");
                        Rec.Status := Rec.Status::"Short Close";
                        Rec."Short Close" := true;
                        rec."Short Close Date" := Today;
                        rec.Modify();

                    end;
                }

            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        if Rec.Status = Rec.Status::"Pending for Approval" then
            PageEditable := false
        else
            PageEditable := true;

        if Rec."1st Approved/Rejected User ID" = UserId then begin
            EditBool1 := true;
        end
        else begin
            EditBool1 := false;
        end;
        if Rec."2nd Approved/Rejected User ID" = UserId then begin
            EditBool2 := true;
        end
        else begin
            EditBool2 := false;
        end;
        if (Rec."2nd Approved/Rejected User ID" = UserId) or (Rec."1st Approved/Rejected User ID" = UserId) then begin
            approvbutton := true;
        end
        else begin
            approvbutton := false;
        end;
    end;


    trigger OnAfterGetRecord()
    begin
        if Rec.Status = Rec.Status::"Pending for Approval" then
            PageEditable := false
        else
            PageEditable := true;

        if Rec."1st Approved/Rejected User ID" = UserId then begin
            EditBool1 := true;
        end
        else begin
            EditBool1 := false;
        end;
        if Rec."2nd Approved/Rejected User ID" = UserId then begin
            EditBool2 := true;
        end
        else begin
            EditBool2 := false;
        end;
        if (Rec."2nd Approved/Rejected User ID" = UserId) or (Rec."1st Approved/Rejected User ID" = UserId) then begin
            approvbutton := true;
        end
        else begin
            approvbutton := false;
        end;


        //  UserSetup.RESET;
        //  UserSetup.SETRANGE("User ID", USERID);
        ///  UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::View);
        //  IF UserSetup.FINDFIRST THEN
        //      ERROR('You can not delete the Requisition order');
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the Requisition Document');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::Post);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Requisition Document');
        //ERROR('You do not have Permission to Delete Purchase Quote');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //  ERROR('You do not have Permission to Change Purchase Quote Details');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //    ERROR('You do not have Permission to Change Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);


        //   ERROR('You do not have Permission to add new Purchase Quote Details');
        //PRU_DD 1.10
    end;

    /* trigger OnDeleteRecord(): Boolean
     begin
         //     UserSetup.RESET;
         //     UserSetup.SETRANGE("User ID", USERID);
         //    UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::View);
         //    IF UserSetup.FINDFIRST THEN
         //       ERROR('You can not delete the Requisition order');
         //PRU_DD 1.10
     end;

     // trigger OnInsertRecord(BelowxRec: Boolean): Boolean
     /*  begin
           UserSetup.RESET;
           UserSetup.SETRANGE("User ID", USERID);
           UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::View);
           IF UserSetup.FINDFIRST THEN
               CurrPage.EDITABLE(FALSE);

           UserSetup.RESET;
           UserSetup.SETRANGE("User ID", USERID);
           UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::Post);
           IF UserSetup.FINDFIRST THEN
               ERROR('You can not Post the Requisition order');



           UserSetup.RESET;
           UserSetup.SETRANGE("User ID", USERID);
           // UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::"Receive & Invoice");
           IF UserSetup.FINDFIRST THEN
               ERROR('You can not Create the Requisition order');
           //PRU_DD 1.10
       end;

       trigger OnModifyRecord(): Boolean
       begin
           UserSetup.RESET;
           UserSetup.SETRANGE("User ID", USERID);
           UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::View);
           IF UserSetup.FINDFIRST THEN begin
               EditBool := false;
               ERROR('You can not modify the Requisition order');
           end else
               EditBool := true;

           //PRU_DD 1.10
       end;


       trigger OnNewRecord(BelowxRec: Boolean)
       begin
           /*  UserSetup.RESET;
             UserSetup.SETRANGE("User ID", USERID);
             UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::View);
             IF UserSetup.FINDFIRST THEN
                 CurrPage.EDITABLE(FALSE);
     */
    /*
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::Post);
            IF UserSetup.FINDFIRST THEN
                ERROR('You can not post the Requisition order');

            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::Create);
            IF UserSetup.FINDFIRST THEN
                ERROR('You can not Create the Requisition order');

            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            // UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::"Receive & Invoice");
            IF UserSetup.FINDFIRST THEN
                ERROR('You can not Create the Requisition order');

            //PRU_DD 1.10
            */
    //  end;

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::Approved then
            PageEditable := false;

        if Rec.Status = Rec.Status::"Pending for Approval" then
            PageEditable := false
        else
            PageEditable := true;

        if Rec."1st Approved/Rejected User ID" = UserId then begin
            EditBool1 := true;
        end
        else begin
            EditBool1 := false;
        end;
        if Rec."2nd Approved/Rejected User ID" = UserId then begin
            EditBool2 := true;
        end
        else begin
            EditBool2 := false;
        end;
        if (Rec."2nd Approved/Rejected User ID" = UserId) or (Rec."1st Approved/Rejected User ID" = UserId) then begin
            approvbutton := true;
        end
        else begin
            approvbutton := false;
        end;


        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Requisition Document');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);



    end;
    /*
            //PRU_DD 1.10
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::" ");
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have permission to open Requisition Order');
                */

    //    UserSetup.RESET;
    //    UserSetup.SETRANGE("User ID", USERID);
    //    UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::View);
    //    IF UserSetup.FINDFIRST THEN
    //       CurrPage.EDITABLE(FALSE);
    /*
            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::Edit);
            IF UserSetup.FINDFIRST THEN
                CurrPage.EDITABLE(true);

            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Requisition Document", '%1', UserSetup."Access Requisition Document"::Create);
            IF UserSetup.FINDFIRST THEN
                CurrPage.EDITABLE(true);
                */


    var
        PageEditable: Boolean;
        EditBool1: Boolean;
        editbool2: Boolean;
        approvbutton: Boolean;
        UserSetup: Record 91;
        ps: Page 291;
}