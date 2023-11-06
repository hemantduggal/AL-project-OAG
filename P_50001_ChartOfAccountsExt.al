pageextension 50001 ChartOfAccountsExt extends "Chart of Accounts"
{
    layout
    {
        addbefore("No.")
        {
            field(newstr; newstr)
            {
                Style = Strong;
                ApplicationArea = all;
                trigger OnDrillDown()
                var
                    recref: RecordRef;
                begin
                    page.run(page::"G/L Account Card", rec);
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Chart of Account", '%1', UserSetup."Chart of Account"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Chart of Account", '%1', UserSetup."Chart of Account"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Chart of Account');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Chart of Account", '%1', UserSetup."Chart of Account"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Chart of Account", '%1', UserSetup."Chart of Account"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change Chart of Account Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Chart of Account", '%1', UserSetup."Chart of Account"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        // PRU_DD 1.10
    end;

    trigger OnAfterGetRecord()
    begin
        clear(newstr);
        newstr := CopyStr(rec."No.", 8, 6);
        // newstr := '•••••••' + newstr;
        // Rec.RecordId;
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        newstr: text;
}