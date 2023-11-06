pageextension 50097 GLRegisterExt extends 116
{
    layout
    {
        addafter("Creation Date")
        {
            field("From WHT Entry No."; rec."From Entry No.")
            {
                ApplicationArea = all;
            }
            field("To WHT Entry No."; rec."To WHT Entry No.")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."G/L Register", '%1', UserSetup."G/L Register"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the G/L Register');

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."G/L Register", '%1', UserSetup."G/L Register"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //  ERROR('You do not have Permission to Change Purchase Quote Details');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."G/L Register", '%1', UserSetup."G/L Register"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //    ERROR('You do not have Permission to Change Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."G/L Register", '%1', UserSetup."G/L Register"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);


        //   ERROR('You do not have Permission to add new Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."G/L Register", '%1', UserSetup."G/L Register"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."G/L Register", '%1', UserSetup."G/L Register"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open G/L Register');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."G/L Register", '%1', UserSetup."G/L Register"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;


    var
        UserSetup: Record 91;
}