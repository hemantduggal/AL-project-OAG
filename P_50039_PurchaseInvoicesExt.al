pageextension 50039 PurchaseInvoicesExt extends "Purchase Invoices"
{
    layout
    {
        addafter("No.")
        {

        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
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

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase invoice", '%1', UserSetup."Access Purchase invoice"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change Purchase invoice Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase invoice", '%1', UserSetup."Access Purchase invoice"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;




    var
        myInt: Integer;
        UserSetup: Record 91;
}