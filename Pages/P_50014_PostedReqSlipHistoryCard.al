page 50014 "Posted ReqSlip History Card"
{
    Caption = 'Posted Requisition Slip History Card';
    PageType = Card;
    PopulateAllFields = true;
    SourceTable = "Requisition Header";
    Editable = false;
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
                    trigger OnAssistEdit()
                    begin
                        if rec.AssistEdit(xRec) then
                            CurrPage.Update(false);
                    end;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                    Caption = 'Subject Matter';//neha11-11-22
                }
                field("Requested User ID"; rec."Requested User ID")
                {
                    ApplicationArea = all;
                }
                field("Request Date"; rec."Request Date")
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Short Close"; Rec."Short Close")
                {
                    ApplicationArea = all;
                }
                field("Short Close Date"; Rec."Short Close Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Department; rec.Department)
                {
                    ApplicationArea = all;
                    Caption = 'Department Code';//15-11/22 hillary
                    ShowMandatory = true;  //neha11-11-22
                }
                field("1st Approved/Rejected User ID"; rec."1st Approved/Rejected User ID")
                {
                    ApplicationArea = all;
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
                }
                field("2nd Approver"; rec."2nd Approver")
                {
                    ApplicationArea = all;
                    Visible = false; //neha11-11-22
                }
                field("2nd Approved/Rejected User ID"; rec."2nd Approved/Rejected User ID")
                {
                    ApplicationArea = all;
                }
                field("2nd Approved/Rejected Date"; rec."2nd Approved/Rejected Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("2nd Reject Comment"; rec."2nd Reject Comment")
                {
                    ApplicationArea = all;
                }
                field("Store Location"; rec."Store Location")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;//15/11/22
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }

            }

            group("Lines")
            {
                Caption = 'Lines';
                part(RequisitionLine; "RequisitionSubForm")
                {
                    SubPageLink = "Requisition Slip No." = FIELD("Requisition Slip No.");
                    ApplicationArea = All;
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

                begin
                    rec.TestField("Store Location");
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
                    begin
                        IF ApprovalsMgmt.CheckRequisitionApprovalsWorkflowEnabled(Rec) THEN
                            ApprovalsMgmt.OnSendRequisitionForApproval(Rec);


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

                        ApprovalsMgmt.OnCancelRequisitionMasterForApproval(Rec);
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


}

