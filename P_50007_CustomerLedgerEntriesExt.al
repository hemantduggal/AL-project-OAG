pageextension 50007 CustomerLedgerEntriesExt extends "Customer Ledger Entries"
{
    layout
    {
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
            field("WHT Payment"; rec."WHT Payment")
            {
                ApplicationArea = all;
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Customer Ledger Entry", '%1', UserSetup."Customer Ledger Entry"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the Customer Ledger Entry');

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Customer Ledger Entry", '%1', UserSetup."Customer Ledger Entry"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //  ERROR('You do not have Permission to Change Purchase Quote Details');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Customer Ledger Entry", '%1', UserSetup."Customer Ledger Entry"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //    ERROR('You do not have Permission to Change Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Customer Ledger Entry", '%1', UserSetup."Customer Ledger Entry"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);


        //   ERROR('You do not have Permission to add new Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Customer Ledger Entry", '%1', UserSetup."Customer Ledger Entry"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Customer Ledger Entry", '%1', UserSetup."Customer Ledger Entry"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Customer Ledger Entry');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Customer Ledger Entry", '%1', UserSetup."Customer Ledger Entry"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        ReverseTransVisible: Boolean;

}