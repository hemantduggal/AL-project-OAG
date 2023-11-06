pageextension 50026 DimensionValuesExt extends "Dimension Values"
{
    layout
    {
        addafter(Name)
        {
            field("Recurring Projects"; Rec."Recurring Projects")
            {
                ApplicationArea = all;
            }
            field("Accounting Year"; Rec."Accounting Year")
            {
                caption = 'Financial Year';
                ApplicationArea = all;
            }
        }
        addafter("Dimension Value Type")
        {
            field("Dimension Type"; rec."Dimension Type")
            {
                ApplicationArea = all;
            }
        }

    }


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Dimension Values", '%1', UserSetup."Dimension Values"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnOpenPage()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Dimension Values", '%1', UserSetup."Dimension Values"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Dimension Values');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Dimension Values", '%1', UserSetup."Dimension Values"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Dimension Values", '%1', UserSetup."Dimension Values"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change Dimension Values Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Dimension Values", '%1', UserSetup."Dimension Values"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;

}