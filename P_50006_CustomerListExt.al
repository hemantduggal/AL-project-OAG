pageextension 50006 CustomerListsExt extends "Customer List"
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
        UserSetup.SETFILTER(UserSetup."Access Customer Master", '%1', UserSetup."Access Customer Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Customer Master", '%1', UserSetup."Access Customer Master"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Customer Master');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Customer Master", '%1', UserSetup."Access Customer Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Customer Master", '%1', UserSetup."Access Customer Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change Customer Master Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Customer Master", '%1', UserSetup."Access Customer Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    var
        myInt: Integer;
        UserSetup: Record "User Setup";
        ColourCondition: Boolean;
        Customer: Record 18;
        BalanceView: Boolean;
        VisibleStatics: Boolean;
}