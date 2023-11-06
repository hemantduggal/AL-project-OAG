page 50001 "RequisitionCard"
{
    Caption = 'Requisition Card';
    PageType = Card;
    //   UsageCategory = Administration;
    //  ApplicationArea = all;
    PopulateAllFields = true;
    SourceTable = "Requisition Header";
    Permissions = tabledata User = rimd;
    layout
    {
        area(Content)
        {

            group("General")
            {
                Caption = 'General';

                field("Requisition Slip No."; Rec."Requisition Slip No.")
                {
                    ApplicationArea = All;
                    Editable = PageEditable;
                    //Editable = EditBool;
                    trigger OnAssistEdit()
                    begin
                        if rec.AssistEdit(xRec) then
                            CurrPage.Update(false);
                    end;

                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                    Editable = PageEditable;
                    LookupPageId = storereqdropdown;
                    //Editable = EditBool;
                    Caption = 'Subject Matter';//neha11-11-22
                }
                field("Requested User ID"; rec."Requested User ID")
                {
                    ApplicationArea = all;
                    Editable = false;
                    //Editable = EditBool;
                }
                field("Request Date"; rec."Request Date")
                {
                    ApplicationArea = all;
                    Editable = PageEditable;
                    //Editable = EditBool;
                }
                // field(Acknol_comment;Rec.Acknol_comment)
                // {
                //     ApplicationArea =all;

                // }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                    //Editable = EditBool;
                }
                field("Short Close"; Rec."Short Close")
                {
                    ApplicationArea = all;
                    Editable = false;
                    //Editable = EditBool;
                }
                field("Short Close Date"; Rec."Short Close Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Department; rec.Department)
                {
                    //Editable = EditBool;
                    Editable = PageEditable;
                    // ApplicationArea = all;
                    Caption = 'Department Code';//15-11/22 hillary
                    //ShowMandatory = true;  //neha11-11-22
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Editable = PageEditable;
                    ShowMandatory = true;
                    //Editable = EditBool;
                }
                field("1st Approved/Rejected User ID"; rec."1st Approved/Rejected User ID")
                {
                    ApplicationArea = all;
                    Editable = PageEditable;
                    //Editable = EditBool;
                    ShowMandatory = true; //neha11-11-22
                                          /*
                                          trigger OnLookup(var Text: Text): Boolean
                                          var
                                              VendorRec: Record User;
                                              VendorList: Page Users;
                                          begin

                                              VendorRec.Reset();
                                              VendorList.SETTABLEVIEW(VendorRec);
                                              VendorList.LOOKUPMODE(TRUE);
                                              if (VendorList.RunModal() = Action::LookupOK) then begin
                                                  VendorList.GetRecord(VendorRec);
                                                  Rec."1st Approved/Rejected User ID" := VendorRec."User Name";

                                              END;
                                              end;
                      */

                }
                field("1st Approved/Rejected Date"; rec."1st Approved/Rejected Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("1st Reject Comment"; rec."1st Reject Comment")
                {
                    Caption = '1st Approver Comment';
                    ApplicationArea = all;
                    Editable = EditBool1;
                }
                field("2nd Approver"; rec."2nd Approver")
                {
                    ApplicationArea = all;
                    Editable = PageEditable;
                    Visible = false; //neha11-11-22
                    //Editable = EditBool;
                }
                field("2nd Approved/Rejected User ID"; rec."2nd Approved/Rejected User ID")
                {
                    ApplicationArea = all;
                    Editable = PageEditable;
                    //Editable = EditBool;
                }
                field("2nd Approved/Rejected Date"; rec."2nd Approved/Rejected Date")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("2nd Reject Comment"; rec."2nd Reject Comment")
                {
                    Caption = '2nd Approver Comment';
                    ApplicationArea = all;
                    Editable = EditBool2;
                }
                field("Store Location"; rec."Store Location")
                {
                    ApplicationArea = all;
                    Editable = false;
                    //Editable = EditBool;
                    ShowMandatory = true;
                    trigger OnValidate()
                    var
                        ReqLine: Record Requisition_Line;
                    begin
                        ReqLine.Reset();
                        ReqLine.SetRange(ReqLine."Requisition Slip No.", Rec."Requisition Slip No.");
                        if ReqLine.FindFirst() then
                            repeat
                                ReqLine."Store Location" := Rec."Store Location";
                                ReqLine.Modify();
                            until ReqLine.Next() = 0;
                        CurrPage.Update();
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;//15/11/22
                    Editable = PageEditable;
                    //Editable = EditBool;
                    trigger OnValidate()
                    var
                        ReqLine: Record Requisition_Line;
                        loc: Record Location;
                    begin
                        if loc.get(rec."Location Code") then
                            if loc."Use As In-Transit" = true then
                                error('Not a valid Location');
                        ReqLine.Reset();
                        ReqLine.SetRange(ReqLine."Requisition Slip No.", Rec."Requisition Slip No.");
                        if ReqLine.FindFirst() then
                            repeat
                                ReqLine."Location Code" := Rec."Location Code";
                                ReqLine.Modify();
                            until ReqLine.Next() = 0;
                        CurrPage.Update();
                    end;
                }
                field("Reference No."; Rec."Reference No.")
                {
                    // ApplicationArea = all;
                    Editable = PageEditable;
                    ShowMandatory = true;
                    //Editable = EditBool;
                }

            }

            group("Lines")
            {
                Caption = 'Lines';
                part(RequisitionLine; "RequisitionSubForm")
                {
                    SubPageLink = "Requisition Slip No." = FIELD("Requisition Slip No.");
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
            // group("&Issued")
            // {
            //     Caption = 'Issued';
            //     Image = Post;

            action(Issued)
            {
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
                    rec.TestField("Store Location");//for mandatory for store location
                    rec.TestField("Location Code");
                    rec.TestField("Shortcut Dimension 2 Code");
                    // rec.TestField(Department);
                    PurchPay.Get();
                    flag := false;
                    ReqL.Reset();
                    ReqL.SetRange("Requisition Slip No.", rec."Requisition Slip No.");
                    ReqL.SetFilter("Issued Quantity", '<>%1', 0);
                    //ReqL.SetFilter("Post Issue Qty", '%1', 0);
                    IF ReqL.FINDSET THEN
                        REPEAT
                            ReqL.TestField("Store Location");
                            IssueCode.PostRequistion(Rec, ReqL);
                            flag := true;
                        UNTIL ReqL.NEXT = 0;
                    if flag = false then
                        Error('Please select Issued Quantity in Lines');
                    if flag = true then begin
                        RHRec.Init();
                        RHRec.TransferFields(Rec);
                        RHRec."Archive Requisition Slip No." := NoSeriesMan.GetNextNo3(PurchPay."Archie Requisition No.", Today, true, false);
                        RHRec."Requisition Slip No." := Rec."Requisition Slip No.";
                        RHRec.Insert();


                        ReqL1.Reset();
                        //      ArchReqLine.Reset();//15/11/22
                        ReqL1.SetRange("Requisition Slip No.", Rec."Requisition Slip No.");
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
                    reqhead.SetRange("Document No.", Rec."Requisition Slip No.");
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
                            if rec."1st Reject Comment" = '' then
                                Error('First Level Approval is required.');
                            Rec.Validate("1st Reject Comment");
                            Rec.Validate("2nd Reject Comment");
                            reqhead.Comment2 := Rec."1st Reject Comment";
                            Rec."2nd Approved/Rejected Date" := Today;
                            Rec.Status := Rec.Status::Approved;
                            Rec.Modify();
                            reqhead.Status := 'Released';
                            reqhead.Modify();
                            user.Reset();
                            if user.get(Rec."Requested User ID") then
                                smtp.sendmail('Approved : ', rec."Requisition Slip No.", UserId, '', '', user."E-Mail", 'Store Requisition approved :' + Rec."Requisition Slip No.");
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
                    reqhead.SetRange("Document No.", rec."Requisition Slip No.");
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
            // }
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
                        rec.TestField("Store Location");
                        rec.TestField("Location Code");
                        rec.TestField("Shortcut Dimension 2 Code");
                        //  rec.TestField(Department);
                        if Rec.Status = Rec.Status::Open then begin
                            apprval.description := Rec.Description;
                            apprval."Document Type" := apprval."Document Type"::Quote;
                            apprval."Record ID to Approve" := rec.RecordId;
                            apprval."Document No." := Rec."Requisition Slip No.";
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
                            smtp.sendmail('Store Requisiton : ', rec."Requisition Slip No.", UserId, '', '', user."E-Mail", 'Please approve This store requistion :' + Rec."Requisition Slip No.");
                        user.Reset();
                        if user.get(Rec."2nd Approved/Rejected User ID") then
                            smtp.sendmail('Store Requisiton : ', rec."Requisition Slip No.", UserId, '', '', user."E-Mail", 'Please approve This store requistion :' + Rec."Requisition Slip No.");
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
                        rec.TestField("Store Location");
                        rec.TestField("Location Code");
                        rec.TestField("Shortcut Dimension 2 Code");
                        //  rec.TestField(Department);
                        ApprovalsMgmt.OnCancelRequisitionMasterForApproval(Rec);

                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        UserSetup.SETFILTER(UserSetup."Access Requisition Document", '<>%1', UserSetup."Access Requisition Document"::Post);
                        IF UserSetup.FINDFIRST THEN
                            ERROR('You do not have permission to post Requisition Document')

                    end;
                }
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
                    Rec."Short Close" := true;
                    rec."Short Close Date" := Today;
                    rec.Modify();

                end;
            }
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
        UserSetup: Record 91;

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

}

