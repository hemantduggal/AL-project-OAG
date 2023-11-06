pageextension 50056 SalesOrderExt extends "Sales Order"
{
    layout
    {
        addafter(Status)
        {
            field("WHT Business Posting Group"; rec."WHT Business Posting Group")
            {
                ApplicationArea = All;
            }
        }
        modify("Sell-to Address")
        {
            Editable = false;
        }
        modify("Sell-to Address 2")
        {
            Editable = false;
        }
        modify("Sell-to City")
        {
            Editable = false;
        }
        modify("Sell-to Contact")
        {
            Editable = false;
        }
        modify("Sell-to Country/Region Code")
        {
            Editable = false;
        }
        modify("Sell-to County")
        {
            Editable = false;
        }
    }

    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                rec.testfield("Currency Code");
            end;
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Delete Sales Order');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to enter Sales Order Details');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to change Sales Order Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to create New Sales Order');
        //PRU_DD 1.10
    end;


    trigger OnOpenPage()
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        //  UserSetup.SETRANGE("Salesperson User", TRUE);
        IF UserSetup.FINDFIRST THEN
            Visible := FALSE
        ELSE
            Visible := TRUE;

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETRANGE(Department, UserSetup.Department::Accounts);
        UserSetup.SETRANGE("HO Users", TRUE);
        IF UserSetup.FINDFIRST THEN
            VisibleStatics := TRUE
        ELSE
            VisibleStatics := FALSE;

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        //   UserSetup.SETRANGE("Salesperson User", TRUE);
        IF UserSetup.FINDFIRST THEN
            Editable := FALSE
        ELSE
            Editable := TRUE;

    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        RecCustomer: Record 18;
        RecLocation: Record 14;
        ILE: Record 32;
        SL: Record 37;
        TotalRemainingQty: Decimal;
        SLQty: Decimal;
        TotalRemainingQty1: Decimal;
        GSTLocRegNo: Boolean;
        IsRateChangeEnabled: Boolean;
        Visible: Boolean;
        RemQty: Decimal;
        Editable: Boolean;
        CheckApprovalEntry: Record 454;
        DeleteApprovalEntry: Record 454;
        totalQty: Decimal;
        ApprovalEntry: Record 454;
        ApproovalAmt: Decimal;
        SalesHeader36: Record 36;
        GSTMsg001: Label 'Customer Current Gst Status is %1.';
        VisibleStatics: Boolean;
        //  TemporaryCreditLimit: Record "Temporary Credit Limit";
        CreditLimitAmt: Decimal;
        Location: Record 14;
}