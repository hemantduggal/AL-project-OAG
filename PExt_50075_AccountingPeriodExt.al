pageextension 50075 AccountingPeriodExt extends "Accounting Periods"
{
    layout
    {
        addafter(Name)
        {
            field("Code Type"; Rec."Code Type")
            {
                ApplicationArea = all;
            }
            field(Quarter; Rec.Quarter)
            {
                ApplicationArea = all;
            }
        }
        /* modify("Date Locked")
         {
             Editable = true;
         }*/
    }
    actions
    {
        /*modify(post)
        {
            trigger OnBeforeAction()
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Accounting Periods", '<>%1', UserSetup."Accounting Periods"::Post);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Sales Invoice')
            end;
        }*/
    }

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Accounting Periods", '%1', UserSetup."Accounting Periods"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the Accounting Periods');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Accounting Periods", '%1', UserSetup."Accounting Periods"::Post);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Accounting Periods');
        //ERROR('You do not have Permission to Delete Purchase Quote');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Accounting Periods", '%1', UserSetup."Accounting Periods"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //  ERROR('You do not have Permission to Change Purchase Quote Details');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Accounting Periods", '%1', UserSetup."Accounting Periods"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //    ERROR('You do not have Permission to Change Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Accounting Periods", '%1', UserSetup."Accounting Periods"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);


        //   ERROR('You do not have Permission to add new Purchase Quote Details');
        //PRU_DD 1.10
    end;

    trigger OnAfterGetRecord()
    begin
        if (rec.Name = 'July      ') or (rec.Name = 'August    ') or (rec.Name = 'September ') then begin
            rec.Quarter := rec.Quarter::Q1;
            rec.Modify();
        end
        else
            if (rec.Name = 'October   ') or (rec.Name = 'November  ') or (rec.Name = 'December  ') then begin
                rec.Quarter := rec.Quarter::Q2;
                rec.Modify();
            end
            else
                if (rec.Name = 'January   ') or (rec.Name = 'February  ') or (rec.Name = 'March     ') then begin
                    rec.Quarter := rec.Quarter::Q3;
                    rec.Modify();
                end
                else begin
                    rec.Quarter := rec.Quarter::Q4;
                    rec.Modify();
                end;
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Accounting Periods", '%1', UserSetup."Accounting Periods"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;


    trigger OnOpenPage()
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Accounting Periods", '%1', UserSetup."Accounting Periods"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Accounting Periods');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Accounting Periods", '%1', UserSetup."Accounting Periods"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnClosePage()
    var
        acc: Record "Accounting Period";
    begin
        acc.SetFilter("New Fiscal Year", 'True');
        if acc.FindSet() then begin
            repeat
                acc.TestField("Code Type");
            until acc.Next() = 0;
        end;
    end;



    var
        myInt: Integer;
        UserSetup: Record 91;
}