pageextension 50055 SalesInvoiceSubformExt extends "Sales Invoice Subform"
{
    layout
    {
        addafter("Line No.")
        {
            field("WHT Business Posting Group"; Rec."WHT Business Posting Group")
            {
                ApplicationArea = all;
            }
            field("WHT Product Posting Group"; Rec."WHT Product Posting Group")
            {
                ApplicationArea = all;
            }
            field("WHT Absorb Base"; Rec."WHT Absorb Base")
            {
                ApplicationArea = all;
            }
        }
    }


    trigger OnAfterGetCurrRecord()
    begin

    end;

    trigger OnAfterGetRecord()
    begin

    end;

    trigger OnDeleteRecord(): Boolean
    var

    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to delete Sales Invoice');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to Enter Sales Invoice Details');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to Change Sales Invoice Details');
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin

    end;

    var
        myInt: Integer;

        UserSetup: Record 91;
        GeneralLedgerSetup: Record 98;
        SampVisible: Boolean;
        Bool: Boolean;
}