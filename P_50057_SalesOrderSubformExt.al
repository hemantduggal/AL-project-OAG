pageextension 50057 SalesOrderSubformExt extends "Sales Order Subform"
{
    layout
    {
        modify(Type)
        {
            trigger OnAfterValidate()
            begin
                if Rec.Type = Rec.Type::" " then
                    editb := false
                else
                    editb := true;
            end;
        }
        modify("No.")
        {
            Editable = editb;
        }
        modify("Location Code")
        {
            Editable = editb;
        }
        modify(Quantity)
        {
            Editable = editb;
        }
        modify("Unit Price")
        {
            Editable = editb;
        }
        modify("Qty. to Assemble to Order")
        {
            Editable = editb;
        }
        modify("Reserved Quantity")
        {
            Editable = editb;
        }
        modify("Unit of Measure")
        {
            Editable = editb;
        }
        modify("Line Discount %")
        {
            Editable = editb;
        }
        modify("Line Amount")
        {
            Editable = editb;
        }
        modify("Qty. to Ship")
        {
            Editable = editb;
        }
        modify("Qty. to Invoice")
        {
            Editable = editb;
        }
        modify("Item Reference No.")
        {
            Editable = editb;
        }
        addafter("Line No.")
        {
            field("WHT Business Posting Group"; rec."WHT Business Posting Group")
            {
                ApplicationArea = all;
            }
            field("WHT Product Posting Group"; rec."WHT Product Posting Group")
            {
                ApplicationArea = all;
            }
            field("WHT Absorb Base"; rec."WHT Absorb Base")
            {
                ApplicationArea = all;
            }
        }
    }


    trigger OnAfterGetCurrRecord()
    begin
    end;



    trigger OnDeleteRecord(): Boolean
    var

    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to delete new sales order');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to insert new sales order');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to modify new sales order');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to insert new sales order');
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Sales Order');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10



        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        // UserSetup.SETRANGE("Salesperson User", TRUE);
        IF UserSetup.FINDFIRST THEN
            Editable := FALSE
        ELSE
            Editable := TRUE;


    end;



    var
        editb: Boolean;
        GeneralLedgerSetup: Record 98;
        SampVisible: Boolean;
        UserSetup: Record 91;
        Editable: Boolean;
        Bool: Boolean;
        QuantitynotInvoiced: Decimal;
        qty: Decimal;
        SalesLineG: Record 37;
        Headerqty: Decimal;
        ApprovalEntry: Record 454;
        DiscountEdit: Boolean;
        myInt: Integer;
}