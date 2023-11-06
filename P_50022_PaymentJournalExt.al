pageextension 50022 PaymentJournalExt extends "Payment Journal"
{
    layout
    {
        addafter("Amount (LCY)")
        {
            field("WHT Business Posting Group"; Rec."WHT Business Posting Group")
            {
                Caption = 'WHT Bus. Posting Group';
                // ApplicationArea = all;
            }
            field("WHT Product Posting Group"; Rec."WHT Product Posting Group")
            {
                Caption = 'WHT Prod. Posting Group';
                // ApplicationArea = all;
            }
        }
        addbefore("Account Type")
        {
            field(bankaccount; Rec.bankaccount)
            {
                ApplicationArea = all;
            }
            field("EFT/Document No."; Rec."EFT/Document No.")
            {
                ApplicationArea = all;
            }
        }
        modify("Recipient Bank Account")
        {
            trigger OnBeforeValidate()
            var
                VendBanA: Record "Vendor Bank Account";
            begin
                if VendBanA.Get(rec."Recipient Bank Account") then begin
                    if VendBanA.Status <> VendBanA.Status::Released then
                        Error('Status must be released');
                end;
            end;
        }
        modify("Account No.")
        {
            trigger OnAfterValidate()
            var
                VendBanA: Record "Vendor Bank Account";
                payjrnl: Record "Gen. Journal Line";
                bank: Record "Bank Account";
            begin
                // VendBanA.Reset();
                // VendBanA.SetRange("Vendor No.", payjrnl."Account No.");
                // if VendBanA.FindFirst() then begin
                //     if payjrnl."Bal. Account Type" = payjrnl."Bal. Account Type"::"Bank Account" then
                //         if (VendBanA.Status = VendBanA.Status::open) or (VendBanA.Status = VendBanA.Status::rejected) then;
                //     Error('Status of Account No. should be released from Vendor Bank Account');
                // end;

            end;
        }
    }
    actions
    {
        modify(SendApprovalRequestJournalBatch)
        {
            trigger OnAfterAction()
            var
                user: Record "User Setup";
                smtp: Codeunit smtpmail;
            begin
                // if user.get(Rec."User") then
                //     smtp.sendmail('Approved : ', rec."Journal Batch Name", UserId, '', '', user."E-Mail", 'Catering Requisition approved :' + Rec."Journal Batch Name");
                // Message('Done');
            end;
        }
        modify(CancelApprovalRequestJournalBatch)
        {
            trigger OnAfterAction()
            var
                RestrictedRecord: Record "Restricted Record";
                RecRef: RecordRef;
                post: Codeunit "Gen. Jnl.-Post Batch";
            begin
                RecRef.GetTable(Rec);
                RestrictedRecord.SetRange("Record ID", RecRef.RecordId);
                RestrictedRecord.LockTable(true);
                RestrictedRecord.DeleteAll(true);
            end;
        }
        modify(SuggestVendorPayments)
        {
            Visible = false;
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                // if Rec."Applies-to Doc. No." = '' then
                //     Error('Applies-to Doc. No. must have a value');
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Payment Journal", '<>%1', UserSetup."Access Payment Journal"::Post);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Payment Journal')
            end;
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Payment Journal", '%1', UserSetup."Access Payment Journal"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the Payment Journal');

        // UserSetup.RESET;
        // UserSetup.SETRANGE("User ID", USERID);
        // UserSetup.SETFILTER(UserSetup."Access Payment Journal", '%1', UserSetup."Access Payment Journal"::Post);
        // IF UserSetup.FINDFIRST THEN
        //     ERROR('You do not have permission to open Payment Journal');
        //ERROR('You do not have Permission to Delete Purchase Quote');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Payment Journal", '%1', UserSetup."Access Payment Journal"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //  ERROR('You do not have Permission to Change Purchase Quote Details');
        // Rec."Applies-to Doc. Type" := Rec."Applies-to Doc. Type"::Invoice;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Payment Journal", '%1', UserSetup."Access Payment Journal"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //    ERROR('You do not have Permission to Change Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Payment Journal", '%1', UserSetup."Access Payment Journal"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);


        //   ERROR('You do not have Permission to add new Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Payment Journal", '%1', UserSetup."Access Payment Journal"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Payment Journal", '%1', UserSetup."Access Payment Journal"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Payment Journal');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Payment Journal", '%1', UserSetup."Access Payment Journal"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        EnableBankChargePage: Boolean;
}