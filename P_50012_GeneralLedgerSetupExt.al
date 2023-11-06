pageextension 50012 GeneralLedgerSetupExt extends "General Ledger Setup"
{
    layout
    {
        addafter("Show Amounts")

        {
            field("Manual Sales WHT Calc."; Rec."Manual Sales WHT Calc.")
            {
                ApplicationArea = all;
            }
            field("Enable WHT"; Rec."Enable WHT") //Pru Neha
            {
                ApplicationArea = all;
            }
            field("Round Payment Amt for WHT"; Rec."Round Payment Amt for WHT")//Pru Neha
            {
                ApplicationArea = all;
            }
            field("Enable Tax Invoices"; rec."Enable Tax Invoices")
            {
                ApplicationArea = all;
            }
            field("Print Tax Invoices on Posting"; rec."Print Tax Invoices on Posting")
            {
                ApplicationArea = all;
            }
            field("Round Amount for WHT Calc"; rec."Round Amount for WHT Calc")
            {
                ApplicationArea = all;
            }
            field("Min. WHT Calc only on Inv. Amt"; rec."Min. WHT Calc only on Inv. Amt")
            {
                ApplicationArea = all;
            }
            field("Force Payment With Invoice"; rec."Force Payment With Invoice")
            {
                ApplicationArea = all;
            }
        }
        addafter("Shortcut Dimension 8 Code")
        {
            field("Shortcut Dimension 9"; Rec."Shortcut Dimension 9")
            {
                ApplicationArea = all;
                LookupPageId = "Dimension List";
            }
            field("Shortcut Dimension 10"; Rec."Shortcut Dimension 10")
            {
                ApplicationArea = all;
                LookupPageId = "Dimension List";
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access GL Setup", '%1', UserSetup."Access GL Setup"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to delete general ledger setup');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access GL Setup", '%1', UserSetup."Access GL Setup"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access GL Setup", '%1', UserSetup."Access GL Setup"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to Modify general ledger setup');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access GL Setup", '%1', UserSetup."Access GL Setup"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        Rec.RESET;

        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access GL Setup", '%1', UserSetup."Access GL Setup"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open GL Setup');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access GL Setup", '%1', UserSetup."Access GL Setup"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    var
        UserSetup: Record 91;
}