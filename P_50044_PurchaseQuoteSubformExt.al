pageextension 50044 PurchaseQuoteSubformExt extends "Purchase Quote Subform"
{
    layout
    {
        addbefore("Qty. to Assign")
        {
            field("Amount Inc VAT"; Rec."Amount Inc VAT")
            {
                ApplicationArea = all;
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var

    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Quote", '%1', UserSetup."Access Purchase Quote"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to delete Purchase Quote');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Quote", '%1', UserSetup."Access Purchase Quote"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to insert Purchase Quote');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Quote", '%1', UserSetup."Access Purchase Quote"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to modify Purchase Quote');
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
}