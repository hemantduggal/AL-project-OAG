pageextension 50010 GeneralJournalExt extends "General Journal"
{
    layout
    {
        addbefore("Document Type")
        {
            field("EFT/Document No."; Rec."EFT/Document No.")
            {
                ApplicationArea = all;
            }
        }
        addafter(Comment)
        {
            field("WHT Business Posting Group"; rec."WHT Business Posting Group")
            {
                ApplicationArea = all;
            }
            field("WHT Product Posting Group"; rec."WHT Product Posting Group")
            {
                ApplicationArea = all;
            }
            field("WHT Absorb Base"; rec."WHT Absorb Base")
            {
                ApplicationArea = all;
            }
            field("WHT Entry No."; rec."WHT Entry No.")
            {
                ApplicationArea = all;
            }
            field("WHT Report Line No."; rec."WHT Report Line No.")
            {
                ApplicationArea = all;
            }
            field("Skip WHT"; rec."Skip WHT")
            {
                ApplicationArea = all;
            }
            field("Certificate Printed"; rec."Certificate Printed")
            {
                ApplicationArea = all;
            }
            field("WHT Payment"; rec."WHT Payment")
            {
                ApplicationArea = all;
            }
            /*  field("Actual Vendor No."; rec."Actual Vendor No.")
              {
                  ApplicationArea = all;
              }*/
            field("Is WHT"; rec."Is WHT")
            {
                ApplicationArea = all;
            }
            field("Interest Amount"; rec."Interest Amount")
            {
                ApplicationArea = all;
            }
            field("Interest Amount (LCY)"; rec."Interest Amount (LCY)")
            {
                ApplicationArea = all;
            }
        }
    }


    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                smtp: Codeunit smtpmail;
                user: Record "User Setup";
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access General Journals", '<>%1', UserSetup."Access General Journals"::Post);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post General Journals');
                /*  user.Reset();
                  if user.get(Rec."User") then
                      smtp.sendmail('Approved : ', rec."No.", UserId, '', '', user."E-Mail", 'Catering Requisition approved :' + Rec."No.");
                  Message('Done');
  */

            end;
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access General Journals", '%1', UserSetup."Access General Journals"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the General Journals');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access General Journals", '%1', UserSetup."Access General Journals"::Post);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open General Journals');
        //ERROR('You do not have Permission to Delete Purchase Quote');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access General Journals", '%1', UserSetup."Access General Journals"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //  ERROR('You do not have Permission to Change Purchase Quote Details');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access General Journals", '%1', UserSetup."Access General Journals"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //    ERROR('You do not have Permission to Change Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access General Journals", '%1', UserSetup."Access General Journals"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);


        //   ERROR('You do not have Permission to add new Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access General Journals", '%1', UserSetup."Access General Journals"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access General Journals", '%1', UserSetup."Access General Journals"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open General Journals');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access General Journals", '%1', UserSetup."Access General Journals"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        IsRateChangeEnabled: Boolean;
        GLAccount: Record 15;
        GenJournal1: Record 81;
        CurrentJnlBatchName: Code[10];
}
