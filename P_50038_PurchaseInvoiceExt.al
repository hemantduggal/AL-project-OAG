pageextension 50038 PurchaseInvoiceExt extends "Purchase Invoice"
{
    layout
    {
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
        addafter("Buy-from Vendor Name")
        {
            field("Vendor Type"; Rec."Vendor Type")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addafter(status)
        {
            field("WHT Business Posting Group"; Rec."WHT Business Posting Group")
            {
                ApplicationArea = all;
            }
        }
        modify("Currency Code")
        {
            Editable = false;
        }
    }


    actions
    {
        modify(SendApprovalRequest)
        {
            trigger OnAfterAction()
            begin
                rec.encumdate := CurrentDateTime;
                rec.Modify();
            end;
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                attchment: Record 1173;
            begin
                attchment.Reset();
                attchment.SetRange("Table ID", 38);
                attchment.SetRange("Document Type", attchment."Document Type"::Invoice);
                attchment.SetRange("No.", rec."No.");
                if not attchment.FindFirst() then
                    if rec."Vendor Type" = rec."Vendor Type"::Staff then
                        Error('There should an file attached with the invoice');
                rec.TestField("Currency Code");
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase invoice", '<>%1', UserSetup."Access Purchase invoice"::Post);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Purchase invoice')
            end;
        }
        addafter(Post)
        {
            action(FindIncosistency)
            {
                // ApplicationArea = all;
                // Promoted = true;
                // PromotedCategory = Process;
                RunObject = codeunit 50050;
            }
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
        UserSetup.SETFILTER(UserSetup."Access Purchase invoice", '%1', UserSetup."Access Purchase invoice"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the Puchase invoice');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase invoice", '%1', UserSetup."Access Purchase invoice"::Post);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Purchase invoice');
        //ERROR('You do not have Permission to Delete Purchase Quote');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase invoice", '%1', UserSetup."Access Purchase invoice"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //  ERROR('You do not have Permission to Change Purchase Quote Details');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase invoice", '%1', UserSetup."Access Purchase invoice"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //    ERROR('You do not have Permission to Change Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase invoice", '%1', UserSetup."Access Purchase invoice"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);


        //   ERROR('You do not have Permission to add new Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase invoice", '%1', UserSetup."Access Purchase invoice"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase invoice", '%1', UserSetup."Access Purchase invoice"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Purchase invoice');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase invoice", '%1', UserSetup."Access Purchase invoice"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;



    var
        myInt: Integer;

        PurchLine: Record "Purchase Line";
        UserSetup: Record 91;
        GSTLocRegNo: Boolean;
        IsRateChangeEnabled: Boolean;
        PurchaseHeader: Record 38;
        PostingDate: Date;
        PurchaseOrder: Page 50;
        PurchSetup: Record 312;
        Location: Record 14;


}