pageextension 50089 CurrencyCardExt extends 495
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.Currencies, '%1', UserSetup.Currencies::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the Currency');

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.Currencies, '%1', UserSetup.Currencies::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //  ERROR('You do not have Permission to Change Purchase Quote Details');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.Currencies, '%1', UserSetup.Currencies::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //    ERROR('You do not have Permission to Change Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.Currencies, '%1', UserSetup.Currencies::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);


        //   ERROR('You do not have Permission to add new Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.Currencies, '%1', UserSetup.Currencies::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.Currencies, '%1', UserSetup.Currencies::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Currency');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.Currencies, '%1', UserSetup.Currencies::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;


    var
        UserSetup: Record 91;
}