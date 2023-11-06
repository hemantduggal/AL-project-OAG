pageextension 50047 PurchCrMemoSubformExt extends "Purch. Cr. Memo Subform"
{
    layout
    {
        addafter("VAT Prod. Posting Group")
        {
            field("WHT Business Posting Group"; Rec."WHT Business Posting Group")
            {
                ApplicationArea = all;
            }
            field("WHT Product Posting Group"; Rec."WHT Product Posting Group")
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
        UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to Delete Purchase Credit Memo');

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to Enter Purchase Credit Memo Details');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to Change Purchase Credit Memo Details');
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
}