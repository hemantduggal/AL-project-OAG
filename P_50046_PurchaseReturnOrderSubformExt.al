pageextension 50046 PurchaseReturnOrderSubformExt extends "Purchase Return Order Subform"
{
    layout
    {
        addafter("No.")
        {

        }
    }


    trigger OnDeleteRecord(): Boolean

    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Return Order", '%1', UserSetup."Access Purchase Return Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Return Order", '%1', UserSetup."Access Purchase Return Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to create Purchase Return Order');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Return Order", '%1', UserSetup."Access Purchase Return Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to modify Purchase Return Order Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Return Order", '%1', UserSetup."Access Purchase Return Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to create Purchase Return Order');
        //PRU_DD 1.10

    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
}