pageextension 50025 BlanketPurchaseOrderExt extends "Blanket Purchase Order"
{
    layout
    {
        addafter("Order Date")
        {
            // field("Expiry Date"; Rec.expirydate)
            // {
            //     Caption = 'Expiry Date';
            //     ApplicationArea = all;
            //     trigger OnValidate()
            //     var
            //         accperiod: Record "Accounting Period";
            //     begin
            //         if Rec.expirydate > accperiod.GetFiscalYearEndDate(Rec.expirydate) then
            //             error('Date is beyond current Accounting Period');
            //         if Rec.expirydate < accperiod.GetFiscalYearStartDate(Rec.expirydate) then
            //             Error('Date is before current Accounting Period');
            //     end;
            // }
            field(day; day)
            {
                Caption = 'Period of Contract';
                ApplicationArea = all;
            }
        }
        modify("Order Date")
        {
            Caption = 'Order Date/Creation Date';
        }
        modify("Currency Code")
        {
            Editable = false;
        }
        addafter(Status)
        {
            field("Purchase Type"; Rec."Purchase Type")
            {
                ApplicationArea = all;
            }
            field("Requisition Slip No."; Rec."Requisition Slip No.")
            {
                ApplicationArea = all;

            }
            field("Reference No."; Rec."Reference No.")
            {
                ApplicationArea = all;
            }
            field("Subject of Procurement"; Rec."Subject of Procurement")
            {
                ApplicationArea = all;
            }
            field("Vendor Type"; Rec."Vendor Type")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
    actions
    {
        modify(MakeOrder)
        {
            trigger OnBeforeAction()
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup.BlanketPurchaseOrder, '<>%1', UserSetup.BlanketPurchaseOrder::Post);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Blanket Purchase Order')
            end;
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.BlanketPurchaseOrder, '%1', UserSetup.BlanketPurchaseOrder::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the Blanket Purchase Order');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.BlanketPurchaseOrder, '%1', UserSetup.BlanketPurchaseOrder::Post);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Blanket Purchase Order');
        //ERROR('You do not have Permission to Delete Purchase Quote');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.BlanketPurchaseOrder, '%1', UserSetup.BlanketPurchaseOrder::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //  ERROR('You do not have Permission to Change Purchase Quote Details');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.BlanketPurchaseOrder, '%1', UserSetup.BlanketPurchaseOrder::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //    ERROR('You do not have Permission to Change Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.BlanketPurchaseOrder, '%1', UserSetup.BlanketPurchaseOrder::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);


        //   ERROR('You do not have Permission to add new Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnAfterGetRecord()
    begin
        if (Rec.expirydate <> 0D) then
            day := Rec.expirydate - Rec."Order Date";
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

    var
        myInt: Integer;
        UserSetup: Record 91;
        Text001: Label 'Do you wants to change Dimensions';
        NewLocation: Code[20];
        NewGlobalDim1: Code[20];
        NewGlobalDim2: Code[20];
        NewShortDim3: Code[20];
        day: Integer;
    //BlnktPurchOrdtoOrdYN: Codeunit 50052;

}