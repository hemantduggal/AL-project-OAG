pageextension 50023 BankAccountListExt extends "Bank Account List"
{
    layout
    {

    }


    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Bank Master", '%1', UserSetup."Bank Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the Bank Master');

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Bank Master", '%1', UserSetup."Bank Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Bank Master", '%1', UserSetup."Bank Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Bank Master", '%1', UserSetup."Bank Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Bank Master", '%1', UserSetup."Bank Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    var
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Bank Master", '%1', UserSetup."Bank Master"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Bank Master');
        // UserSetup.RESET;
        // UserSetup.SETRANGE("User ID", USERID);
        // UserSetup.setrange(UserSetup."Bank Master", UserSetup."Bank Master"::Blocked);
        // IF UserSetup.FINDFIRST THEN begin
        //     ERROR('You do not have permission to open Bank Master');
        //     CurrPage.Close();
        // end;

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Bank Master", '%1', UserSetup."Bank Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);

    end;


    var
        UserSetup: Record 91;
}