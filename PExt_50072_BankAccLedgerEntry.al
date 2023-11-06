pageextension 50072 BankAccLedgerExt extends "Bank Account Ledger Entries"
{
    layout
    {
        addbefore("Bank Account No.")
        {
            field("EFT/Document No."; Rec."EFT/Document No.")
            {
                ApplicationArea = all;
            }
        }
    }
    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Bank Ledger Entry", '%1', UserSetup."Bank Ledger Entry"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the Bank Ledger Entry');

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Bank Ledger Entry", '%1', UserSetup."Bank Ledger Entry"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //  ERROR('You do not have Permission to Change Purchase Quote Details');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Bank Ledger Entry", '%1', UserSetup."Bank Ledger Entry"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //    ERROR('You do not have Permission to Change Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Bank Ledger Entry", '%1', UserSetup."Bank Ledger Entry"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);


        //   ERROR('You do not have Permission to add new Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Bank Ledger Entry", '%1', UserSetup."Bank Ledger Entry"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Bank Ledger Entry", '%1', UserSetup."Bank Ledger Entry"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Bank Ledger Entry');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Bank Ledger Entry", '%1', UserSetup."Bank Ledger Entry"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
}