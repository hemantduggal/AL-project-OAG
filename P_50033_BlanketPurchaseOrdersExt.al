pageextension 50033 BlanketPurchaseOrdersExt extends "Blanket Purchase Orders"
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
        UserSetup.SETFILTER(UserSetup.BlanketPurchaseOrder, '%1', UserSetup.BlanketPurchaseOrder::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.BlanketPurchaseOrder, '%1', UserSetup.BlanketPurchaseOrder::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Blanket Purchase Order');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.BlanketPurchaseOrder, '%1', UserSetup.BlanketPurchaseOrder::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.BlanketPurchaseOrder, '%1', UserSetup.BlanketPurchaseOrder::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change Blanket Purchase Order');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.BlanketPurchaseOrder, '%1', UserSetup.BlanketPurchaseOrder::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    var
        UserSetup: Record 91;
}