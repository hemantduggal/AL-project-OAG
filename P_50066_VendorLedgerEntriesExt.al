pageextension 50066 VendorLedgerEntriesExt extends "Vendor Ledger Entries"
{
    layout
    {
        addbefore("Vendor No.")
        {
            field("EFT/Document No."; Rec."EFT/Document No.")
            {
                ApplicationArea = all;
            }
            field("Vendor Type"; Rec."Vendor Type")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addafter("Shortcut Dimension 4 Code")
        {

            field("Rem. Amt for WHT"; rec."Rem. Amt for WHT")
            {
                ApplicationArea = all;
            }
            field("Rem. Amt"; rec."Rem. Amt")
            {
                ApplicationArea = all;
            }
            field("WHT Amount"; rec."WHT Amount")
            {
                ApplicationArea = all;
            }
            field("WHT Amount (LCY)"; rec."WHT Amount (LCY)")
            {
                ApplicationArea = all;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Vendor Ledger Entry", '%1', UserSetup."Vendor Ledger Entry"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the Vendor Ledger Entry');

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Vendor Ledger Entry", '%1', UserSetup."Vendor Ledger Entry"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //  ERROR('You do not have Permission to Change Purchase Quote Details');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Vendor Ledger Entry", '%1', UserSetup."Vendor Ledger Entry"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //    ERROR('You do not have Permission to Change Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Vendor Ledger Entry", '%1', UserSetup."Vendor Ledger Entry"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);


        //   ERROR('You do not have Permission to add new Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Vendor Ledger Entry", '%1', UserSetup."Vendor Ledger Entry"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Vendor Ledger Entry", '%1', UserSetup."Vendor Ledger Entry"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Vendor Ledger Entry');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Vendor Ledger Entry", '%1', UserSetup."Vendor Ledger Entry"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;


    var
        UserSetup: Record 91;

}
