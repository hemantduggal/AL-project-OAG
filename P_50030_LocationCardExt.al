pageextension 50030 LocationCardExt extends "Location Card"
{
    layout
    {
        addafter(Name)
        {
            field("Store location"; Rec."Store location")
            {
                ApplicationArea = all;
            }
        }
    }





    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the Location Master');

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    var
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Location Master');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);

    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        HasIncomingDocument: Boolean;
        // Checklist: Record "Farmer Check List";
        userset: Record 91;
        BoolTest: Boolean;
        BoolTest1: Boolean;
}