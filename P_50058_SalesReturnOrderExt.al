pageextension 50058 SalesReturnOrderExt extends "Sales Return Order"
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
        UserSetup.SETFILTER(UserSetup."Access Sales Return Order", '%1', UserSetup."Access Sales Return Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Delete the Sales Return Order.');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Return Order", '%1', UserSetup."Access Sales Return Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Return Order", '%1', UserSetup."Access Sales Return Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change the Sales Return Order Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Return Order", '%1', UserSetup."Access Sales Return Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;


    var
        myInt: Integer;
        SalesLine: Record "Sales Line";
        UserSetup: Record 91;
        GSTLocRegNo: Boolean;
        ReferenceInvoiceNoErr: Label 'You cannot select Non GST document to GST Docment.';
        Location: Record 14;
}