page 50033 "ApprovedRequisitionCard"
{
    Caption = 'approved Requisition Card';
    PageType = Card;
    DeleteAllowed = false;
    //   UsageCategory = Administration;
    //  ApplicationArea = all;
    PopulateAllFields = true;
    SourceTable = "Requisition Header";

    layout
    {
        area(Content)
        {

            group("General")
            {
                Caption = 'General';
                Editable = false;
                field("Requisition Slip No."; Rec."Requisition Slip No.")
                {
                    ApplicationArea = All;
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
                    //Editable = EditBool;
                    Caption = 'Subject Matter';//neha11-11-22
                }
                field("Requested User ID"; rec."Requested User ID")
                {
                    ApplicationArea = all;
                    //Editable = EditBool;
                }
                field("Request Date"; rec."Request Date")
                {
                    ApplicationArea = all;
                    //Editable = EditBool;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    //Editable = EditBool;
                }
                field("Short Close"; Rec."Short Close")
                {
                    ApplicationArea = all;
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
                    ApplicationArea = all;
                    Caption = 'Department Code';//15-11/22 hillary
                    //ShowMandatory = true;  //neha11-11-22
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                    //Editable = EditBool;
                }
                field("1st Approved/Rejected User ID"; rec."1st Approved/Rejected User ID")
                {
                    ApplicationArea = all;
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
                    ApplicationArea = all;
                    //Editable = EditBool;
                }
                field("2nd Approver"; rec."2nd Approver")
                {
                    ApplicationArea = all;
                    Visible = false; //neha11-11-22
                    //Editable = EditBool;
                }
                field("2nd Approved/Rejected User ID"; rec."2nd Approved/Rejected User ID")
                {
                    ApplicationArea = all;
                    //Editable = EditBool;
                }
                field("2nd Approved/Rejected Date"; rec."2nd Approved/Rejected Date")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("2nd Reject Comment"; rec."2nd Reject Comment")
                {
                    ApplicationArea = all;
                    //Editable = EditBool;
                }
                field("Store Location"; rec."Store Location")
                {
                    ApplicationArea = all;
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
                    //Editable = EditBool;
                    trigger OnValidate()
                    var
                        ReqLine: Record Requisition_Line;
                    begin
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
                    ApplicationArea = all;
                    ShowMandatory = true;
                    //Editable = EditBool;
                }

            }

            group("Lines")
            {
                Caption = 'Lines';
                part(RequisitionLine; "approvedRequisitionSubForm")
                {
                    SubPageLink = "Requisition Slip No." = FIELD("Requisition Slip No.");
                    ApplicationArea = All;
                    Editable = true;
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
                ApplicationArea = all;
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
                    itm: Record Item;
                    itemjnlpost: Codeunit "Item Jnl.-Post";
                    lastno: Integer;
                begin
                    rec.TestField("Store Location");//for mandatory for store location
                    rec.TestField("Location Code");
                    rec.TestField("Shortcut Dimension 2 Code");
                    // rec.TestField(Department);
                    ReqL.Reset();
                    ReqL.SetRange("Requisition Slip No.", rec."Requisition Slip No.");
                    ReqL.SetFilter("Issued Quantity", '<>%1', 0);
                    if ReqL.FindSet() then
                        repeat
                            ReqL.CalcFields("Stock In Hand");
                            if ReqL."Issued Quantity" > ReqL."Stock In Hand" then
                                Error('Insufficient Quantity in Store');
                        until ReqL.Next() = 0;
                    PurchPay.Get();
                    flag := false;
                    ReqL.Reset();
                    ReqL.SetRange("Requisition Slip No.", rec."Requisition Slip No.");
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
                        RHRec."Requisition Slip No." := Rec."Requisition Slip No.";
                        RHRec.Insert();
                        ReqL1.Reset();
                        //      ArchReqLine.Reset();//15/11/22
                        ReqL1.SetRange("Requisition Slip No.", Rec."Requisition Slip No.");
                        //     ReqL1.SetFilter("Post Issue Qty", '%1', 0);///
                        ReqL1.SetFilter("Issued Quantity", '<>%1', 0);
                        if ReqL1.FindFirst() then begin
                            repeat
                                Clear(lastno);
                                itemjrnl.SetRange("Journal Template Name", 'ITEM');
                                itemjrnl.SetRange("Journal Batch Name", 'REQUISTION');
                                if itemjrnl.FindLast() then
                                    lastno := itemjrnl."Line No.";
                                itm.get(ReqL1."No.");
                                ItemJournalLine.Reset();
                                ItemJournalLine."Journal Template Name" := 'ITEM';
                                ItemJournalLine."Journal Batch Name" := 'REQUISTION';
                                ItemJournalLine."Line No." := lastno + 10000;
                                ItemJournalLine."Document No." := Rec."Requisition Slip No.";
                                ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Negative Adjmt.";
                                ItemJournalLine."Item No." := ReqL1."No.";
                                ItemJournalLine."Posting Date" := Today;
                                ItemJournalLine.Validate("Item No.");
                                ItemJournalLine.validate("Gen. Prod. Posting Group", itm."Gen. Prod. Posting Group");
                                ItemJournalLine.Quantity := ReqL1."Issued Quantity";
                                ItemJournalLine.Validate(Quantity);
                                ItemJournalLine."Location Code" := ReqL1."Store Location";
                                ItemJournalLine.validate("Location Code");
                                ItemJournalLine.Insert();
                                itemjrnl.SetRange("Journal Template Name", 'ITEM');
                                itemjrnl.SetRange("Journal Batch Name", 'REQUISTION');
                                if itemjrnl.FindFirst() then
                                    itemjnlpost.Run(itemjrnl);

                                ArchReqLine.Init();
                                ArchReqLine.TransferFields(ReqL1);
                                ArchReqLine."Requisition Slip No." := RHRec."Archive Requisition Slip No.";
                                ArchReqLine.Insert();
                                ReqL1."Issued Quantity" := 0;
                                ReqL1.Modify();
                                ReqL1.Delete();
                            until ReqL1.Next() = 0;
                            Rec.Delete();
                            // Message('PO No. is archieved & Store Location is updated successfully');
                        end;
                    END;

                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access Requisition Document", '<>%1', UserSetup."Access Requisition Document"::Post);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You do not have permission to post Requisition Document')
                end;
            }
            // }
            // group("Approvals")
            // {
            //     action("Send For Approval")
            //     {
            //         // Promoted = true;
            //         //  PromotedCategory = Process;
            //         // PromotedIsBig = true;
            //         Caption = 'Send For Approval';
            //         Image = Process;
            //         ApplicationArea = All;
            //         trigger OnAction()
            //         var
            //             ApprovalsMgmt: Codeunit "Approval Management Custom";
            //         begin
            //             rec.TestField("Store Location");
            //             rec.TestField("Location Code");
            //             rec.TestField("Shortcut Dimension 2 Code");
            //             //  rec.TestField(Department);
            //             if Rec.Status = Rec.Status::Open then begin
            //                 IF ApprovalsMgmt.CheckRequisitionApprovalsWorkflowEnabled(Rec) THEN
            //                     ApprovalsMgmt.OnSendRequisitionForApproval(Rec);
            //             end else
            //                 Error('Status should be open');

            //             UserSetup.RESET;
            //             UserSetup.SETRANGE("User ID", USERID);
            //             UserSetup.SETFILTER(UserSetup."Access Requisition Document", '<>%1', UserSetup."Access Requisition Document"::Post);
            //             IF UserSetup.FINDFIRST THEN
            //                 ERROR('You do not have permission to post Requisition Document')
            //         end;
            //     }
            //     action("Cancel Approval")
            //     {
            //         //Promoted = true;
            //         //  PromotedCategory = Process;
            //         // PromotedIsBig = true;
            //         Caption = 'Cancel Approval';
            //         Image = Process;
            //         ApplicationArea = All;
            //         trigger OnAction()
            //         var
            //             ApprovalsMgmt: Codeunit "Approval Management Custom";
            //         begin
            //             rec.TestField("Store Location");
            //             rec.TestField("Location Code");
            //             rec.TestField("Shortcut Dimension 2 Code");
            //             //  rec.TestField(Department);
            //             ApprovalsMgmt.OnCancelRequisitionMasterForApproval(Rec);

            //             UserSetup.RESET;
            //             UserSetup.SETRANGE("User ID", USERID);
            //             UserSetup.SETFILTER(UserSetup."Access Requisition Document", '<>%1', UserSetup."Access Requisition Document"::Post);
            //             IF UserSetup.FINDFIRST THEN
            //                 ERROR('You do not have permission to post Requisition Document')

            //         end;
            //     }
            // }
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



    trigger OnAfterGetRecord()
    begin
        if Rec.Status = Rec.Status::"Pending for Approval" then
            PageEditable := false
        else
            PageEditable := true;


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
            PageEditable := false
        else
            PageEditable := true;


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
        EditBool: Boolean;
        itemjrnl: Record "Item Journal Line";

}

