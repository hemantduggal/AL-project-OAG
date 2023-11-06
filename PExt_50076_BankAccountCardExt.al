pageextension 50076 bankaccountcardext extends "Bank Account Card"
{
    layout
    {
        modify("No.")
        {

            trigger OnAfterValidate()
            begin

            end;
            //  field(Status; Rec.Status)
            //  {
            //      ApplicationArea = all;
            //  }
        }
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
        bank: Record "Bank Account";
        pag: page "Bank Account Card masked";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Bank Master", '%1', UserSetup."Bank Master"::Blocked);
        IF UserSetup.FINDFIRST THEN begin
            CurrPage.Close();
            bank.CopyFilters(Rec);
            pag.SetTableView(bank);
            pag.Run();
            Error('');
        end;

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Bank Master", '%1', UserSetup."Bank Master"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Bank Master');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Bank Master", '%1', UserSetup."Bank Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);

    end;


    var
        UserSetup: Record 91;
}