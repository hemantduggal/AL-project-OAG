pageextension 50019 PostedSalesInvoicesExt extends "Posted Sales Invoices"
{
    layout
    {
        addafter("No.")
        {

        }
    }

    trigger OnAfterGetRecord()
    begin
        //     IF UserSetup."Salesperson User" THEN
        //        Rec.SETRANGE("Salesperson Code", USERID);
    end;

    trigger OnOpenPage()
    var

    begin
        //<<PRU_RC
        /*   UserSetup.GET(USERID);
           Rec.FILTERGROUP(2);
           Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
           IF NOT UserSetup."HO Users" THEN BEGIN
               Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
               // Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
               Rec.FILTERGROUP(0);
    END;*/


        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        //   UserSetup.SETRANGE("Salesperson User", TRUE);
        IF UserSetup.FINDFIRST THEN
            Visible := FALSE
        ELSE
            Visible := TRUE;
    end;

    var
        UserSetup: Record 91;
        Visible: Boolean;
        SalesPost: Codeunit 80;
        // TempBlob: Record 99008535;
        SalesInvoiceHeader: Record 112;


}