pageextension 50040 PurchaseOrderExt extends "Purchase Order"
{
    layout
    {
        moveafter(Status; "Location Code")
        modify("Buy-from Vendor No.")
        {
            Editable = edi;
            trigger OnAfterValidate()
            var
                loc: Record Location;
            begin
                loc.SetRange("Store location", true);
                if loc.FindFirst() then begin
                    rec.Validate("Location Code", loc.Code);
                    rec.Modify();
                end;
            end;
        }
        modify("Buy-from Vendor Name")
        {
            Editable = edi;
        }
        modify("Currency Code")
        {
            Editable = false;
        }
        modify("Buy-from Address")
        {
            Editable = false;
        }
        modify("Buy-from City")
        {
            Editable = false;
        }
        modify("Buy-from Post Code")
        {
            Editable = false;
        }
        modify("Buy-from Country/Region Code")
        {
            Editable = false;
        }
        modify("Posting Date")
        {
            Editable = edi;
        }
        modify("Document Date")
        {
            Editable = edi;
        }
        modify("Due Date")
        {
            Editable = edi;
        }
        modify("Vendor Invoice No.")
        {
            Editable = edi;
        }
        modify("Purchaser Code")
        {
            Editable = edi;
        }
        modify("Order Date")
        {
            Editable = edi;
        }
        modify("Vendor Order No.")
        {
            Visible = false;
        }
        modify("Vendor Shipment No.")
        {
            Visible = false;
        }
        addafter(Status)
        {
            field("Purchase Type"; Rec."Purchase Type")
            {
                ShowMandatory = true;
                Editable = edi;
                ApplicationArea = all;
            }
            field("Receiving No."; Rec."Receiving No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Requisition Slip No."; Rec."Requisition Slip No.")
            {
                LookupPageId = 50048;
                Editable = edi;
                ApplicationArea = all;

            }
            field("Reference No."; Rec."Reference No.")
            {
                Editable = edi;
                ApplicationArea = all;
            }
            field("Reason Code"; Rec."Reason Code")
            {
                Editable = edi;
                ApplicationArea = all;
            }
            field("Short Close"; Rec."Short Close")
            {
                Editable = edi;
                ApplicationArea = all;
            }
            field("Subject of Procurement"; Rec."Subject of Procurement")
            {
                Editable = edi;
                ApplicationArea = all;
            }
            field("Vendor Type"; Rec."Vendor Type")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("WHT Business Posting Group"; rec."WHT Business Posting Group")
            {
                Editable = edi;
                ShowMandatory = true;
                Applicationarea = All;
            }
            field("approver's comment"; Rec."approver's comment")
            {
                ApplicationArea = all;
                Editable = editabl;
            }
        }
        modify("Shipment Method Code")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("On Hold")
        {
            Visible = false;
        }
        modify("Inbound Whse. Handling Time")
        {
            Visible = false;
        }
        addafter("Invoice Details")
        {
            group("Terms and Conditions")
            {
                Caption = 'Purchase Terms & Conditions (OAG)';
                field("Details T&C (Attach)"; Rec."Details T&C (Attach)")
                {
                    Editable = edi;
                    ApplicationArea = all;
                }
                field("General T&C"; Rec."General T&C")
                {
                    Editable = edi;
                    ApplicationArea = all;
                }
                field("Special T&C "; Rec."Special T&C ")
                {
                    Editable = edi;
                    ApplicationArea = all;
                }
            }
        }
        addafter("Terms and Conditions")
        {
            group("Visual Inspection Details")
            {
                Caption = 'Goods, & Services Validation Comments';
                field(StoreApprover; Rec.StoreApprover)
                {
                    Editable = edi;
                    ShowMandatory = true;
                    ApplicationArea = all;
                    Caption = 'Inventory Officer';
                    trigger OnValidate()
                    var
                        line: Record "Purchase Line";
                    begin
                        line.reset();
                        line.SetRange("Document No.", Rec."No.");
                        if line.FindSet() then
                            repeat
                                if line.Type <> line.Type::Item then
                                    Error('Not Required');
                            until line.Next() = 0;
                    end;
                }
                field("Store Admin Comment"; Rec."Store Admin Comment")
                {
                    Editable = edi;
                    ApplicationArea = all;
                    Caption = 'Inventory Officer Comment';
                    trigger OnValidate()
                    var
                        line: Record "Purchase Line";
                    begin
                        line.reset();
                        line.SetRange("Document No.", Rec."No.");
                        if line.FindSet() then
                            repeat
                                if line.Type <> line.Type::Item then
                                    Error('Not Required');
                            until line.Next() = 0;
                    end;
                }
                field("Store_Visual Date"; Rec."Store_Visual Date")
                {
                    Caption = 'Inventory Officer Visual Date';
                    Editable = edi;
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        line: Record "Purchase Line";
                    begin
                        line.reset();
                        line.SetRange("Document No.", Rec."No.");
                        if line.FindSet() then
                            repeat
                                if line.Type <> line.Type::Item then
                                    Error('Not Required');
                            until line.Next() = 0;
                    end;
                }
                field(Store_Accepted; Rec.Store_Accepted)
                {
                    Caption = 'Inventory Officer Accept';
                    Editable = edi;
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        line: Record "Purchase Line";
                    begin
                        line.reset();
                        line.SetRange("Document No.", Rec."No.");
                        if line.FindSet() then
                            repeat
                                if line.Type <> line.Type::Item then
                                    Error('Not Required');
                            until line.Next() = 0;
                    end;
                }
                field(Store_Rejected; Rec.Store_Rejected)
                {
                    Caption = 'Inventory Officer Reject';
                    Editable = edi;
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        line: Record "Purchase Line";
                    begin
                        line.reset();
                        line.SetRange("Document No.", Rec."No.");
                        if line.FindSet() then
                            repeat
                                if line.Type <> line.Type::Item then
                                    Error('Not Required');
                            until line.Next() = 0;
                    end;
                }
                field("Store_File Attachment Link"; Rec."Store_File Attachment Link")
                {
                    Caption = 'Inventory File Attachment Link';
                    Editable = edi;
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        line: Record "Purchase Line";
                    begin
                        line.reset();
                        line.SetRange("Document No.", Rec."No.");
                        if line.FindSet() then
                            repeat
                                if line.Type <> line.Type::Item then
                                    Error('Not Required');
                            until line.Next() = 0;
                    end;
                }
                field(ContractorApprover; Rec.ContractorApprover)
                {
                    Caption = 'Contract Manager';
                    Editable = edi;
                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field("Contract Admin Comment"; Rec."Contract Admin Comment")
                {
                    Caption = 'Contract Managers Comment';
                    Editable = edi;
                    ApplicationArea = all;
                }
                field("Contract_Visual Date"; Rec."Contract_Visual Date")
                {
                    Caption = 'Contract Manager Visual Date';
                    Editable = edi;
                    ApplicationArea = all;
                }
                field(Contract_Accepted; Rec.Contract_Accepted)
                {
                    Caption = 'Contract Manager Accept';
                    Editable = edi;
                    ApplicationArea = all;
                }
                field(Contract_Rejected; Rec.Contract_Rejected)
                {
                    Caption = 'Contract Manager Reject';
                    Editable = edi;
                    ApplicationArea = all;
                }
                field("Contract_File Attachment Link"; Rec."Contract_File Attachment Link")
                {
                    Caption = 'Contract File Attachment Link';
                    Editable = edi;
                    ApplicationArea = all;
                }
                field(InternalApprover; Rec.InternalApprover)
                {
                    Caption = 'Internal Audit';
                    Editable = edi;
                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field("Internal Admin Comment"; Rec."Internal Admin Comment")
                {
                    Caption = 'Internal Audit Comment';
                    Editable = edi;
                    ApplicationArea = all;
                }
                field("Internal_Visual Date"; Rec."Internal_Visual Date")
                {
                    Caption = 'Internal Audit Date';
                    Editable = edi;
                    ApplicationArea = all;
                }
                field(Internal_Accepted; Rec.Internal_Accepted)
                {
                    Caption = 'Internal Audit Accept';
                    Editable = edi;
                    ApplicationArea = all;
                }
                field(Internal_Rejected; Rec.Internal_Rejected)
                {
                    Caption = 'Internal Audit Reject';
                    Editable = edi;
                    ApplicationArea = all;
                }
                field("Internal_File Attachment Link"; Rec."Internal_File Attachment Link")
                {
                    Caption = 'Internal File Attachment Link';
                    Editable = edi;
                    ApplicationArea = all;
                }
            }
        }
        addbefore("VAT Bus. Posting Group")
        {
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                Editable = edi;
                Caption = 'TIN';
                ApplicationArea = all;
            }
        }
        modify("Location Code")
        {
            ShowMandatory = true;
        }
    }
    actions
    {
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                smtp: Codeunit smtpmail;
                user: Record "User Setup";
                noti: Record Notifications;
                attchment: Record 1173;
                purcline: Record "Purchase Line";
                line: Record "Purchase Line";
            begin
                line.reset();
                line.SetRange("Document No.", Rec."No.");
                if line.FindSet() then
                    repeat
                        if line.Type = line.Type::Item then begin
                            // Rec.TestField(Store_Accepted, true);
                            rec.TestField(StoreApprover);
                        end;
                        line.TestField("Shortcut Dimension 1 Code");
                        line.TestField("Shortcut Dimension 2 Code");
                    // line.TestField();
                    until line.Next() = 0;
                rec.TestField(ContractorApprover);
                rec.TestField(InternalApprover);
                rec.encumdate := CurrentDateTime;
                rec.Modify();
                attchment.Reset();
                attchment.SetRange("Table ID", 38);
                // attchment.SetRange("Document Type", attchment."Document Type"::Invoice);
                attchment.SetRange("No.", rec."No.");
                if not attchment.FindFirst() then
                    Error('There should an file attached with the invoice');
                user.Reset();
                if user.get(Rec.StoreApprover) then
                    smtp.sendmail('approval: ', Rec."No.", UserId, '', '', user."E-Mail", 'Approval request for PO no. :' + Rec."No." + 'has been initiated by :' + UserId);
                user.Reset();
                if user.get(Rec.ContractorApprover) then
                    smtp.sendmail('approval: ', Rec."No.", UserId, '', '', user."E-Mail", 'Approval request for PO no. :' + Rec."No." + 'has been initiated by :' + UserId);
                user.Reset();
                if user.get(Rec.InternalApprover) then
                    smtp.sendmail('approval require : ', Rec."No.", UserId, '', '', user."E-Mail", 'Approval request for PO no. :' + Rec."No." + 'has been initiated by :' + UserId);
                Rec.TestField("Buy-from Vendor No.");
                purcline.SetRange("Document Type", rec."Document Type");
                purcline.SetRange("Document No.", rec."No.");
                if purcline.FindFirst() then
                    repeat
                        purcline.TestField("Shortcut Dimension 1 Code");
                        purcline.TestField("Shortcut Dimension 2 Code");
                    until purcline.Next() = 0;
            end;

            trigger OnAfterAction()
            begin

            end;
        }
        addlast(processing)
        {
            group(ShortClose)
            {
                action("$Short Close")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;
                    Caption = 'Short Close';
                    Image = Close;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        rech: Record "Requisition Header";
                    begin
                        Rec."Short Close" := true;
                        rec.Modify();

                    end;
                }
            }
        }
        // modify(post)
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                line: Record "Purchase Line";
            begin
                rec.TestField("Location Code");
                rec.TestField("Document Date");
                rec.TestField("Purchase Type");
                rec.TestField("Currency Code");
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Order", '<>%1', UserSetup."Access Purchase Order"::Post);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Purchase Order');

                line.reset();
                line.SetRange("Document No.", Rec."No.");
                if line.FindSet() then
                    repeat
                        if line.Type = line.Type::Item then begin
                            Rec.TestField(Store_Accepted, true);
                            rec.TestField(StoreApprover);
                        end;
                        line.TestField("Shortcut Dimension 1 Code");
                        line.TestField("Shortcut Dimension 2 Code");
                    // line.TestField();
                    until line.Next() = 0;
                rec.TestField(ContractorApprover);
                rec.TestField(InternalApprover);
                Rec.TestField(Contract_Accepted, true);
                Rec.TestField(Internal_Accepted, true);
            end;

            trigger OnAfterAction()
            begin

            end;
        }
        modify(Release)
        {
            Visible = false;
        }
        modify(Reopen)
        {
            Visible = false;
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the Puchase Order');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::Post);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Purchase Order');
        //ERROR('You do not have Permission to Delete Purchase Quote');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //  ERROR('You do not have Permission to Change Purchase Quote Details');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //    ERROR('You do not have Permission to Change Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);


        //   ERROR('You do not have Permission to add new Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    var
        reqtoapp: Record "Approval Entry";
    begin

        if Rec.Status = Rec.Status::"Pending Approval" then
            edi := false
        else
            edi := true;

        reqtoapp.SetRange("Document No.", Rec."No.");
        if reqtoapp.FindFirst() then begin
            if reqtoapp."Approver ID" = UserId then
                editabl := true
            else
                editabl := false;
        end;


        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Purchase Order');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;




    var
        storedi: Boolean;
        edi: Boolean;
        editabl: Boolean;
        myInt: Integer;
        TextPartial: Label 'Document Short Closed, If require create new order for remaining Qty.  ';
        UserSetup: Record 91;
        PLQty: Decimal;
        RPurchLine: Record 39;
        RecLocation: Record 14;
        TotalRemainingQty: Decimal;
        TotalRemainingQty1: Decimal;
        ILE: Record 32;
        GeneralLedgerSetup: Record 98;
        GSTLocRegNo: Boolean;
        IsRateChangeEnabled: Boolean;
        ReferenceInvoiceNoErr: Label 'You cannot select Non GST document to GST Docment.';
        ReferenceNoErr: Label 'Reference Invoice No is  required where Invoice Type is Debit Note and Supplementary.';
        PurchaseHeader: Record 38;
        PostingDate: Date;
        CheckApprovalEntry: Record 454;
        DeleteApprovalEntry: Record 454;
        BrokerageEdit: Boolean;
        Location: Record 14;
        c: Codeunit 444;
        store: Boolean;
}