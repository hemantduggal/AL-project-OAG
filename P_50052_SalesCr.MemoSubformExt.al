pageextension 50052 SalesCrMemoSubformExt extends "Sales Cr. Memo Subform"
{
    layout
    {
        addafter("No.")
        {

        }
    }


    trigger OnDeleteRecord(): Boolean
    var

    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to Delete Sales Credit Memo');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to Create Sales Credit Memo');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to Change Sales Credit Memo Details');
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        Bool: Boolean;
        Bool1: Boolean;
}